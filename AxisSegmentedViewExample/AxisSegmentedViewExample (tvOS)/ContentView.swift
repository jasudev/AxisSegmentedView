//
//  ContentView.swift
//  AxisSegmentedViewExample
//
//  Created by jasu on 2022/03/27.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisSegmentedView

struct ContentView: View {
    
    @State private var tabViewSelection: Int = 0

    var body: some View {
        TabView(selection: $tabViewSelection) {
            SegmentedListView(axisMode: .horizontal)
                .tag(0)
                .tabItem {
                    Image(systemName: "rectangle.arrowtriangle.2.inward")
                    Text("Horizontal")
                }
            
            SegmentedListView(axisMode: .vertical)
                .tag(1)
                .tabItem {
                    Image(systemName: "rectangle.portrait.arrowtriangle.2.inward")
                    Text("Vertical")
                }
            
            WithoutStyleView()
                .tag(2)
                .tabItem {
                    Image(systemName: "cpu")
                    Text("Without style")
                }
            
            CustomStyleView()
                .tag(3)
                .tabItem {
                    Image(systemName: "skew")
                    Text("Custom Style")
                }
                .padding()
        }
        .navigationTitle(Text("AxisSegmentedView"))
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
