//
//  glass.swift
//  jenet
//
//  Created by Josh Gillette on 6/25/25.
//

import SwiftUI


struct GlassModifier: ViewModifier {
    let isExpanded: Bool
    
    func body(content: Content) -> some View {
        content
            .background(Color.white.opacity(isExpanded ? 0.90 : 0.75))
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
            .shadow(color: Color(red: 180/255, green: 180/255, blue: 200/255, opacity: 0.3),
                    radius: 16)
    }
}
extension View {
    func glassStyle(isExpanded: Bool = false) -> some View {
        self.modifier(GlassModifier(isExpanded: isExpanded))
    }
}
