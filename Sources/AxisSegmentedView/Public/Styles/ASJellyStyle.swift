//
//  ASJellyStyle.swift
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

/// Jelly style for segmented view.
public struct ASJellyStyle: View {
    
    @EnvironmentObject var stateValue: ASStateValue
    
    public var backgroundColor: Color
    public var foregroundColor: Color
    public var jellyRadius: CGFloat
    public var jellyDepth: CGFloat
    public var jellyEdge: ASEdgeMode
    public var animation: Animation
    
    @State private var currentFrame: CGRect = .zero
    @State private var depth: CGFloat = 0
    
    public init(backgroundColor: Color = .gray.opacity(0.1),
                foregroundColor: Color = .purple,
                jellyRadius: CGFloat = 56,
                jellyDepth: CGFloat = 0.9,
                jellyEdge: ASEdgeMode = .bottomTrailing,
                animation: Animation = .axisSegmentedSpring) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.jellyRadius = jellyRadius
        self.jellyDepth = jellyDepth
        self.jellyEdge = jellyEdge
        self.animation = animation
    }
    
    private var jellyView: some View {
        ZStack {
            if stateValue.constant.axisMode == .horizontal {
                ZStack {
                    Color.clear
                    Rectangle()
                        .fill(backgroundColor)
                    Rectangle()
                        .fill(foregroundColor)
                        .reverseMask(
                            ASCurveShape(radius: jellyRadius, depth: depth, position: currentFrame.midX / stateValue.size.width)
                                .fill(.black)
                                .scaleEffect(CGSize(width: 1, height: jellyEdge == .bottomTrailing ? -1 : 1))
                        )
                        .mask(
                            Rectangle()
                                .fill(foregroundColor)
                        )
                }
            }else {
                ZStack {
                    Color.clear
                    Rectangle()
                        .fill(backgroundColor)
                        .frame(width: stateValue.size.width)
                    Rectangle()
                        .fill(foregroundColor)
                        .frame(width: stateValue.size.height + 1, height: stateValue.size.width + 1)
                        .reverseMask(
                            ASCurveShape(radius: jellyRadius, depth: depth, position: currentFrame.midY / stateValue.size.height)
                                .fill(.black)
                        )
                        .mask(
                            Rectangle()
                                .fill(foregroundColor)
                        )
                        .rotationEffect(Angle(degrees: 90))
                        .scaleEffect(CGSize(width: jellyEdge == .bottomTrailing ? 1 : -1, height: 1))
                }
            }
        }
        .onAppear {
            self.currentFrame = stateValue.selectionFrame
        }
    }
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
            jellyView
            ASNormalStyle(animation) { rect in
                Color.clear
                    .onChange(of: rect) { newValue in
                        updateUI()
                        withAnimation(animation) {
                            self.currentFrame = newValue
                        }
                    }
            }
        }
        .onChange(of: jellyDepth, perform: { newValue in
            depth = newValue
        })
        .animation(animation, value: stateValue.selectionIndex)
    }
    
    private func updateUI() {
        withAnimation(.easeInOut(duration: 0.16)) {
            depth = 0.4
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.5)) {
                depth = jellyDepth
            }
        }
    }
}

struct ASJellyStyle_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedViewPreview(constant: .init(axisMode: .horizontal)) {
            ASJellyStyle()
        }
        .frame(height: 44)
        .padding(.horizontal, 16)
        .preferredColorScheme(.dark)
//        SegmentedViewPreview(constant: .init(axisMode: .vertical)) {
//            ASJellyStyle()
//        }
//        .frame(width: 50)
//        .padding(.horizontal, 16)
//        .preferredColorScheme(.dark)
    }
}
