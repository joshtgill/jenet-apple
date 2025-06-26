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
        .glassStyle(isExpanded: isExpanded)
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isExpanded)
        .ignoresSafeArea(edges: isExpanded ? .all : [])
    }
}
