//
//  SegmentedListView.swift
//  AxisSegmentedViewExample
//
//  Created by jasu on 2022/03/23.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisSegmentedView

enum StyleType: String {
    case ASNormalStyle
    case ASViscosityStyle
    
    case ASBasicStyle
    case ASCapsuleStyle
    case ASJellyStyle
    case ASLineStyle
    case ASNeumorphismStyle
    case ASScaleStyle
}


struct SegmentedListView: View {
    
    let axisMode: ASAxisMode
    
    @StateObject private var normalValue:       NormalValue = .init()
    @StateObject private var viscosityValue:    ViscosityValue = .init()
    
    @StateObject private var basicValue:        BasicValue = .init()
    @StateObject private var capsuleValue:      CapsuleValue = .init()
    @StateObject private var jellyValue:        JellyValue = .init()
    @StateObject private var lineValue:         LineValue = .init()
    @StateObject private var neumorphismValue:  NeumorphismValue = .init()
    @StateObject private var scaleValue:        ScaleValue = .init()
    
    var content: some View {
        Group {
            SegmentedViewWithControl(title: "ABNormalStyle", styleType: .ASNormalStyle, axisMode: axisMode, constant: $normalValue.constant, tabs: {
                Group {
                    Text("Clear")
                        .font(.callout)
                        .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                        .foregroundColor(Color.white.opacity(0.5))
                        .itemTag(0, selectArea: normalValue.selectArea0) {
                            HStack {
                                Image(systemName: "checkmark.circle")
                                Text("Clear")
                            }
                            .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                            .font(.callout)
                            .foregroundColor(Color.white)
                        }
                    Text("Confusing")
                        .font(.callout)
                        .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                        .foregroundColor(Color.white.opacity(0.5))
                        .itemTag(1, selectArea: normalValue.selectArea1) {
                            HStack {
                                Image(systemName: "checkmark.circle")
                                Text("Confusing")
                            }
                            .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                            .font(.callout)
                            .foregroundColor(Color.white)
                        }
                }
            }, style: {
                ASNormalStyle { _ in
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color(hex: 0x191919))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke()
                                .fill(Color(hex: 0x282828))
                        )
                        .padding(3.5)
                }
                .background(Color(hex: 0x0B0C10))
                .clipShape(RoundedRectangle(cornerRadius: 5))
            })
            SegmentedViewWithControl(title: "ASViscosityStyle", styleType: .ASViscosityStyle, axisMode: axisMode, constant: $viscosityValue.constant, tabs: {
                Group {
                    Text("Store")
                        .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                        .font(.callout)
                        .foregroundColor(Color.white.opacity(0.5))
                        .itemTag(0, selectArea: viscosityValue.selectArea0) {
                            Text("Store")
                                .font(.callout)
                                .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                                .foregroundColor(Color.white)
                        }
                    Text("Library")
                        .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                        .font(.callout)
                        .foregroundColor(Color.white.opacity(0.5))
                        .itemTag(1, selectArea: viscosityValue.selectArea1) {
                            Text("Library")
                                .font(.callout)
                                .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                                .foregroundColor(Color.white)
                        }
                    Text("Downloads")
                        .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                        .font(.callout)
                        .foregroundColor(Color.white.opacity(0.5))
                        .itemTag(2, selectArea: viscosityValue.selectArea2) {
                            Text("Downloads")
                                .font(.callout)
                                .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                                .foregroundColor(Color.white)
                        }
                }
            }, style: {
                ASViscosityStyle { _ in
                    Capsule()
                        .fill(LinearGradient(colors: [Color(hex: 0x222222), Color(hex: 0x111111)],
                                             startPoint: axisMode == .horizontal ? UnitPoint.top : UnitPoint.leading,
                                             endPoint: axisMode == .horizontal ? UnitPoint.bottom : UnitPoint.trailing))
                        .overlay(
                            Capsule()
                                .stroke()
                                .fill(Color.black)
                        )
                        .padding(2)
                }
                .background(Color.black.opacity(0.2))
                .clipShape(Capsule())
                .innerShadow(Capsule(), radius: 1, opacity: 0.5, isDark: true)
            })
            
