//
//  ASViscosityStyle.swift
//  AxisSegmentedView
//
//  Created by jasu on 2022/03/22.
//  Copyright (c) 2022 jasu All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished
//  to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
//  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
//  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import SwiftUI

/// Viscosity movement style for segmented view.
public struct ASViscosityStyle<Content>: View where Content: View {
    
    @EnvironmentObject var stateValue: ASStateValue
    @State private var currentFrame: CGRect = .zero
    
    public var animation: Animation
    public var selectionView: (CGRect) -> Content
    
    public init(_ animation: Animation = .axisSegmentedSpring,
                @ViewBuilder selectionView: @escaping (CGRect) -> Content) {
        self.animation = animation
        self.selectionView = selectionView
    }
    
    private var content: some View {
        selectionView(currentFrame)
            .frame(width: currentFrame.width, height: currentFrame.height)
            .offset(x: currentFrame.origin.x, y: currentFrame.origin.y)
    }
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
            Color.clear
            content
        }
        .onAppear {
            currentFrame = stateValue.selectionFrame
        }
        .onChange(of: stateValue.selectionFrame) { newValue in
            if stateValue.isInitialRun {
                currentFrame = newValue
            }else {
                withAnimation(.easeInOut(duration: 0.24)) {
                    currentFrame = getExpandRect()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.24) {
                    withAnimation(animation) {
                        currentFrame = newValue
                    }
                }
            }
        }
    }
    
    private func getExpandRect() -> CGRect {
        let selectionFrame = stateValue.selectionFrame
        let previousFrame = stateValue.previousFrame
        if stateValue.previousIndex < stateValue.selectionIndex {
            if stateValue.constant.axisMode == .horizontal {
                return CGRect(x: currentFrame.origin.x,
                              y: currentFrame.origin.y,
                              width: selectionFrame.origin.x + selectionFrame.width - currentFrame.origin.x,
                              height: selectionFrame.height)
            }else {
                return CGRect(x: currentFrame.origin.x,
                              y: currentFrame.origin.y,
                              width: selectionFrame.width,
                              height: selectionFrame.origin.y + selectionFrame.height - currentFrame.origin.y)
            }
        }else {
            if stateValue.constant.axisMode == .horizontal {
                return CGRect(x: selectionFrame.origin.x,
                              y: selectionFrame.origin.y,
                              width: currentFrame.origin.x + currentFrame.width - selectionFrame.origin.x,
                              height: previousFrame.height)
            }else {
                return CGRect(x: selectionFrame.origin.x,
                              y: selectionFrame.origin.y,
                              width: previousFrame.width,
                              height: currentFrame.origin.y + currentFrame.height - selectionFrame.origin.y)
            }
        }
    }
}

struct ASViscosityStyle_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedViewPreview(constant: .init(axisMode: .horizontal, divideLine: .init(color: .blue.opacity(0.4), scale: 0.34))) {
            ASViscosityStyle { rect in
                RoundedRectangle(cornerRadius: 11)
                    .stroke(lineWidth: 1)
                    .fill(Color.blue)
                    .padding(1)
            }
                .preferredColorScheme(.dark)
        }
        .frame(height: 44)
        .padding(.horizontal, 16)
    }
}
