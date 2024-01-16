//
//  ContentView.swift
//  my-test-ios-app
//
//  Created by Alexander Bolzhelarskiy on 05.01.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            StartScreen()
                .tabItem {
                    Image(systemName: "1.circle.fill")
                    Text("Start Screen")
                }
                .tag(0)
            
            DrugAndDropScreen()
                .tabItem {
                    Image(systemName: "2.circle.fill")
                    Text("Drug And Drop Screen")
                }
                .tag(1)
        }
        .tabViewStyle(.page)
    }
}

struct StartScreen: View {
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

struct DrugAndDropScreen: View {
    var body: some View {
        VStack {
            Text("Drug & Drop screen")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
