//
//  Extensions.swift
//  AssistAid
//
//  Created by Adrian Martushev on 6/14/24.
//

import Foundation
import SwiftUI
import UIKit



extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}



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
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue:  Double(b) / 255, opacity: Double(a) / 255)
    }
}



//Modals and Top/Bottom sheets

//Center growing modal for errors and other views
struct CenterGrowingModalModifier: ViewModifier {
    let isPresented: Bool

    func body(content: Content) -> some View {
        content
            .scaleEffect(isPresented ? 1 : 0.5)
            .opacity(isPresented ? 1 : 0)
            .animation(.easeInOut, value: isPresented)
    }
}

// Extension to use the modifier easily
extension View {
    func centerGrowingModal(isPresented: Bool) -> some View {
        self.modifier(CenterGrowingModalModifier(isPresented: isPresented))
    }
}



// Top down sheet, used for the calendar
struct TopDownSheetModifier: ViewModifier {
    let isPresented: Bool

    func body(content: Content) -> some View {
        content
            .offset(y: isPresented ? 0 : -UIScreen.main.bounds.height)
            .animation(.easeInOut, value: isPresented)
    }
}

// Extension to use the modifier easily
extension View {
    func topDownSheet(isPresented: Bool) -> some View {
        self.modifier(TopDownSheetModifier(isPresented: isPresented))
    }
}


// Bottom up sheet, used for the calendar

struct BottomUpSheetModifier: ViewModifier {
    let isPresented: Bool

    func body(content: Content) -> some View {
        content
            .offset(y: isPresented ? 0 : UIScreen.main.bounds.height)
            .animation(.easeInOut(duration: 0.3), value: isPresented)
    }
}

// Extension to use the modifier easily
extension View {
    func bottomUpSheet(isPresented: Bool) -> some View {
        self.modifier(BottomUpSheetModifier(isPresented: isPresented))
    }
}


struct LeadingEdgeSheetModifier: ViewModifier {
    let isPresented: Bool

    func body(content: Content) -> some View {
        content
            .offset(x: isPresented ? 0 : -UIScreen.main.bounds.width)
            .animation(.easeInOut(duration: 0.3), value: isPresented)
    }
}

// Extension to use the modifier easily
extension View {
    func leadingEdgeSheet(isPresented: Bool) -> some View {
        self.modifier(LeadingEdgeSheetModifier(isPresented: isPresented))
    }
}





#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