            SegmentedViewWithControl(title: "ASBasicStyle", styleType: .ASBasicStyle, axisMode: axisMode, constant: $basicValue.constant, tabs: {
                Group {
                    Text("Male")
                        .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                        .font(.callout)
                        .foregroundColor(Color.white.opacity(0.5))
                        .itemTag(0, selectArea: basicValue.selectArea0) {
                            Text("Male")
                                .font(.callout)
                                .fixedSize()
                                .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                                .foregroundColor(Color.white)
                        }
                    Text("Female")
                        .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                        .font(.callout)
                        .foregroundColor(Color.white.opacity(0.5))
                        .itemTag(1, selectArea: basicValue.selectArea1) {
                            Text("Female")
                                .font(.callout)
                                .fixedSize()
                                .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                                .foregroundColor(Color.white)
                        }
                    Text("Other")
                        .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                        .font(.callout)
                        .foregroundColor(Color.white.opacity(0.5))
                        .itemTag(2, selectArea: basicValue.selectArea2) {
                            Text("Other")
                                .font(.callout)
                                .fixedSize()
                                .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                                .foregroundColor(Color.white)
                        }
                }
            }, style: {
                ASBasicStyle(backgroundColor: basicValue.backgroundColor,
                             foregroundColor: basicValue.foregroundColor,
                             cornerRadius: basicValue.cornerRadius,
                             padding: basicValue.padding,
                             isApplySelectionCornerRadius: basicValue.isApplySelectionCornerRadius,
                             movementMode: basicValue.movementMode)
            })
            
