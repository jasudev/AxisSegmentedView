//
//  ASScaleStyle.swift
//  AxisSegmentedView
//
//  Created by jasu on 2022/03/20.
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

/// Scale style for segmented view.
public struct ASScaleStyle: View {
    
    @EnvironmentObject var stateValue: ASStateValue
    
    public var backgroundColor: Color
    public var foregroundColor: Color
    public var cornerRadius: CGFloat
    public var minimumScale: CGFloat
    public var animation: Animation
    
    public init(backgroundColor: Color = .clear,
                foregroundColor: Color = Color.blue,
                cornerRadius: CGFloat = 11,
                minimumScale: CGFloat = 0.1,
                animation: Animation = .axisSegmentedSpring) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.cornerRadius = cornerRadius
        self.minimumScale = minimumScale
        self.animation = animation
    }

    @State private var scale: CGFloat = 1
    @State private var alpha: CGFloat = 1
    
    private var content: some View {
        ASNormalStyle(animation) { _ in
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(foregroundColor)
                .padding(3)
                .scaleEffect(scale)
                .opacity(alpha)
                .transition(.opacity)
        }
    }
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
            Color.clear
            content
        }
        .background(backgroundColor)
        .onChange(of: stateValue.selectionIndex) { newValue in
            withAnimation(.easeInOut(duration: 0.3)) {
                scale = minimumScale
                alpha = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(animation) {
                    scale = 1.0
                    alpha = 1.0
                }
            }
        }
    }
}

struct ASScaleStyle_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedViewPreview(constant: .init(axisMode: .horizontal, divideLine: .init(color: .blue.opacity(0.4), scale: 0.34))) {
            ASScaleStyle(cornerRadius: 5)
        }
        .frame(height: 44)
        .padding(.horizontal, 16)
        .preferredColorScheme(.dark)
    }
}
