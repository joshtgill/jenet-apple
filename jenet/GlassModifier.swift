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
            .background(
                Color(
                    red: 243/255,
                    green: 244/255,
                    blue: 246/255
                ).opacity(isExpanded ? 0.70 : 0.60)
            )
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
//                    .fill(.ultraThinMaterial)
                    .stroke(
                        Color(
                            red: 209/255,
                            green: 213/255,
                            blue: 219/255),
                        lineWidth: 1
                    )
            )
            .shadow(
                color: Color(
                    red: 180/255,
                    green: 180/255,
                    blue: 200/255).opacity(isExpanded ? 0.3 : 0.2),
                radius: isExpanded ? 16 : 8,
                x: 0,
                y: 0
            )
    }
}
extension View {
    func glassStyle(isExpanded: Bool = false) -> some View {
        self.modifier(GlassModifier(isExpanded: isExpanded))
    }
}
