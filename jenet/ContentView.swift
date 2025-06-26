//
//  ContentView.swift
//  jenet
//
//  Created by Josh Gillette on 6/25/25.
//

import SwiftUI


struct ContentView: View {
    @State private var scrollOffset: CGFloat = 0
    @State private var currentPanel: Int = 0
    @State private var expandedPanelIndex: Int? = nil
    @Namespace private var panelNamespace

    let panelCount = 10

    var body: some View {
        GeometryReader { geo in
            ZStack {
                if expandedPanelIndex == nil {
                    ScrollViewReader { proxyReader in
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 0) {
                                ForEach(0..<panelCount, id: \.self) { index in
                                    buildPanel(index: index, geo: geo)
                                        .matchedGeometryEffect(id: index, in: panelNamespace)
                                }
                            }
                        }
                        .content.offset(y: scrollOffset)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    guard expandedPanelIndex == nil else { return }

                                    // Scroll active, update offset to visualize movement
                                    scrollOffset = -CGFloat(currentPanel) * geo.size.height + value.translation.height
                                }
                                .onEnded { value in
                                    guard expandedPanelIndex == nil else { return }

                                    // Scroll complete, evaluate the next panel (only allow one panel scroll at a time)
                                    let predictedOffset = -CGFloat(currentPanel) * geo.size.height + value.predictedEndTranslation.height
                                    let predictedPage = max(currentPanel - 1, min(Int(round(-predictedOffset / geo.size.height)), currentPanel + 1))
                                    let nextPanel = max(0, min(predictedPage, panelCount - 1))

                                    withAnimation(.spring()) {
                                        currentPanel = nextPanel
                                        scrollOffset = -CGFloat(nextPanel) * geo.size.height
                                        proxyReader.scrollTo(nextPanel, anchor: .top)
                                    }
                                }
                        )
                    }
                }
                else {
                    buildPanel(index: expandedPanelIndex!, geo: geo)
                        .matchedGeometryEffect(id: expandedPanelIndex, in: panelNamespace)
                }
            }
        }
        .background(
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color(red: 0.96, green: 0.96, blue: 0.98), location: 0.0),
                    .init(color: Color(red: 0.97, green: 0.98, blue: 0.99), location: 0.5),
                    .init(color: Color(red: 0.95, green: 0.96, blue: 0.97), location: 1.0)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }

    private func buildPanel(index: Int, geo: GeometryProxy) -> some View {
        let isExpanded = expandedPanelIndex == index
        return PanelView(
            index: index,
            isExpanded: isExpanded,
            onTap: {
                withAnimation(.spring(response: 0.7, dampingFraction: 0.5)) {
                    expandedPanelIndex = isExpanded ? nil : index
                }
            }
        )
        .frame(
            width: geo.size.width * (isExpanded ? 1.0 : 0.94),
            height: geo.size.height * (isExpanded ? 1.0 : 0.98)
        )
        .padding(.bottom, isExpanded ? 0 : geo.size.height * 0.02)
        .padding(.horizontal, isExpanded ? 0 : geo.size.width * 0.03)
        .id(index)
    }
}
