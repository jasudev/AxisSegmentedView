//
//  ScaleValue.swift
//  AxisSegmentedViewExample
//
//  Created by jasu on 2022/03/23.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisSegmentedView

class ScaleValue: ObservableObject {
    
    @Published var constant = ASConstant(divideLine: .init(color: Color(hex: 0x444444), scale: 0))
    
    @Published var backgroundColor: Color = .clear
    @Published var foregroundColor: Color = Color.blue
    @Published var cornerRadius: CGFloat = 11
    @Published var minimumScale: CGFloat = 0.1
    
    @Published var selectArea0: CGFloat = 0
    @Published var selectArea1: CGFloat = 0
    @Published var selectArea2: CGFloat = 0
    @Published var selectArea3: CGFloat = 0
}
