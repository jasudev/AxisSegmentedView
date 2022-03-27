//
//  SegmentedViewWithControl.swift
//  AxisSegmentedViewExample
//
//  Created by jasu on 2022/03/23.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisSegmentedView

struct SegmentedViewWithControl<Tabs: View, Style: View> : View {
    
    @State private var isShowControlView: Bool = false
    @State private var selection: Int = 0
    @State private var maxSelectArea: CGFloat = 0

    @EnvironmentObject private var normalValue:         NormalValue
    @EnvironmentObject private var viscosityValue:      ViscosityValue
    
    @EnvironmentObject private var basicValue:          BasicValue
    @EnvironmentObject private var capsuleValue:        CapsuleValue
    @EnvironmentObject private var jellyValue:          JellyValue
    @EnvironmentObject private var lineValue:           LineValue
    @EnvironmentObject private var neumorphismValue:    NeumorphismValue
    @EnvironmentObject private var scaleValue:          ScaleValue
    
    let title: String
    let styleType: StyleType
    let axisMode: ASAxisMode
    @Binding var constant: ASConstant
    let area: CGFloat
    var tabs: () -> Tabs
    var style: () -> Style
    
    init(title: String,
         styleType: StyleType,
         axisMode: ASAxisMode = .horizontal,
         constant: Binding<ASConstant>,
         area: CGFloat = 80,
         @ViewBuilder tabs: @escaping () -> Tabs,
         @ViewBuilder style: @escaping () -> Style) {
        self.title = title
        self.styleType = styleType
        self.axisMode = axisMode
        _constant = constant
        self.area = area
        self.tabs = tabs
        self.style = style
    }
    
    private var segmentedView: some View {
        AxisSegmentedView(selection: $selection, constant: constant, {
            tabs()
        }, style: {
            style()
        })
        .font(.system(size: 20))
    }
    
    private var controlView: some View {
        ZStack {
            Color(hex: 0x030303)
                .cornerRadius(8)
            ScrollView {
                VStack {
                    getStyleControlView()
                    VStack(alignment: .leading, spacing: 8) {
                        Text("● Divide Line").opacity(0.5).font(.caption)
                        HStack {
                            Text("isShowSelectionLine")
                            Spacer()
                            Toggle(isOn: $constant.divideLine.isShowSelectionLine) {}
                        }
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("● Active").opacity(0.5).font(.caption)
                        HStack {
                            Text("ActivatedGeometryEffect")
                            Spacer()
                            Toggle(isOn: $constant.isActivatedGeometryEffect) {}
                        }
                    }
                    .padding()
                }
            }
            .font(.footnote)
            .labelsHidden()
        }
    }
    
    var body: some View {
        ZStack {
            ZStack {
                if constant.axisMode == .horizontal {
                    segmentedView
                        .frame(height: area)
                }else {
                    segmentedView
                        .frame(width: area)
                }
            }
            .padding(10)
        }
        .background(
            GeometryReader { proxy in
                Color(hex: 0x15151A)
                    .cornerRadius(8)
                    .onAppear {
                        self.maxSelectArea = constant.axisMode == .horizontal ? proxy.size.width * 0.5 : proxy.size.height * 0.5
                    }
            }
        )
        .onAppear {
            DispatchQueue.main.async {
                constant.axisMode = axisMode
            }
        }
    }
    
    private func getStyleControlView() -> some View {
        Group {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("● " + title).opacity(0.5).font(.caption)
                    Spacer()
                }
                switch styleType {
                case .ASBasicStyle:
                    Group {
                        HStack {
                            Text("isApplySelectionCornerRadius")
                            Spacer()
                            Toggle(isOn: $basicValue.isApplySelectionCornerRadius) {}
                        }
                        HStack {
                            Text("Movement Mode")
                            Spacer()
                            Picker(selection: $basicValue.movementMode) {
                                Text("Normal").tag(ASMovementMode.normal)
                                Text("Viscosity").tag(ASMovementMode.viscosity)
                            } label: {}
                                .pickerStyle(.segmented)
                        }
                    }
                case .ASCapsuleStyle:
                    Group {
                        HStack {
                            Text("Movement Mode")
                            Spacer()
                            Picker(selection: $capsuleValue.movementMode) {
                                Text("Normal").tag(ASMovementMode.normal)
                                Text("Viscosity").tag(ASMovementMode.viscosity)
                            } label: {}
                                .pickerStyle(.segmented)
                        }
                    }
                case .ASJellyStyle:
                    Group {
                        HStack {
                            Text("Jelly Edge")
                            Spacer()
                            Picker(selection: $jellyValue.jellyEdge) {
                                Text("Bottom/Trailing").tag(ASEdgeMode.bottomTrailing)
                                Text("Top/Leading").tag(ASEdgeMode.topLeading)
                            } label: {}
                                .pickerStyle(.segmented)
                        }
                    }
                case .ASLineStyle:
                    Group {
                        HStack {
                            Text("Line Edge")
                            Spacer()
                            Picker(selection: $lineValue.lineEdge) {
                                Text("Bottom/Trailing").tag(ASEdgeMode.bottomTrailing)
                                Text("Top/Leading").tag(ASEdgeMode.topLeading)
                            } label: {}
                                .pickerStyle(.segmented)
                        }
                        HStack {
                            Text("Movement Mode")
                            Spacer()
                            Picker(selection: $lineValue.movementMode) {
                                Text("Normal").tag(ASMovementMode.normal)
                                Text("Viscosity").tag(ASMovementMode.viscosity)
                            } label: {}
                                .pickerStyle(.segmented)
                        }
                    }
                case .ASNeumorphismStyle:
                    Group {
                        HStack {
                            Text("isInner")
                            Spacer()
                            Toggle(isOn: $neumorphismValue.isInner) {}
                        }
                        HStack {
                            Text("Movement Mode")
                            Spacer()
                            Picker(selection: $neumorphismValue.movementMode) {
                                Text("Normal").tag(ASMovementMode.normal)
                                Text("Viscosity").tag(ASMovementMode.viscosity)
                            } label: {}
                                .pickerStyle(.segmented)
                        }
                    }
                default: EmptyView()
                }
            }
            .padding()
        }
    }
}

struct SegmentedViewWithControl_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedViewWithControl(title: "ABBasicStyle", styleType: .ASBasicStyle, axisMode: .horizontal, constant: .constant(ASConstant.init()), tabs: {
            Group {
                Image(systemName: "align.horizontal.left")
                    .itemTag(0, selectArea: 0) {
                        SelectionItemView("align.horizontal.left.fill")
                    }
                Image(systemName: "align.horizontal.right")
                    .itemTag(1, selectArea: 0) {
                        SelectionItemView("align.horizontal.right.fill")
                    }
                Image(systemName: "align.vertical.top")
                    .itemTag(2, selectArea: 0) {
                        SelectionItemView("align.vertical.top.fill")
                    }
                Image(systemName: "align.vertical.bottom")
                    .itemTag(3, selectArea: 0) {
                        SelectionItemView("align.vertical.bottom.fill")
                    }
            }
        }, style: {
            ASBasicStyle()
        })
        .padding()
        .preferredColorScheme(.dark)
    }
}
