//
//  Date.swift
//  Boomerang
//
//  Created by JunHyuk Lim on 16/10/2023.
//

import Foundation

extension Date {
    func formattedAsDayMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter.string(from: self).uppercased()
    }
    
    func formattedAsDayMonthYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: self).uppercased()
    }
    
    func formattedAsTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self).uppercased()
    }
}
