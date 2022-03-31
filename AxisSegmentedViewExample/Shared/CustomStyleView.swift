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
        HStack {
            AxisSegmentedView(selection: $selection, constant: .init(axisMode: .vertical)) {
                Image(systemName: "align.horizontal.left")
                    .itemTag(0, selectArea: 0) {
                        SelectionItemView("align.horizontal.left.fill")
                    }
                Image(systemName: "align.horizontal.right")
                    .itemTag(1, selectArea: 260) {
                        SelectionItemView("align.horizontal.right.fill")
                    }
                Image(systemName: "align.vertical.top")
                    .itemTag(2, selectArea: 0) {
                        SelectionItemView("align.vertical.top.fill")
                    }
                Image(systemName: "align.vertical.bottom")
                    .itemTag(3, selectArea: 260) {
                        SelectionItemView("align.vertical.bottom.fill")
                    }
            } style: {
                CustomStyle(color: .blue)
            } onTapReceive: { selectionTap in
                /// Imperative syntax
                print("---------------------")
                print("Selection : ", selectionTap)
                print("Already selected : ", self.selection == selectionTap)
            }
            .frame(width: 44)
            
            AxisSegmentedView(selection: $selection, constant: .init()) {
                Image(systemName: "align.horizontal.left")
                    .itemTag(0, selectArea: 0) {
                        SelectionItemView("align.horizontal.left.fill")
                    }
                Image(systemName: "align.horizontal.right")
                    .itemTag(1, selectArea: 160) {
                        SelectionItemView("align.horizontal.right.fill")
                    }
                Image(systemName: "align.vertical.top")
                    .itemTag(2, selectArea: 0) {
                        SelectionItemView("align.vertical.top.fill")
                    }
                Image(systemName: "align.vertical.bottom")
                    .itemTag(3, selectArea: 160) {
                        SelectionItemView("align.vertical.bottom.fill")
                    }
            } style: {
                CustomStyle(color: .red)
            } onTapReceive: { selectionTap in
                /// Imperative syntax
                print("---------------------")
                print("Selection : ", selectionTap)
                print("Already selected : ", self.selection == selectionTap)
            }
            .frame(height: 44)
        }
    }
}

struct CustomStyleView_Previews: PreviewProvider {
    static var previews: some View {
        CustomStyleView()
    }
}
