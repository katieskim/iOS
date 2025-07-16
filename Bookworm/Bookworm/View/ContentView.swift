//
//  ContentView.swift
//  Bookworm
//
//  Created by Katie Kim on 7/16/25.
//

import SwiftUI

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool

    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]

    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(LinearGradient(colors: isOn ? onColors: offColors, startPoint: .top, endPoint: .bottom))
        .foregroundStyle(.white)
        .clipShape(.capsule)
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct ContentView: View {
    @State private var rememberMe = false
    @AppStorage("notes") private var notes = ""

    var body: some View {
        NavigationStack {
            VStack {
                PushButton(title: "Remember Me", isOn: $rememberMe)
                Text(rememberMe ? "On" : "Off")
            }
            TextField("Enter your text here:", text: $notes, axis: .vertical)
                .navigationTitle("Notes")
                .padding()
        }
        
        
    }
}

#Preview {
    ContentView()
}
