//
//  HeaderView.swift
//  jenet
//
//  Created by Josh Gillette on 6/26/25.
//

import SwiftUI


struct HeaderView: View {

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Josh Gillette")
                        .font(.headline)
                    Text("active now")
                        .font(.subheadline)
                        .italic()
                        .foregroundColor(Color(red: 21/255, green: 128/255, blue: 61/255))
                        .padding(.leading, 3)
                }
                Spacer()
            }
            .padding()
            .glassStyle()
        }
        .padding(.horizontal)
    }
}
