//
//  WithoutStyleView.swift
//  AxisSegmentedViewExample
//
//  Created by jasu on 2022/03/23.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisSegmentedView

struct WithoutStyleView: View {
    
    @State private var selection1: Int = 0
    @State private var constant1 = ASConstant(axisMode: .vertical)
    
    @State private var selection2: Int = 0
    @State private var constant2 = ASConstant(axisMode: .horizontal)

    var body: some View {
        VStack {
            AxisSegmentedView(selection: $selection1, constant: constant1) {
                TabViews()
            }
            .clipped()
            AxisSegmentedView(selection: $selection2, constant: constant2) {
                TabViews()
            }
            .clipped()
        }
    }
}

struct TabViews: View {
    
    @State private var maxArea1: CGFloat = 200
    @EnvironmentObject private var stateValue: ASStateValue
    
    let colors = [Color(hex: 0x295A76), Color(hex: 0x7FACAA), Color(hex: 0xEBF4CC), Color(hex: 0xE79875), Color(hex: 0xBA523C), Color(hex: 0x295A76)]
    
    var listView: some View {
        List(0...100, id: \.self) { index in
            Button {
                print("click")
            } label: {
                Text("Index \(index)")
            }
        }.listStyle(.plain)
    }
    
    var body: some View {
        Group {
            Rectangle()
                .fill(colors[0])
                .overlay(
                    Text("0")
                )
                .itemTag(0, selectArea: maxArea1) {
                    Rectangle()
                        .fill(.red)
                        .overlay(
                            Text("0")
                        )
                }
            Rectangle()
                .fill(colors[1])
                .overlay(
                    Text("1")
                )
                .itemTag(1, selectArea: maxArea1) {
                    listView
                }
            Rectangle()
                .fill(colors[2])
                .overlay(
                    Text("2")
                )
                .itemTag(2, selectArea: maxArea1) {
                    listView
                }
            Rectangle()
                .fill(colors[3])
                .overlay(
                    Text("3")
                )
                .itemTag(3, selectArea: maxArea1) {
                    listView
                }
        }
    }
}

struct WithoutStyleView_Previews: PreviewProvider {
    static var previews: some View {
        WithoutStyleView()
            .preferredColorScheme(.dark)
    }
}
