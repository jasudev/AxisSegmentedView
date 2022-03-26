//
//  SegmentedViewPreview.swift
//  AxisSegmentedView
//
//  Created by jasu on 2022/03/18.
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

/// This is a preview for testing.
public struct SegmentedViewPreview<S>: View where S : View {
    
    @State private var selection: Int = 0
    private let constant: ASConstant
    private let style: () -> S
    
    public init(constant: ASConstant = .init(), @ViewBuilder style: @escaping () -> S) {
        self.constant = constant
        self.style = style
    }
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.clear
                AxisSegmentedView(selection: $selection, constant: constant, {
                    iconGroup
                }, style: {
                    style()
                })
                .font(.system(size: 20))
            }
        }
    }
    
    var iconGroup: some View {
        Group {
            Image(systemName: "align.horizontal.left")
                .itemTag(0, selectArea: 0) {
                    Image(systemName: "align.horizontal.left.fill").foregroundColor(Color.white)
                }
            Image(systemName: "align.horizontal.right")
                .itemTag(1, selectArea: 0) {
                    Image(systemName: "align.horizontal.right.fill").foregroundColor(Color.white)
                }
            Image(systemName: "align.vertical.top")
                .itemTag(2, selectArea: 160) {
                    Image(systemName: "align.vertical.top.fill").foregroundColor(Color.white)
                }
            Image(systemName: "align.vertical.bottom")
                .itemTag(3, selectArea: 0) {
                    Image(systemName: "align.vertical.bottom.fill").foregroundColor(Color.white)
                }
        }
    }
    
    var textGroup: some View {
        Group {
            Text("버튼1")
                .font(.callout)
                .frame(width: 60)
                .itemTag(0, selectArea: 0) {
                    Text("버튼")
                        .font(.callout)
                }
            Text("버튼2")
                .font(.callout)
                .itemTag(1, selectArea: 0) {
                    Text("버튼22")
                        .font(.callout)
                }
            Text("버튼3")
                .font(.callout)
                .itemTag(2, selectArea: 160) {
                    Text("버튼33")
                        .font(.callout)
                }
            Text("버튼4")
                .font(.callout)
                .itemTag(3, selectArea: 0) {
                    Text("버튼44")
                        .font(.callout)
                }
        }
    }
}

struct SegmentedViewPreview_previews: PreviewProvider {
    static var previews: some View {
        SegmentedViewPreview(constant: .init()) {
            ASBasicStyle()
        }
        .frame(height: 44)
        .padding(.horizontal, 16)
    }
}

