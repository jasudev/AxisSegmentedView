//
//  ASLineConstant.swift
//  AxisSegmentedView
//
//  Created by jasu on 2022/03/20.
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

/// Defines the line between the tab buttons.
public struct ASLineConstant: Equatable {
    
    /// The color of the line.
    public var color: Color
    
    /// The short axis length of the line.
    public var width: CGFloat
    
    /// The length scale of the line's long axis.
    public var scale: CGFloat
    
    /// Whether to show the line around the selected tab.
    public var isShowSelectionLine: Bool
    
    /// Initializes `ASLineConstant`
    /// - Parameters:
    ///   - color: The color of the line.
    ///   - width: The short axis length of the line.
    ///   - scale: The length scale of the line's long axis.
    ///   - isShowSelectionLine: Whether to show the line around the selected tab.
    public init(color: Color = .clear, width: CGFloat = 1, scale: CGFloat = 0.6, isShowSelectionLine: Bool = false) {
        self.color = color
        self.width = width
        self.scale = scale
        self.isShowSelectionLine = isShowSelectionLine
    }
}
