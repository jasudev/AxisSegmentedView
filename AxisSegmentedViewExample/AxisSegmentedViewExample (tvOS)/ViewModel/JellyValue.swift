//
//  JellyValue.swift
//  AxisSegmentedViewExample
//
//  Created by jasu on 2022/03/23.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisSegmentedView

class JellyValue: ObservableObject {
    
    @Published var constant = ASConstant(divideLine: .init(color: Color(hex: 0x444444), scale: 0))
    
    @Published var backgroundColor: Color = .gray.opacity(0.1)
    @Published var foregroundColor: Color = .purple
    @Published var jellyRadius: CGFloat = 110
    @Published var jellyDepth: CGFloat = 0.9
    @Published var jellyEdge: ASEdgeMode = .bottomTrailing
    
    @Published var selectArea0: CGFloat = 0
    @Published var selectArea1: CGFloat = 0
    @Published var selectArea2: CGFloat = 0
    @Published var selectArea3: CGFloat = 0
}
