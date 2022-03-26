//
//  NeumorphismOuterModifier.swift
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

public struct NeumorphismOuterModifier: ViewModifier {

    public var lightColor : Color = .clear
    public var darkColor : Color = .clear
    public var offset: CGFloat
    public var radius : CGFloat
    public var opacity: CGFloat
    
    public init(offset: CGFloat = 2, radius: CGFloat = 2, opacity: CGFloat = 1, isDark: Bool = true) {
        
        self.offset = offset
        self.radius = radius
        self.opacity = opacity
        
        if isDark {
            lightColor = .white.opacity(0.10)
            darkColor = .black.opacity(0.30)
        }else {
            lightColor = .white.opacity(1.0)
            darkColor = .black.opacity(0.20)
        }
    }
    
    public func body(content: Content) -> some View {
        content
            .shadow(color: lightColor.opacity(shadowOpacity()), radius: radius, x: -offset, y: -offset)
            .shadow(color: darkColor.opacity(shadowOpacity()), radius: radius, x: offset, y: offset)
    }
    
    private func shadowOpacity() -> CGFloat {
        return 3 * max(min(opacity, 1), 0)
    }
}

struct NeumorphismOuterModifier_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedViewPreview(constant: .init(axisMode: .vertical)) {
            ASNeumorphismStyle(cornerRadius: 25)
        }
        .frame(width: 50)
        .padding(.vertical, 16)
        .preferredColorScheme(.dark)
    }
}

