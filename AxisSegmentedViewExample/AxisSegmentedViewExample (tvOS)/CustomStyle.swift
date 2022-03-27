//
//  CustomStyle.swift
//  AxisSegmentedViewExample
//
//  Created by jasu on 2022/03/25.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisSegmentedView

public struct CustomStyle: View {
    
    @EnvironmentObject var stateValue: ASStateValue

    let color: Color
    public init(color: Color = .purple) {
        self.color = color
    }
    
    private var selectionView: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color.yellow)
    }
    
    public var body: some View {
        let selectionFrame = stateValue.selectionFrame
        ZStack(alignment: .topLeading) {
            Color.clear
            RoundedRectangle(cornerRadius: 5)
                .stroke()
                .fill(color)
                .frame(width: selectionFrame.width, height: selectionFrame.height)
                .offset(x: selectionFrame.origin.x, y: selectionFrame.origin.y)
        }
        .animation(.easeInOut, value: stateValue.selectionIndex)
    }
}

struct CustomStyle_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedViewPreview(constant: .init()) {
            CustomStyle()
                .preferredColorScheme(.dark)
        }
        .frame(height: 44)
        .padding(.horizontal, 16)
    }
}
