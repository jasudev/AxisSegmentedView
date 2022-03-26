//
//  ASBasicStyle.swift
//  AxisSegmentedView
//
//  Created by jasu on 2022/03/12.
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

/// Basic style for segmented view.
public struct ASBasicStyle: View {
    
    @EnvironmentObject var stateValue: ASStateValue
    
    public var backgroundColor: Color
    public var foregroundColor: Color
    public var cornerRadius: CGFloat
    public var padding: CGFloat
    public var isApplySelectionCornerRadius: Bool
    public var movementMode: ASMovementMode
    public var animation: Animation
    
    public init(backgroundColor: Color = .gray,
                foregroundColor: Color = Color.blue,
                cornerRadius: CGFloat = 6,
                padding: CGFloat = 3,
                isApplySelectionCornerRadius: Bool = true,
                movementMode: ASMovementMode = .viscosity,
                animation: Animation = .axisSegmentedSpring) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.isApplySelectionCornerRadius = isApplySelectionCornerRadius
        self.movementMode = movementMode
        self.animation = animation
    }
    
    private var selectionView: some View {
        RoundedRectangle(cornerRadius: isApplySelectionCornerRadius ? cornerRadius : 0)
            .fill(foregroundColor)
            .padding(padding + 0.5)
    }
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(backgroundColor.opacity(0.2))
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(lineWidth: 1)
                        .fill(foregroundColor)
                )
                .padding(0.5)
            switch movementMode {
            case .normal: ASNormalStyle(animation) { _ in
                    selectionView
                }
                case .viscosity: ASViscosityStyle { _ in
                    selectionView
                }
            }
        }
        .mask(RoundedRectangle(cornerRadius: cornerRadius))
        .animation(animation, value: stateValue.selectionIndex)
    }
}

struct ASBasicStyle_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedViewPreview(constant: .init(divideLine: .init(color: .blue, width: 1, scale: 1))) {
            ASBasicStyle()
                .preferredColorScheme(.dark)
        }
        .frame(height: 44)
        .padding(.horizontal, 16)
    }
}
