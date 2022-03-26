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
         area: CGFloat = 44,
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
                            Text("Color")
                            Spacer()
                            ColorPicker(selection: $constant.divideLine.color) {}
                        }
                        HStack {
                            Text("Width")
                            Spacer()
                            Slider(value: $constant.divideLine.width, in: 0...5)
                            Spacer()
                            Text("\(constant.divideLine.width, specifier: "%.2f")")
                        }
                        HStack {
                            Text("Scale")
                            Spacer()
                            Slider(value: $constant.divideLine.scale, in: 0...1)
                            Spacer()
                            Text("\(constant.divideLine.scale, specifier: "%.2f")")
                        }
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
                        HStack {
                            Text("ActivatedVibration")
                            Spacer()
                            Toggle(isOn: $constant.isActivatedVibration) {}
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
                    VStack {
                        HStack {
                            Text(title)
                                .font(.caption)
                                .foregroundColor(Color.white.opacity(0.6))
                            Spacer()
                            Image(systemName: "chevron.down")
                                .frame(width: 36, height: 36)
                                .rotationEffect(Angle(degrees: isShowControlView ? -180 : 0))
                                .contentShape(Rectangle())
                        }
                        .frame(height: 36)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                isShowControlView.toggle()
                            }
                        }
                        
                        VStack(spacing: 0) {
                            segmentedView
                                .frame(height: area)
                            Spacer().frame(height: 10)
                            controlView
                                .opacity(isShowControlView ? 1 : 0)
                                .frame(height: isShowControlView ? 400 : 0)
                        }
                    }
                }else {
                    VStack {
                        HStack {
                            Text(title)
                                .font(.caption)
                                .foregroundColor(Color.white.opacity(0.6))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .frame(width: 36, height: 36)
                                .rotationEffect(Angle(degrees: isShowControlView ? -180 : 0))
                                .contentShape(Rectangle())
                        }
                        .frame(height: 36)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                isShowControlView.toggle()
                            }
                        }
                        HStack(spacing: 0) {
                            segmentedView
                                .frame(width: area)
                            Spacer().frame(width: 10)
                            controlView
                                .frame(width: 260)
                                .mask(
                                    Rectangle()
                                        .frame(width: isShowControlView ? 260 : 0)
                                )
                                .opacity(isShowControlView ? 1 : 0)
                                .frame(width: isShowControlView ? 260 : 0)
                        }
                    }
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
            constant.axisMode = axisMode
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
                case .ASNormalStyle:
                    VStack(alignment: .leading, spacing: 8) {
                        Text("● SelectArea").opacity(0.5).font(.caption)
                        HStack {
                            Text("0")
                                .font(.system(size: 16))
                            Spacer()
                            Slider(value: $normalValue.selectArea0, in: 0...maxSelectArea)
                            Spacer()
                            Text("\(normalValue.selectArea0, specifier: "%.2f")")
                        }
                        HStack {
                            Text("1")
                                .font(.system(size: 16))
                            Spacer()
                            Slider(value: $normalValue.selectArea1, in: 0...maxSelectArea)
                            Spacer()
                            Text("\(normalValue.selectArea1, specifier: "%.2f")")
                        }
                    }
                    .padding(.top, 20)
                case .ASViscosityStyle:
                    VStack(alignment: .leading, spacing: 8) {
                        Text("● SelectArea").opacity(0.5).font(.caption)
                        HStack {
                            Text("0")
                                .font(.system(size: 16))
                            Spacer()
                            Slider(value: $viscosityValue.selectArea0, in: 0...maxSelectArea)
                            Spacer()
                            Text("\(viscosityValue.selectArea0, specifier: "%.2f")")
                        }
                        HStack {
                            Text("1")
                                .font(.system(size: 16))
                            Spacer()
                            Slider(value: $viscosityValue.selectArea1, in: 0...maxSelectArea)
                            Spacer()
                            Text("\(viscosityValue.selectArea1, specifier: "%.2f")")
                        }
                        HStack {
                            Text("2")
                                .font(.system(size: 16))
                            Spacer()
                            Slider(value: $viscosityValue.selectArea2, in: 0...maxSelectArea)
                            Spacer()
                            Text("\(viscosityValue.selectArea2, specifier: "%.2f")")
                        }
                    }
                    .padding(.top, 20)
                case .ASBasicStyle:
                    Group {
                        HStack {
                            Text("Background Color")
                            Spacer()
                            ColorPicker(selection: $basicValue.backgroundColor) {}
                        }
                        HStack {
                            Text("Foreground Color")
                            Spacer()
                            ColorPicker(selection: $basicValue.foregroundColor) {}
                        }
                        HStack {
                            Text("Corner Raddius")
                            Spacer()
                            Slider(value: $basicValue.cornerRadius, in: 0...22)
                            Spacer()
                            Text("\(basicValue.cornerRadius, specifier: "%.2f")")
                        }
                        HStack {
                            Text("Padding")
                            Spacer()
                            Slider(value: $basicValue.padding, in: 0...6)
                            Spacer()
                            Text("\(basicValue.padding, specifier: "%.2f")")
                        }
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
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("● SelectArea").opacity(0.5).font(.caption)
                            HStack {
                                Text("0")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $basicValue.selectArea0, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(basicValue.selectArea0, specifier: "%.2f")")
                            }
                            HStack {
                                Text("1")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $basicValue.selectArea1, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(basicValue.selectArea1, specifier: "%.2f")")
                            }
                            HStack {
                                Text("2")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $basicValue.selectArea2, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(basicValue.selectArea2, specifier: "%.2f")")
                            }
                        }
                        .padding(.top, 20)
                    }
                case .ASCapsuleStyle:
                    Group {
                        HStack {
                            Text("Background Color")
                            Spacer()
                            ColorPicker(selection: $capsuleValue.backgroundColor) {}
                        }
                        HStack {
                            Text("Foreground Color")
                            Spacer()
                            ColorPicker(selection: $capsuleValue.foregroundColor) {}
                        }
                        HStack {
                            Text("Movement Mode")
                            Spacer()
                            Picker(selection: $capsuleValue.movementMode) {
                                Text("Normal").tag(ASMovementMode.normal)
                                Text("Viscosity").tag(ASMovementMode.viscosity)
                            } label: {}
                                .pickerStyle(.segmented)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("● SelectArea").opacity(0.5).font(.caption)
                            HStack {
                                Text("0")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $capsuleValue.selectArea0, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(capsuleValue.selectArea0, specifier: "%.2f")")
                            }
                            HStack {
                                Text("1")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $capsuleValue.selectArea1, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(capsuleValue.selectArea1, specifier: "%.2f")")
                            }
                            HStack {
                                Text("2")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $capsuleValue.selectArea2, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(capsuleValue.selectArea2, specifier: "%.2f")")
                            }
                            HStack {
                                Text("3")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $capsuleValue.selectArea3, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(capsuleValue.selectArea3, specifier: "%.2f")")
                            }
                        }
                        .padding(.top, 20)
                    }
                case .ASJellyStyle:
                    Group {
                        HStack {
                            Text("Background Color")
                            Spacer()
                            ColorPicker(selection: $jellyValue.backgroundColor) {}
                        }
                        HStack {
                            Text("Foreground Color")
                            Spacer()
                            ColorPicker(selection: $jellyValue.foregroundColor) {}
                        }
                        HStack {
                            Text("Jelly Raddius")
                            Spacer()
                            Slider(value: $jellyValue.jellyRadius, in: 0...100)
                            Spacer()
                            Text("\(jellyValue.jellyRadius, specifier: "%.2f")")
                        }
                        HStack {
                            Text("Jelly Depth")
                            Spacer()
                            Slider(value: $jellyValue.jellyDepth, in: 0...1.0)
                            Spacer()
                            Text("\(jellyValue.jellyDepth, specifier: "%.2f")")
                        }
                        HStack {
                            Text("Jelly Edge")
                            Spacer()
                            Picker(selection: $jellyValue.jellyEdge) {
                                Text("Bottom/Trailing").tag(ASEdgeMode.bottomTrailing)
                                Text("Top/Leading").tag(ASEdgeMode.topLeading)
                            } label: {}
                                .pickerStyle(.segmented)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("● SelectArea").opacity(0.5).font(.caption)
                            HStack {
                                Text("0")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $jellyValue.selectArea0, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(jellyValue.selectArea0, specifier: "%.2f")")
                            }
                            HStack {
                                Text("1")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $jellyValue.selectArea1, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(jellyValue.selectArea1, specifier: "%.2f")")
                            }
                            HStack {
                                Text("2")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $jellyValue.selectArea2, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(jellyValue.selectArea2, specifier: "%.2f")")
                            }
                            HStack {
                                Text("3")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $jellyValue.selectArea3, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(jellyValue.selectArea3, specifier: "%.2f")")
                            }
                        }
                        .padding(.top, 20)
                    }
                case .ASLineStyle:
                    Group {
                        HStack {
                            Text("Line Color")
                            Spacer()
                            ColorPicker(selection: $lineValue.lineColor) {}
                        }
                        HStack {
                            Text("Line Small Width")
                            Spacer()
                            Slider(value: $lineValue.lineSmallWidth, in: 0...6)
                            Spacer()
                            Text("\(lineValue.lineSmallWidth, specifier: "%.2f")")
                        }
                        HStack {
                            Text("Line Large Scale")
                            Spacer()
                            Slider(value: $lineValue.lineLargeScale, in: 0...1)
                            Spacer()
                            Text("\(lineValue.lineLargeScale, specifier: "%.2f")")
                        }
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
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("● SelectArea").opacity(0.5).font(.caption)
                            HStack {
                                Text("0")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $lineValue.selectArea0, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(lineValue.selectArea0, specifier: "%.2f")")
                            }
                            HStack {
                                Text("1")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $lineValue.selectArea1, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(lineValue.selectArea1, specifier: "%.2f")")
                            }
                            HStack {
                                Text("2")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $lineValue.selectArea2, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(lineValue.selectArea2, specifier: "%.2f")")
                            }
                            HStack {
                                Text("3")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $lineValue.selectArea3, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(lineValue.selectArea3, specifier: "%.2f")")
                            }
                        }
                        .padding(.top, 20)
                    }
                case .ASNeumorphismStyle:
                    Group {
                        HStack {
                            Text("Background Color")
                            Spacer()
                            ColorPicker(selection: $neumorphismValue.backgroundColor) {}
                        }
                        HStack {
                            Text("Foreground Color")
                            Spacer()
                            ColorPicker(selection: $neumorphismValue.foregroundColor) {}
                        }
                        HStack {
                            Text("Corner Raddius")
                            Spacer()
                            Slider(value: $neumorphismValue.cornerRadius, in: 0...35)
                            Spacer()
                            Text("\(neumorphismValue.cornerRadius, specifier: "%.2f")")
                        }
                        HStack {
                            Text("Shadow Raddius")
                            Spacer()
                            Slider(value: $neumorphismValue.shadowRadius, in: 0...7)
                            Spacer()
                            Text("\(neumorphismValue.shadowRadius, specifier: "%.2f")")
                        }
                        HStack {
                            Text("Padding")
                            Spacer()
                            Slider(value: $neumorphismValue.padding, in: 0...12)
                            Spacer()
                            Text("\(neumorphismValue.padding, specifier: "%.2f")")
                        }
                        HStack {
                            Text("Shadow Opacity")
                            Spacer()
                            Slider(value: $neumorphismValue.shadowOpacity, in: 0...1)
                            Spacer()
                            Text("\(neumorphismValue.shadowOpacity, specifier: "%.2f")")
                        }
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
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("● SelectArea").opacity(0.5).font(.caption)
                            HStack {
                                Text("0")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $neumorphismValue.selectArea0, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(neumorphismValue.selectArea0, specifier: "%.2f")")
                            }
                            HStack {
                                Text("1")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $neumorphismValue.selectArea1, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(neumorphismValue.selectArea1, specifier: "%.2f")")
                            }
                            HStack {
                                Text("2")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $neumorphismValue.selectArea2, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(neumorphismValue.selectArea2, specifier: "%.2f")")
                            }
                            HStack {
                                Text("3")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $neumorphismValue.selectArea3, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(neumorphismValue.selectArea3, specifier: "%.2f")")
                            }
                        }
                        .padding(.top, 20)
                    }
                case .ASScaleStyle:
                    Group {
                        HStack {
                            Text("Background Color")
                            Spacer()
                            ColorPicker(selection: $scaleValue.backgroundColor) {}
                        }
                        HStack {
                            Text("Foreground Color")
                            Spacer()
                            ColorPicker(selection: $scaleValue.foregroundColor) {}
                        }
                        HStack {
                            Text("Corner Raddius")
                            Spacer()
                            Slider(value: $scaleValue.cornerRadius, in: 0...22)
                            Spacer()
                            Text("\(scaleValue.cornerRadius, specifier: "%.2f")")
                        }
                        HStack {
                            Text("Minimum Scale")
                            Spacer()
                            Slider(value: $scaleValue.minimumScale, in: 0...1)
                            Spacer()
                            Text("\(scaleValue.minimumScale, specifier: "%.2f")")
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("● SelectArea").opacity(0.5).font(.caption)
                            HStack {
                                Text("0")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $scaleValue.selectArea0, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(scaleValue.selectArea0, specifier: "%.2f")")
                            }
                            HStack {
                                Text("1")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $scaleValue.selectArea1, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(scaleValue.selectArea1, specifier: "%.2f")")
                            }
                            HStack {
                                Text("2")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $scaleValue.selectArea2, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(scaleValue.selectArea2, specifier: "%.2f")")
                            }
                            HStack {
                                Text("3")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $scaleValue.selectArea3, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(scaleValue.selectArea3, specifier: "%.2f")")
                            }
                        }
                        .padding(.top, 20)
                    }
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
