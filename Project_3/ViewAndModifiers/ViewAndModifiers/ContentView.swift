//
//  ContentView.swift
//  ViewAndModifiers
//
//  Created by Emrehan Kaya on 30.08.2024.
//

import SwiftUI

struct Custom: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        content
        Text(text)
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

extension View {
    func blueTitle(with text: String) -> some View {
        modifier(Custom(text: text))
    }
}

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello world")
            .titleStyle()
            .watermarked(with: "Emrehan Kaya")
            .padding()
        
        Text("")
            .blueTitle(with: "Merhaba Dünya")
    }
}

#Preview {
    ContentView()
}
