//
//  Fonts.swift
//  Boomerang
//
//  Created by JunHyuk Lim on 29/7/2023.
//

import Foundation
import SwiftUI

extension Font {
    public static var tabBar: Font {
        return Font.custom("Poppins", size: 10)
    }
    
    public static func regularFont(size: CGFloat) -> Font {
        return Font.custom("Poppins-Regular", size: size)
    }
    
    public static func mediumFont(size: CGFloat) -> Font {
        return Font.custom("Poppins-Medium", size: size)
    }
    
    public static func boldFont(size: CGFloat) -> Font {
        return Font.custom("Poppins-Bold", size: size)
    }
}

