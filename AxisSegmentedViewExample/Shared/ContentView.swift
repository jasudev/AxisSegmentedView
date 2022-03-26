//
//  ContentView.swift
//  AxisSegmentedViewExample
//
//  Created by jasu on 2022/03/18.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisSegmentedView

struct ContentView: View {
    
    @State private var tabViewSelection: Int = 0
    
    private var content: some View {
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
    }
    var body: some View {
        ZStack {
#if os(iOS)
            NavigationView {
                content
                    .navigationBarTitleDisplayMode(.inline)
            }
            .navigationViewStyle(.stack)
#else
            content
                .padding()
#endif
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
