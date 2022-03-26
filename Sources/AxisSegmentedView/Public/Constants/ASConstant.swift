//
//  ASConstant.swift
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

/// Motion effect mode in style.
public enum ASMovementMode: Hashable {
    case normal
    case viscosity
}

/// The object position mode in style.
public enum ASEdgeMode: Hashable {
    case topLeading
    case bottomTrailing
}

/// The axis mode of the segmented view.
public enum ASAxisMode: Hashable {
    case horizontal
    case vertical
}

/// Defines the settings for the segmented view.
public struct ASConstant: Equatable {
    
    /// The axis mode of the segmented view.
    public var axisMode: ASAxisMode

    /// Defines the line between the tab buttons.
    public var divideLine: ASLineConstant
    
    /// Activate the geometry effect.
    public var isActivatedGeometryEffect: Bool
    
    /// Activate the device's vibration. Only iOS is supported.
    public var isActivatedVibration: Bool
    
    /// A transition when a tab is selected.
    public var transition: AnyTransition
    
    /// Animation when selecting a tab.
    public var animation: Animation?
    
    
    /// Initializes `ASConstant`
    /// - Parameters:
    ///   - axisMode: The axis mode of the segmented view.
    ///   - divideLine: Defines the line between the tab buttons.
    ///   - isActivatedGeometryEffect: Whether to use a GeometryEffect when switching tab buttons.
    ///   - isActivatedVibration: Activate the device's vibration. Only iOS is supported.
    ///   - transition: A transition when a tab is selected.
    ///   - animation: Animation when selecting a tab.
    public init(axisMode: ASAxisMode = .horizontal,
                divideLine: ASLineConstant = .init(),
                isActivatedGeometryEffect: Bool = true,
                isActivatedVibration: Bool = true,
                transition: AnyTransition = .opacity,
                animation: Animation? = .easeInOut) {
        self.axisMode = axisMode
        self.divideLine = divideLine
        self.isActivatedGeometryEffect = isActivatedGeometryEffect
        self.isActivatedVibration = isActivatedVibration
        self.transition = transition
        self.animation = animation
    }
    
    public static func == (lhs: ASConstant, rhs: ASConstant) -> Bool {
        lhs.axisMode == rhs.axisMode &&
        lhs.divideLine == rhs.divideLine &&
        lhs.isActivatedGeometryEffect == rhs.isActivatedGeometryEffect &&
        lhs.isActivatedVibration == rhs.isActivatedVibration &&
        lhs.animation == rhs.animation
    }
}
