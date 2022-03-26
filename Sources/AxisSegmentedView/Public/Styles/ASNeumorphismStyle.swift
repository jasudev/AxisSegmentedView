//
//  ASNeumorphismStyle.swift
//  AxisSegmentedView
//
//  Created by jasu on 2022/03/19.
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

/// Neumorphism style for segmented view.
public struct ASNeumorphismStyle: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var stateValue: ASStateValue
    
    public var backgroundColor: Color
    public var foregroundColor: Color
    public var cornerRadius: CGFloat
    public var padding: CGFloat
    public var shadowRadius: CGFloat
    public var shadowOpacity: CGFloat
    public var isInner: Bool
    public var movementMode: ASMovementMode
    public var animation: Animation
    
    public init(backgroundColor: Color = .clear,
                foregroundColor: Color = .clear,
                cornerRadius: CGFloat = 11,
                padding: CGFloat = 3,
                shadowRadius: CGFloat = 5,
                shadowOpacity: CGFloat = 1,
                isInner: Bool = false,
                movementMode: ASMovementMode = .viscosity,
                animation: Animation = .axisSegmentedSpring) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
        self.isInner = isInner
        self.movementMode = movementMode
        self.animation = animation
    }
    
    public var body: some View {
        ZStack {
            if isInner {
                innerView
            }else {
                outerView
            }
        }
        .animation(animation, value: stateValue.selectionIndex)
    }
    
    private var innerView: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(getBackgroundColor())
                .outerShadow(radius: shadowRadius, opacity: shadowOpacity, isDark: colorScheme == .dark)
            
            switch movementMode {
                case .normal: ASNormalStyle(animation) { _ in
                    selectionView
                }
                case .viscosity: ASViscosityStyle(animation) { _ in
                    selectionView
                }
            }
        }
        .mask(RoundedRectangle(cornerRadius: cornerRadius))
    }
    
    private var outerView: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(getBackgroundColor())
                .innerShadow(RoundedRectangle(cornerRadius: cornerRadius), radius: shadowRadius, opacity: shadowOpacity, isDark: colorScheme == .dark)
            switch movementMode {
                case .normal: ASNormalStyle(animation) { _ in
                    selectionView
                }
                case .viscosity: ASViscosityStyle(animation) { _ in
                    selectionView
                }
            }
        }
        .mask(RoundedRectangle(cornerRadius: cornerRadius))
    }
    
    private var selectionView: some View {
        ZStack {
            if isInner {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(getForegroundColor())
                    .innerShadow(RoundedRectangle(cornerRadius: cornerRadius), radius: shadowRadius, opacity: shadowOpacity, isDark: colorScheme == .dark)
                    .padding(padding)
            }else {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(getForegroundColor())
                    .padding(padding)
                    .outerShadow(radius: shadowRadius, opacity: shadowOpacity, isDark: colorScheme == .dark)
            }
        }
    }
    
    private func getBackgroundColor() -> Color {
        return backgroundColor == .clear ? (colorScheme == .dark ? Color(red: 0.185, green: 0.190, blue: 0.202) : Color(red: 0.926, green: 0.942, blue: 0.952)) : backgroundColor
    }
    
    private func getForegroundColor() -> Color {
        return foregroundColor == .clear ? (colorScheme == .dark ? Color(red: 0.185, green: 0.190, blue: 0.202) : Color(red: 0.926, green: 0.942, blue: 0.952)) : foregroundColor
    }
}

struct ASNeumorphismStyle_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedViewPreview(constant: .init(axisMode: .horizontal)) {
            ASNeumorphismStyle(backgroundColor: .blue.opacity(0.5), cornerRadius: 25, shadowOpacity: 1, isInner: false)
                .preferredColorScheme(.dark)
        }
        .frame(height: 44)
        .padding(.horizontal, 16)
    }
}

