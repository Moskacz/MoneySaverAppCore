//
//  Theme.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 14.07.2018.
//

import Foundation
import MMFoundation

public enum AppColor {
    case main
    case mainDark
    case activeElement
    case activeElementDark
    case green
    case greenDark
    case red
    case redDark
    
    public var value: Color {
        switch self {
        case .main: return Color.hsb(h: 0.13, s: 0.99, b: 1.0)
        case .mainDark: return Color.hsb(h: 0.11, s: 1.0, b: 1.0)
        case .activeElement: return Color.hsb(h: 0.62, s: 0.5, b: 0.63)
        case .activeElementDark: return Color.hsb(h: 0.62, s: 0.56, b: 0.51)
        case .green: return Color.hsb(h: 0.4, s: 0.77, b: 0.8)
        case .greenDark: return Color.hsb(h: 0.4, s: 0.78, b: 0.68)
        case .red: return Color.hsb(h: 0.02, s: 0.74, b: 0.91)
        case .redDark: return Color.hsb(h: 0.02, s: 0.78, b: 0.75)
        }
    }
}

public enum AppGradient {
    case activeElement
    case positiveValueTransaction
    case negativeValueTransaction
    case summaryView
    case main
    
    public var value: Gradient {
        switch self {
        case .activeElement:
            return Gradient(colors: [AppColor.activeElement.value,
                                     AppColor.activeElementDark.value,
                                     AppColor.activeElement.value],
                            direction: .vertical)
            
        case .positiveValueTransaction:
            return Gradient(colors: [AppColor.green.value, AppColor.greenDark.value], direction: .skewRight)
        case .negativeValueTransaction:
            return Gradient(colors: [AppColor.red.value, AppColor.redDark.value], direction: .skewRight)
        case .summaryView:
            return Gradient(colors: [AppColor.main.value, AppColor.mainDark.value], direction: .skewLeft)
        case .main:
            return Gradient(colors: [AppColor.main.value, AppColor.mainDark.value], direction: .skewRight)
        }
    }
}
