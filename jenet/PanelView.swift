//
//  PanelView.swift
//  jenet
//
//  Created by Josh Gillette on 6/25/25.
//

import SwiftUI


struct PanelView: View {
    let index: Int
    let isExpanded: Bool
    let onTap: () -> Void

    var body: some View {
        ZStack {
            Color.clear
            Text("Panel \(index)")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black)
        }
            .contentShape(Rectangle())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onTapGesture { onTap() }
            .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isExpanded)
            .background(Color.white.opacity(isExpanded ? 0.80 : 0.60))
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
            .shadow(
                color: Color(red: 180/255,
                             green: 180/255,
                             blue: 200/255,
                             opacity: 0.3),
                radius: 16
            )
            .ignoresSafeArea(edges: isExpanded ? .all : [])
    }
}
