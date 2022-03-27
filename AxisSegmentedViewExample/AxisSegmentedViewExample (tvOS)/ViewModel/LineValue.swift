//
//  LineValue.swift
//  AxisSegmentedViewExample
//
//  Created by jasu on 2022/03/23.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisSegmentedView

class LineValue: ObservableObject {
    
    @Published var constant = ASConstant(divideLine: .init(color: Color(hex: 0x202020), scale: 0))
    
    @Published var lineColor: Color = .blue
    @Published var lineSmallWidth: CGFloat = 2
    @Published var lineLargeScale: CGFloat = 1.0
    @Published var lineEdge: ASEdgeMode = .bottomTrailing
    @Published var movementMode: ASMovementMode = .viscosity
    
    @Published var selectArea0: CGFloat = 0
    @Published var selectArea1: CGFloat = 0
    @Published var selectArea2: CGFloat = 0
    @Published var selectArea3: CGFloat = 0
}
