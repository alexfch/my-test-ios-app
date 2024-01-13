//
//  ContentView.swift
//  my-test-ios-app
//
//  Created by Alexander Bolzhelarskiy on 05.01.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var buttonText = "did you click it yet?"
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .accessibilityIdentifier("helloWorldText")
            Button("Click me!"){
                buttonText = "Yes! It's clicked!"
            }
            .accessibilityIdentifier("clickMeButton")
            .padding()
            Text(buttonText)
                .accessibilityIdentifier("message")
                .padding()
            Text("version:2")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
