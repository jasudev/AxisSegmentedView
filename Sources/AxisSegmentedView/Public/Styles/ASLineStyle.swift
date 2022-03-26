//
//  ASLineStyle.swift
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

/// Line style for segmented view.
public struct ASLineStyle: View {
    
    @EnvironmentObject var stateValue: ASStateValue
    
    public var lineColor: Color
    public var lineSmallWidth: CGFloat
    public var lineLargeScale: CGFloat
    public var lineEdge: ASEdgeMode
    public var movementMode: ASMovementMode
    public var animation: Animation
    
    public init(lineColor: Color = .blue,
                lineSmallWidth: CGFloat = 2,
                lineLargeScale: CGFloat = 1,
                lineEdge: ASEdgeMode = .bottomTrailing,
                movementMode: ASMovementMode = .viscosity,
                animation: Animation = .axisSegmentedSpring) {
        self.lineColor = lineColor
        self.lineSmallWidth = lineSmallWidth
        self.lineLargeScale = lineLargeScale
        self.lineEdge = lineEdge
        self.movementMode = movementMode
        self.animation = animation
    }
    
    private var selectionView: some View {
        return Group {
            if lineEdge == .bottomTrailing {
                Spacer()
            }
            ZStack(alignment: .topLeading) {
                if stateValue.constant.axisMode == .horizontal {
                    Rectangle()
                        .fill(lineColor)
                        .frame(height: lineSmallWidth)
                        .scaleEffect(CGSize(width: lineLargeScale, height: 1))
                }else {
                    Rectangle()
                        .fill(lineColor)
                        .frame(width: lineSmallWidth)
                        .scaleEffect(CGSize(width: 1, height: lineLargeScale))
                }
            }
            if lineEdge == .topLeading {
                Spacer()
            }
        }
    }
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
            Color.clear
            if stateValue.constant.axisMode == .horizontal {
                switch movementMode {
                    case .normal: ASNormalStyle(animation) { _ in
                        VStack(spacing: 0) {
                            selectionView
                        }
                    }
                    case .viscosity: ASViscosityStyle(animation) { _ in
                        VStack(spacing: 0) {
                            selectionView
                        }
                    }
                }
            }else {
                switch movementMode {
                    case .normal: ASNormalStyle(animation) { _ in
                        HStack(spacing: 0) {
                            selectionView
                        }
                    }
                    case .viscosity: ASViscosityStyle(animation) { _ in
                        HStack(spacing: 0) {
                            selectionView
                        }
                    }
                }
            }
        }
        .animation(animation, value: stateValue.selectionIndex)
    }
}

struct ASLineStyle_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedViewPreview(constant: .init(axisMode: .horizontal, divideLine: .init(color: .blue.opacity(0.5), isShowSelectionLine: true))) {
            ASLineStyle(lineEdge: .bottomTrailing)
                .preferredColorScheme(.dark)
        }
        .frame(height: 44)
        .padding(.horizontal, 16)
    }
}
