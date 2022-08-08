//
//  ASPositionValue.swift
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

/// A viewmodel that provides the state value of the tab button.
class ASPositionValue<SelectionValue: Hashable>: ObservableObject {
    
    @Published var size: CGSize = .zero
    @Published var items: [ASItem] = []
    @Published var toggleSelectArea: Bool = false
    @Published var isHasStyle: Bool = true
    @Published var constant: ASConstant = .init()
    
    var itemCount: Int {
        return items.count
    }
    
    var sizeArea: CGFloat {
        constant.axisMode == .horizontal ? size.width : size.height
    }
    
    func indexOfTag(_ tag: SelectionValue?) -> Int {
        guard let tag = tag else { return 0 }
        return items.firstIndex(where: {$0.tag as! SelectionValue == tag}) ?? 0
    }
    
    func getNormalArea(_ selection: SelectionValue?) -> CGFloat {
        let selectArea = getItemSelectArea(selection)
        let area: CGFloat = selectArea > 0 ? ((sizeArea - selectArea) / CGFloat(itemCount - 1)) : sizeArea / CGFloat(itemCount)
        return area > 0 ? area : 1
    }
    
    func getSelectArea(_ selection: SelectionValue?) -> CGFloat {
        let selectArea = getItemSelectArea(selection)
        let area: CGFloat = selectArea > 0 ? selectArea : sizeArea / CGFloat(itemCount)
        return area > 0 ? area : 1
    }
    
    func getSelectFrame(_ selection: SelectionValue?, selectionIndex: Int) -> CGRect {
        let normalArea = getNormalArea(selection)
        let selectArea = getSelectArea(selection)
        
        if constant.axisMode == .horizontal {
            return CGRect(x: normalArea * CGFloat(selectionIndex), y: 0, width: selectArea, height: size.height)
        }else {
            return CGRect(x: 0, y: normalArea * CGFloat(selectionIndex), width: size.width, height: selectArea)
        }
    }
    
    private func getItemSelectArea(_ selection: SelectionValue?) -> CGFloat {
        guard !items.isEmpty else { return 0 }
        let selectionIndex = indexOfTag(selection)
        return items[selectionIndex].selectArea
    }
}

struct ASPositionValue_previews: PreviewProvider {
    static var previews: some View {
        SegmentedViewPreview {
            ASBasicStyle()
        }
        .frame(height: 44)
        .padding(.horizontal, 16)
    }
}
