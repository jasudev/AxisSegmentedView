//
//  BacisValue.swift
//  AxisSegmentedViewExample
//
//  Created by jasu on 2022/03/23.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisSegmentedView

class BasicValue: ObservableObject {
    
    @Published var constant = ASConstant(divideLine: .init(color: Color.white.opacity(0.2), scale: 0.3))
    
    @Published var backgroundColor: Color = .gray.opacity(0.3)
    @Published var foregroundColor: Color = .black.opacity(0.7)
    @Published var cornerRadius: CGFloat = 6
    @Published var padding: CGFloat = 3
    @Published var isApplySelectionCornerRadius: Bool = true
    @Published var movementMode: ASMovementMode = .viscosity
    
    @Published var selectArea0: CGFloat = 0
    @Published var selectArea1: CGFloat = 0
    @Published var selectArea2: CGFloat = 0
}
