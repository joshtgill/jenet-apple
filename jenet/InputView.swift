//
//  InputView.swift
//  jenet
//
//  Created by Josh Gillette on 6/26/25.
//

import SwiftUI


struct InputView: View {
    @State private var composeText: String = ""
    @State private var isSending: Bool = false

    var body: some View {
        VStack {
            HStack {
                TextField("start talking", text: $composeText)
                    .background(Color.clear)
                    .padding(20)
                Button(action: {
                    if !composeText.isEmpty {
                        sendMessage(composeText)
                        composeText = ""
                    }
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.black)
                }
                .opacity(!composeText.isEmpty ? 1 : 0)
                .disabled(composeText.isEmpty || isSending)
            }
            .padding(.trailing, 10)
            .glassStyle()
        }
        .padding()
    }

    func sendMessage(_ text: String) {
        guard let url = URL(string: "https://api.jenet.ai/message") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: String] = ["text": text]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        isSending = true
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isSending = false
            }
        }.resume()
    }
}
