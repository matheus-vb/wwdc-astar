//
//  Color.swift
//  AStar
//
//  Created by matheusvb on 18/04/23.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let darkBlue = Color(hex: "102F47")
    let red = Color(hex: "DE1111")
    let orange = Color(hex: "FD9C36")
    let yellow = Color(hex: "FFC75B")
    let lightGreen = Color(hex: "DDEAB7")
    
    let cheese = Color(hex: "FCBA04")
    let tomatoe = Color(hex: "A50104")
    let ketchup = Color(hex: "590004")
    let olive = Color(hex: "250001")
    let leaf = Color(hex: "43CD51")
    
    let background = Color(hex: "F3F9E3")
}
