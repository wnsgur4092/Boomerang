//
//  Colors++.swift
//  Boomerang
//
//  Created by JunHyuk Lim on 16/10/2023.
//

import Foundation
import SwiftUI

extension Color {
    static let onBackgroundPrimary: Color = .init(hex: 0x252525)
    static let onBackgroundSecondary: Color = .init(hex: 0x6F7278)
    static let onBackgroundTertiary: Color = .init(hex: 0xEEF1F7)
    
    static let onMainColor : Color = Color("maincolor")
    static let onIconColor : Color = Color("iconColor")
    static let onCardColor : Color = Color("backgroundColor")
    static let onPopUpColor : Color = Color("popupColor")
    static let onSettingColor : Color = Color("settingColor")
}

private extension Color {
    init(hex: UInt) { self.init(.sRGB, red: Double((hex >> 16) & 0xff) / 255, green: Double((hex >> 08) & 0xff) / 255, blue: Double((hex >> 00) & 0xff) / 255, opacity: 1) }
}
