//
//  MessageView.swift
//  jenet
//
//  Created by Josh Gillette on 6/26/25.
//


import SwiftUI


struct MessageView: View {
    let isExpanded: Bool
    let headerHeight: CGFloat
    let inputHeight: CGFloat

    @State private var messages: [String] = []

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(messages.indices, id: \.self) { i in
                                HStack {
                                    if i % 2 == 0 {
                                        Spacer()
                                        Text(messages[i])
                                            .padding()
                                            .background(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .fill(Color(red: 237/255, green: 237/255, blue: 237/255).opacity(0.6))
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 16)
                                                            .stroke(Color(red: 229/255, green: 231/255, blue: 235/255), lineWidth: 1) // gray-200
                                                    )
                                            )
                                            .foregroundColor(Color(red: 31/255, green: 41/255, blue: 55/255))
                                    }
                                    if i % 2 != 0 {
                                        Text(messages[i])
                                            .padding()
                                            .background(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .fill(Color(red: 220/255, green: 220/255, blue: 220/255).opacity(0.1))
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 16)
                                                            .stroke(Color(red: 229/255, green: 231/255, blue: 235/255), lineWidth: 1) // gray-200
                                                    )
                                            )
                                            .foregroundColor(Color(red: 17/255, green: 24/255, blue: 39/255)) // gray-900
                                        Spacer()
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, headerHeight + (isExpanded ? 77 : 15))
                        .padding(.bottom, inputHeight + (isExpanded ? 33 : 0))
                    }
                    .scrollDisabled(!isExpanded)
                    .onAppear {
                        fetchMessages()
                        if let last = messages.indices.last {
                            proxy.scrollTo(last, anchor: .bottom)
                        }
                    }
                    .onChange(of: messages.count, initial: true) { _, _ in
                        if let last = messages.indices.last {
                            proxy.scrollTo(last, anchor: .bottom)
                        }
                    }
                }
            }
        }
    }

    func fetchMessages() {
        guard let url = URL(string: "https://api.jenet.ai/message") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
            let fetchedMessages = json["text"] as? [String] {
                DispatchQueue.main.async {
                    messages = fetchedMessages
                }
            }
        }.resume()
    }
}
