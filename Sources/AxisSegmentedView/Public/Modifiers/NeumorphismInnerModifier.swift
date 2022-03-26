//
//  NeumorphismInnerModifier.swift
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

public struct NeumorphismInnerModifier<T: Shape> : ViewModifier {
    
    public var lightColor: Color = .clear
    public var darkColor: Color = .clear
    
    public var shape: T
    public var radius: CGFloat
    public var opacity: CGFloat
    public var isDark: Bool
    
    public init(shape: T, radius: CGFloat = 10, opacity: CGFloat = 1, isDark: Bool = true) {
        
        self.shape = shape
        self.radius = radius
        self.opacity = opacity
        self.isDark = isDark
        
        if isDark {
            lightColor = .white.opacity(0.35)
            darkColor = .black.opacity(1.0)
        }else {
            lightColor = .white.opacity(1.0)
            darkColor = .black.opacity(0.35)
        }
    }
    
    public func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { proxy in
                    self.shape.fill(self.lightColor.opacity(shadowOpacity()))
                        .reverseMask(
                            self.shape.offset(x: -self.shadowOffset(proxy), y: -self.shadowOffset(proxy))
                        )
                        .blur(radius: self.radius)
                        .offset(x: self.shadowOffset(proxy) , y: self.shadowOffset(proxy))
                        .overlay(
                            self.shape.fill(self.darkColor.opacity(shadowOpacity()))
                                .reverseMask(
                                    self.shape.offset(x: self.shadowOffset(proxy), y: self.shadowOffset(proxy))
                                )
                                .blur(radius: self.radius)
                                .offset(x: -self.shadowOffset(proxy) , y: -self.shadowOffset(proxy))
                        )
                        .mask(self.shape)
                }
            )
    }
    
    private func shadowOpacity() -> CGFloat {
        return 3 * max(min(opacity, 1), 0)
    }
    
    private func shadowOffset(_ proxy: GeometryProxy) -> CGFloat {
        return (proxy.size.width < proxy.size.height ? proxy.size.width : proxy.size.height) * 0.02
    }
}

struct NeumorphismInnerModifier_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedViewPreview(constant: .init(axisMode: .horizontal)) {
            ASNeumorphismStyle(cornerRadius: 16, isInner: false)
        }
        .frame(height: 44)
        .padding(.horizontal, 16)
        .preferredColorScheme(.dark)
    }
}
