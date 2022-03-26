//
//  View+Extensions.swift
//  AxisSegmentedView
//
//  Created by jasu on 2022/03/07.
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

extension View {
    public func itemTag<SelectionValue: Hashable>(_ tag: SelectionValue, selectArea: CGFloat = 0) -> some View {
        modifier(ASItemModifier(tag: tag, selectArea: selectArea))
    }
    
    public func itemTag<SelectionValue: Hashable, S: View>(_ tag: SelectionValue,
                                                           selectArea: CGFloat = 0,
                                                           @ViewBuilder select: @escaping () -> S) -> some View {
        modifier(ASItemModifier(tag: tag, selectArea: selectArea, select: select()))
    }
    
    public func outerShadow(offset: CGFloat = 2, radius: CGFloat = 2, opacity: CGFloat = 1, isDark: Bool = true) -> some View {
        modifier(NeumorphismOuterModifier(offset: offset, radius: radius, opacity: opacity, isDark: isDark))
    }
    
    public func innerShadow<S : Shape>(_ content: S, radius: CGFloat = 6, opacity: CGFloat = 1, isDark: Bool = true) -> some View {
        modifier(NeumorphismInnerModifier(shape: content, radius: radius, opacity: opacity, isDark: isDark))
    }
    
    func reverseMask<M>(_ mask: M) -> some View where M: View {
        self.mask(
            mask
                .background(Color.white)
                .foregroundColor(.black)
                .compositingGroup()
                .luminanceToAlpha()
        )
    }
}