            SegmentedViewWithControl(title: "ASJellyStyle", styleType: .ASJellyStyle, axisMode: axisMode, constant: $jellyValue.constant, tabs: {
                Group {
                    Image(systemName: "align.horizontal.left")
                        .itemTag(0, selectArea: jellyValue.selectArea0) {
                            SelectionItemView("align.horizontal.left.fill")
                        }
                    Image(systemName: "align.horizontal.right")
                        .itemTag(1, selectArea: jellyValue.selectArea1) {
                            SelectionItemView("align.horizontal.right.fill")
                        }
                    Image(systemName: "align.vertical.top")
                        .itemTag(2, selectArea: jellyValue.selectArea2) {
                            SelectionItemView("align.vertical.top.fill")
                        }
                    Image(systemName: "align.vertical.bottom")
                        .itemTag(3, selectArea: jellyValue.selectArea3) {
                            SelectionItemView("align.vertical.bottom.fill")
                        }
                }
            }, style: {
                ASJellyStyle(backgroundColor: jellyValue.backgroundColor,
                             foregroundColor: jellyValue.foregroundColor,
                             jellyRadius: jellyValue.jellyRadius,
                             jellyDepth: jellyValue.jellyDepth,
                             jellyEdge: jellyValue.jellyEdge)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 11)
//                                        .stroke(.purple, lineWidth: 1)
//                                        .padding(1)
//                                )
//                                .clipShape(RoundedRectangle(cornerRadius: 11))
            })
            
            SegmentedViewWithControl(title: "ASLineStyle", styleType: .ASLineStyle, axisMode: axisMode, constant: $lineValue.constant, tabs: {
                Group {
                    Image(systemName: "align.horizontal.left")
                        .itemTag(0, selectArea: lineValue.selectArea0) {
                            SelectionItemView("align.horizontal.left.fill")
                        }
                    Image(systemName: "align.horizontal.right")
                        .itemTag(1, selectArea: lineValue.selectArea1) {
                            SelectionItemView("align.horizontal.right.fill")
                        }
                    Image(systemName: "align.vertical.top")
                        .itemTag(2, selectArea: lineValue.selectArea2) {
                            SelectionItemView("align.vertical.top.fill")
                        }
                    Image(systemName: "align.vertical.bottom")
                        .itemTag(3, selectArea: lineValue.selectArea3) {
                            SelectionItemView("align.vertical.bottom.fill")
                        }
                }
            }, style: {
                ASLineStyle(lineColor: lineValue.lineColor,
                            lineSmallWidth: lineValue.lineSmallWidth,
                            lineLargeScale: lineValue.lineLargeScale,
                            lineEdge: lineValue.lineEdge,
                            movementMode: lineValue.movementMode)
                .overlay(
                    Rectangle()
                        .stroke()
                        .fill(Color(hex: 0x303030))
                )
            })
            
            SegmentedViewWithControl(title: "ASCapsuleStyle", styleType: .ASCapsuleStyle, axisMode: axisMode, constant: $capsuleValue.constant, tabs: {
                Group {
                    Image(systemName: "align.horizontal.left")
                        .itemTag(0, selectArea: capsuleValue.selectArea0) {
                            SelectionItemView("align.horizontal.left.fill")
                        }
                    Image(systemName: "align.horizontal.right")
                        .itemTag(1, selectArea: capsuleValue.selectArea1) {
                            SelectionItemView("align.horizontal.right.fill")
                        }
                    Image(systemName: "align.vertical.top")
                        .itemTag(2, selectArea: capsuleValue.selectArea2) {
                            SelectionItemView("align.vertical.top.fill")
                        }
                    Image(systemName: "align.vertical.bottom")
                        .itemTag(3, selectArea: capsuleValue.selectArea3) {
                            SelectionItemView("align.vertical.bottom.fill")
                        }
                }
            }, style: {
                ASCapsuleStyle(backgroundColor: capsuleValue.backgroundColor,
                               foregroundColor: capsuleValue.foregroundColor,
                               movementMode: capsuleValue.movementMode)
            })

            SegmentedViewWithControl(title: "ASNeumorphismStyle", styleType: .ASNeumorphismStyle, axisMode: axisMode, constant: $neumorphismValue.constant, area: 120, tabs: {
                Group {
                    Image(systemName: "align.horizontal.left")
                        .itemTag(0, selectArea: neumorphismValue.selectArea0) {
                            SelectionItemView("align.horizontal.left.fill")
                        }
                    Image(systemName: "align.horizontal.right")
                        .itemTag(1, selectArea: neumorphismValue.selectArea1) {
                            SelectionItemView("align.horizontal.right.fill")
                        }
                    Image(systemName: "align.vertical.top")
                        .itemTag(2, selectArea: neumorphismValue.selectArea2) {
                            SelectionItemView("align.vertical.top.fill")
                        }
                    Image(systemName: "align.vertical.bottom")
                        .itemTag(3, selectArea: neumorphismValue.selectArea3) {
                            SelectionItemView("align.vertical.bottom.fill")
                        }
                }
            }, style: {
                ASNeumorphismStyle(backgroundColor: neumorphismValue.backgroundColor,
                                   foregroundColor: neumorphismValue.foregroundColor,
                                   cornerRadius: neumorphismValue.cornerRadius,
                                   padding: neumorphismValue.padding,
                                   shadowRadius: neumorphismValue.shadowRadius,
                                   shadowOpacity: neumorphismValue.shadowOpacity,
                                   isInner: neumorphismValue.isInner,
                                   movementMode: neumorphismValue.movementMode)
            })
            
            SegmentedViewWithControl(title: "ASScaleStyle", styleType: .ASScaleStyle, axisMode: axisMode, constant: $scaleValue.constant, tabs: {
                Group {
                    Image(systemName: "align.horizontal.left")
                        .itemTag(0, selectArea: scaleValue.selectArea0) {
                            SelectionItemView("align.horizontal.left.fill")
                        }
                    Image(systemName: "align.horizontal.right")
                        .itemTag(1, selectArea: scaleValue.selectArea1) {
                            SelectionItemView("align.horizontal.right.fill")
                        }
                    Image(systemName: "align.vertical.top")
                        .itemTag(2, selectArea: scaleValue.selectArea2) {
                            SelectionItemView("align.vertical.top.fill")
                        }
                    Image(systemName: "align.vertical.bottom")
                        .itemTag(3, selectArea: scaleValue.selectArea3) {
                            SelectionItemView("align.vertical.bottom.fill")
                        }
                }
            }, style: {
                ASScaleStyle(backgroundColor: scaleValue.backgroundColor,
                             foregroundColor: scaleValue.foregroundColor,
                             cornerRadius: scaleValue.cornerRadius,
                             minimumScale: scaleValue.minimumScale)
            })
        }
    }
    var body: some View {
        ZStack {
            if axisMode == .horizontal {
                ScrollView {
                    VStack(spacing: 20) {
                        content
                    }
                    .padding(.horizontal, 5)
                }
            }else {
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        content
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .environmentObject(normalValue)
        .environmentObject(viscosityValue)
        .environmentObject(basicValue)
        .environmentObject(capsuleValue)
        .environmentObject(jellyValue)
        .environmentObject(lineValue)
        .environmentObject(neumorphismValue)
        .environmentObject(scaleValue)
    }
}

struct SegmentedListView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedListView(axisMode: .horizontal)
            .padding()
            .preferredColorScheme(.dark)
    }
}
