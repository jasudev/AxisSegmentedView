//
//  NeumorphismValue.swift
//  AxisSegmentedViewExample
//
//  Created by jasu on 2022/03/23.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisSegmentedView

class NeumorphismValue: ObservableObject {
    
    @Published var constant = ASConstant(divideLine: .init(color: Color(hex: 0x444444), scale: 0))
    
    @Published var backgroundColor: Color = .clear
    @Published var foregroundColor: Color = .clear
    @Published var cornerRadius: CGFloat = 11
    @Published var padding: CGFloat = 12
    @Published var shadowRadius: CGFloat = 5
    @Published var shadowOpacity: CGFloat = 0.7
    @Published var isInner: Bool = false
    @Published var movementMode: ASMovementMode = .viscosity

    @Published var selectArea0: CGFloat = 0
    @Published var selectArea1: CGFloat = 0
    @Published var selectArea2: CGFloat = 0
    @Published var selectArea3: CGFloat = 0
    
    init(backgroundColor: Color = Color(hex: 0x31353A),
         foregroundColor: Color = Color(hex: 0x31353A),
         cornerRadius: CGFloat = 11,
         padding: CGFloat = 12,
         shadowRadius: CGFloat = 5,
         shadowOpacity: CGFloat = 0.7,
         isInner: Bool = false,
         movementMode: ASMovementMode = .viscosity) {
        
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.shadowRadius = shadowRadius
        self.isInner = isInner
        self.movementMode = movementMode
    }
}
