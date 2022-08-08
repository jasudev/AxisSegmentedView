
//
//  AxisSegmentedView.swift
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

public struct AxisSegmentedView<SelectionValue, Content, Style> : View where SelectionValue : Hashable, Content : View, Style : View {
    
    @StateObject private var stateValue: ASStateValue = .init()
    @StateObject private var positionValue: ASPositionValue<SelectionValue> = .init()
    @State private var currentSize: CGSize = .zero
    
    private let selectionValue: ASSelectionValue<SelectionValue>
    private let constant: ASConstant
    
    public var content: () -> Content
    public var style: (() -> Style)? = nil
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                if currentSize != proxy.size {
                    if positionValue.toggleSelectArea {
                        getContent(proxy)
                    }else {
                        getContent(proxy)
                    }
                }else {
                    if positionValue.toggleSelectArea {
                        getContent(proxy)
                    }else {
                        getContent(proxy)
                    }
                }
            }
        }
        .animation(constant.animation ?? .none, value: selectionValue.selection)
        .environmentObject(selectionValue)
        .environmentObject(positionValue)
        .environmentObject(stateValue)
        .onChange(of: constant) { newValue in
            stateValue.constant = newValue
            positionValue.constant = newValue
        }
    }
    
    private func getContent(_ proxy: GeometryProxy) -> some View {
        ZStack {
            Color.clear
            if constant.axisMode == .horizontal {
                HStack(spacing: 0) {
                    content()
                }
            }else {
                VStack(spacing: 0) {
                    content()
                }
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                positionValue.isHasStyle = self.style != nil
                currentSize = proxy.size
            }
        }
        .backgroundPreferenceValue(ASItemPreferenceKey.self) { items in
            getBackground(items, size: proxy.size)
        }
    }

    private func getBackground(_ items: [ASItem], size: CGSize) -> some View {
        return Color.clear
            .overlay(style?())
            .onAppear {
                positionValue.constant = constant
                positionValue.items = items
                positionValue.size = size
            }
    }
}

public extension AxisSegmentedView where SelectionValue: Hashable, Content: View, Style: View {
    
    /// Initializes `AxisSegmentedView`
    /// - Parameters:
    ///   - selection: The currently selected tap value.
    ///   - constant: A constant value for segmented view.
    ///   - content: Content views with tab items applied.
    ///   - style: The style of the segmented view.
    ///   - onTapReceive: Method that treats the currently selected tab as imperative syntax.
    init(selection: Binding<SelectionValue>,
         constant: ASConstant = .init(),
         @ViewBuilder _ content: @escaping () -> Content,
         @ViewBuilder style: @escaping () -> Style,
         onTapReceive: ((SelectionValue) -> Void)? = nil) {
        
        self.selectionValue = ASSelectionValue(selection: selection, onTapReceive: onTapReceive)
        self.constant = constant
        self.style = style
        self.content = content
    }
}

public extension AxisSegmentedView where SelectionValue: Hashable, Content: View, Style == EmptyView {
    
    /// Initializes `AxisSegmentedView`
    /// - Parameters:
    ///   - selection: The currently selected tap value.
    ///   - constant: A constant value for segmented view.
    ///   - content: Content views with tab items applied.
    ///   - onTapReceive: Method that treats the currently selected tab as imperative syntax.
    init(selection: Binding<SelectionValue>,
         constant: ASConstant = .init(),
         @ViewBuilder _ content: @escaping () -> Content,
         onTapReceive: ((SelectionValue) -> Void)? = nil) {
        
        self.selectionValue = ASSelectionValue(selection: selection, onTapReceive: onTapReceive)
        self.constant = constant
        self.content = content
    }
}
