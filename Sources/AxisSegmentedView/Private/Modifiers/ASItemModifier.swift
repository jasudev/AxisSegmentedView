//
//  ASItemModifier.swift
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

struct ASItemPreferenceKey: PreferenceKey {
    typealias Value = [ASItem]
    static var defaultValue: [ASItem] = []
    static func reduce(value: inout [ASItem], nextValue: () -> [ASItem]) {
        value.append(contentsOf: nextValue())
    }
}

struct ASItemModifier<SelectionValue: Hashable, S: View>: ViewModifier {
    
    @EnvironmentObject private var stateValue: ASStateValue
    @EnvironmentObject private var selectionValue: ASSelectionValue<SelectionValue>
    @EnvironmentObject private var positionValue: ASPositionValue<SelectionValue>
    @Namespace private var namespace
    
    var tag: SelectionValue
    var selectArea: CGFloat
    var select: S? = nil
    
    var normalSize: CGSize {
        if positionValue.constant.axisMode == .horizontal {
            return CGSize(width: positionValue.getNormalArea(selectionValue.selection),
                          height: positionValue.size.height)
        }else {
            return CGSize(width: positionValue.size.width,
                          height: positionValue.getNormalArea(selectionValue.selection))
        }
    }
    
    var selectSize: CGSize {
        if positionValue.constant.axisMode == .horizontal {
            return CGSize(width: positionValue.getSelectArea(selectionValue.selection),
                          height: positionValue.size.height)
        }else {
            return CGSize(width: positionValue.size.width,
                          height: positionValue.getSelectArea(selectionValue.selection))
        }
    }
    
    var divideLineView: some View {
        ZStack {
            if positionValue.constant.axisMode == .horizontal {
                Rectangle()
                    .fill(positionValue.constant.divideLine.color)
                    .frame(width: positionValue.constant.divideLine.width, height: positionValue.size.height)
                    .scaleEffect(CGSize(width: 1, height: positionValue.constant.divideLine.scale))
            }else {
                Rectangle()
                    .fill(positionValue.constant.divideLine.color)
                    .frame(width: positionValue.size.width, height: positionValue.constant.divideLine.width)
                    .scaleEffect(CGSize(width: positionValue.constant.divideLine.scale, height: 1))
            }
        }
    }
    
    func body(content: Content) -> some View {
        let item = ASItem(tag: tag, selectArea: selectArea, select: AnyView(select))
        Button {
            self.selectionValue.selection = tag
            self.stateValue.isInitialRun = false
            if positionValue.constant.isActivatedVibration { vibration() }
        } label: {
            ZStack(alignment: positionValue.constant.axisMode == .horizontal ? .leading : .top)  {
                ZStack{
                    if positionValue.isHasStyle {
                        getItemView(content)
                    }else {
                        ZStack {
                            content.opacity(tag != selectionValue.selection ? 1 : 0)
                            select?.opacity(tag == selectionValue.selection ? 1 : 0)
                        }
                    }
                }
                .frame(width: getItemSize().width, height: getItemSize().height)
                .preference(key: ASItemPreferenceKey.self, value: [item])
                
                if isShowDivideLine() {
                    ZStack {
                        if positionValue.constant.axisMode == .horizontal {
                            divideLineView
                                .offset(x: -positionValue.constant.divideLine.width * 0.5)
                                .matchedGeometryEffect(id: "DivideLine", in: namespace)
                        }else {
                            divideLineView
                                .offset(y: -positionValue.constant.divideLine.width * 0.5)
                                .matchedGeometryEffect(id: "DivideLine", in: namespace)
                        }
                    }
                }
            }
            .contentShape(Rectangle())
            .onAppear {
                self.setupStateValue()
            }
            .onChange(of: self.selectionValue.selection) { newValue in
                self.setupStateValue()
            }
            .onChange(of: selectArea) { newValue in
                positionValue.toggleSelectArea.toggle()
            }
        }
        .buttonStyle(.plain)
    }
    
    private func getItemSize() -> CGSize {
        if positionValue.constant.axisMode == .horizontal {
            return CGSize(width: tag == selectionValue.selection ? selectSize.width : normalSize.width, height: positionValue.size.height)
        }else {
            return CGSize(width: positionValue.size.width, height: tag == selectionValue.selection ? selectSize.height : normalSize.height)
        }
    }
    
    private func isShowDivideLine() -> Bool {
        let currentIndex = positionValue.indexOfTag(tag)
        let selectionIndex = positionValue.indexOfTag(selectionValue.selection)
        if positionValue.constant.divideLine.isShowSelectionLine {
            return currentIndex != 0
        }else {
            return currentIndex != 0 && currentIndex != selectionIndex && currentIndex != selectionIndex + 1
        }
    }
    
    private func getItemView(_ content: Content) -> some View {
        ZStack {
            if tag == selectionValue.selection {
                ZStack {
                    if let select = select {
                        select
                            .onAppear {
                                DispatchQueue.main.async {
                                    stateValue.previousIndex = stateValue.selectionIndex
                                    stateValue.previousFrame = positionValue.getSelectFrame(self.selectionValue.selection, selectionIndex: stateValue.selectionIndex)
                                    
                                    if positionValue.constant.axisMode == .horizontal {
                                        stateValue.otherSize = CGSize(width: normalSize.width, height: positionValue.size.height)
                                    }else {
                                        stateValue.otherSize = CGSize(width: positionValue.size.width, height: normalSize.height)
                                    }
                                }
                            }
                            .fixedSize()
                            .matchedGeometryEffect(id: stateValue.constant.isActivatedGeometryEffect ? "ITEM-NAMESPACE-ID" : "\(UUID())", in: namespace)
                    }else {
                        content
                            .fixedSize()
                            .matchedGeometryEffect(id: stateValue.constant.isActivatedGeometryEffect ? "ITEM-NAMESPACE-ID" : "\(UUID())", in: namespace)
                    }
                }
            } else {
                content
                    .fixedSize()
                    .matchedGeometryEffect(id: stateValue.constant.isActivatedGeometryEffect ? "ITEM-NAMESPACE-ID" : "\(UUID())", in: namespace)
            }
        }
    }
    
    private func setupStateValue() {
        let selectionIndex = positionValue.indexOfTag(self.selectionValue.selection)
        stateValue.constant = positionValue.constant
        stateValue.itemCount = positionValue.itemCount
        stateValue.selectionIndex = selectionIndex
        stateValue.selectionFrame = positionValue.getSelectFrame(self.selectionValue.selection, selectionIndex: selectionIndex)
        stateValue.size = positionValue.size
    }
    
#if os(iOS)
    /// The device generates vibrations.
    /// - Parameter style: Vibration style.
    private func vibration(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .soft) {
        let feedback = UIImpactFeedbackGenerator(style: style)
        feedback.prepare()
        feedback.impactOccurred()
    }
#else
    private func vibration() {}
#endif
}

extension ASItemModifier where SelectionValue: Hashable, S: View {
    init(tag: SelectionValue, selectArea: CGFloat, select: S) {
        self.tag = tag
        self.selectArea = selectArea
        self.select = select
    }
}

extension ASItemModifier where SelectionValue: Hashable, S == EmptyView {
    init(tag: SelectionValue, selectArea: CGFloat) {
        self.tag = tag
        self.selectArea = selectArea
    }
}

struct ASItemModifier_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedViewPreview(constant: .init(axisMode: .horizontal, divideLine: .init(color: .blue.opacity(0.5)))) {
            ASBasicStyle()
        }
        .frame(height: 44)
        .padding(.horizontal, 16)
        .preferredColorScheme(.dark)
    }
}
