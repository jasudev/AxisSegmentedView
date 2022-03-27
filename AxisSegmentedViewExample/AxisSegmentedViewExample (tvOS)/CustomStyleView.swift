//
//  CustomStyleView.swift
//  AxisSegmentedViewExample
//
//  Created by jasu on 2022/03/26.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisSegmentedView

struct CustomStyleView: View {
    
    @State private var selection: Int = 0
    
    var body: some View {
        AxisSegmentedView(selection: $selection, constant: .init()) {
            Image(systemName: "align.horizontal.left")
                .itemTag(0, selectArea: 0) {
                    SelectionItemView("align.horizontal.left.fill")
                }
            Image(systemName: "align.horizontal.right")
                .itemTag(1, selectArea: 560) {
                    SelectionItemView("align.horizontal.right.fill")
                }
            Image(systemName: "align.vertical.top")
                .itemTag(2, selectArea: 0) {
                    SelectionItemView("align.vertical.top.fill")
                }
            Image(systemName: "align.vertical.bottom")
                .itemTag(3, selectArea: 560) {
                    SelectionItemView("align.vertical.bottom.fill")
                }
        } style: {
            CustomStyle(color: .red)
        }
        .frame(height: 80)
    }
}

struct CustomStyleView_Previews: PreviewProvider {
    static var previews: some View {
        CustomStyleView()
    }
}
