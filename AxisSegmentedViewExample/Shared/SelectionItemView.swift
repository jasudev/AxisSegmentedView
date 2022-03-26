//
//  SelectionItemView.swift
//  AxisSegmentedViewExample
//
//  Created by jasu on 2022/03/23.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisSegmentedView

struct SelectionItemView: View {
    
    @EnvironmentObject private var stateValue: ASStateValue
    @State private var scale: CGFloat = 1
    
    let iconName: String
    
    init(_ iconName: String) {
        self.iconName = iconName
    }
    
    var body: some View {
        Image(systemName: iconName)
            .foregroundColor(Color.white)
            .scaleEffect(scale)
            .onAppear {
                scale = 1
                if !stateValue.isInitialRun {
                    withAnimation(.easeInOut(duration: 0.26)) {
                        scale = 1.2
                    }
                    withAnimation(.easeInOut(duration: 0.26).delay(0.26)) {
                        scale = 1
                    }
                }
            }
    }
}
