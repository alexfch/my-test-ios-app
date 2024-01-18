//
//  ContentView.swift
//  my-test-ios-app
//
//  Created by Alexander Bolzhelarskiy on 05.01.2024.
//

import SwiftUI
import UniformTypeIdentifiers

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
        .tabViewStyle(.page(indexDisplayMode: .never))
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
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
            Text("version:3")
        }
    }
}

struct DrugAndDropScreen: View {
    @State private var isAboveApples = false
    @State private var isAboveOranges = false
    @State private var appleBasketItems: [FruitView] = [
        FruitView(name: "apple"),
        FruitView(name: "orange"),
        FruitView(name: "apple")
    ]
    @State private var orangeBasketItems: [FruitView] = []
    var body: some View {
        ZStack {
            Color.red
            
            VStack {
                Text("Drug & Drop Screen")
                
                BasketView(title: "Apples", fruits: appleBasketItems, isTargeted: isAboveApples)
                    .accessibilityIdentifier("apples-busket")
                    .dropDestination(for: FruitView.self) { fruits, location in
                        for fruit in fruits {
                            orangeBasketItems.removeAll { $0.id == fruit.id}
                            appleBasketItems.removeAll { $0.id == fruit.id}
                        }
                        appleBasketItems += fruits
                        return true
                    } isTargeted: { isTargeted in
                        isAboveApples = isTargeted
                    }
                
                BasketView(title: "Oranges", fruits: orangeBasketItems, isTargeted: isAboveOranges)
                    .accessibilityIdentifier("oranges-busket")
                    .dropDestination(for: FruitView.self) { fruits, location in
                        for fruit in fruits {
                            appleBasketItems.removeAll { $0.id == fruit.id}
                            orangeBasketItems.removeAll { $0.id == fruit.id}
                        }
                        orangeBasketItems += fruits
                        return true
                    } isTargeted: { isTargeted in
                        isAboveOranges = isTargeted
                    }
            }
            .padding()
            
        }
    }
}

struct BasketView: View {
    let title: String
    let fruits: [FruitView]
    let isTargeted: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            Text("\(title): \(fruits.count)").font(.headline.bold())
                .accessibilityIdentifier("basket-title")
            Spacer()
            RoundedRectangle(cornerRadius: 12)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .foregroundColor(isTargeted ? .teal.opacity(0.15) : Color(.white).opacity(0.3))
                .overlay(
                    VStack(alignment: .leading, spacing: 10){
                        ForEach(fruits, id: \.id) { fruit in
                            fruit
                                .accessibilityIdentifier("fruit-item")
                                .clipped()
                                .frame(maxWidth: .infinity, maxHeight: 20)
                                .padding(8)
                                .background(Color(uiColor: .secondarySystemGroupedBackground))
                                .cornerRadius(8)
                                .shadow(radius: 1, x: 1, y: 1)
                                .draggable(fruit)
                        }
                    }
                    .clipped()
                 )
        }
    }
}

struct FruitView : View, Identifiable, Codable, Transferable{
    let name: String
    var id: UUID = UUID()
    
    init(name: String){
        self.name = name
    }
    
    static var transferRepresentation: some TransferRepresentation {
            CodableRepresentation(contentType: .fruit)
        }
    
    var body: some View {
        Text(name)
    }
}

extension UTType {
    static let fruit: UTType = UTType(exportedAs: "test.ios.app.fruit")
}

#Preview {
    ContentView()
}
