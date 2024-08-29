//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Emrehan Kaya on 28.08.2024.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var restartGame = false
    @State private var gameCounter = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 240, endRadius: 400)
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)

                VStack(spacing: 15) {
                    Text("Tap the flag of")
                        .font(.subheadline.weight(.heavy))
                        .foregroundStyle(.secondary)
                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.semibold))
                        .foregroundStyle(.black)
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            restart()
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                        .alert(scoreTitle, isPresented: $showingScore) {
                            Button("Continue", action: askQuestion)
                        } message: {
                            Text("Your score is \(userScore)")
                        }
                        .alert(scoreTitle, isPresented: $restartGame) {
                            Button("New Game", action: restart)
                        } message: {
                            Text("Your final score")
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical,20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
            
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
}
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
            gameCounter += 1

        } else {
            scoreTitle = "Wrong! That's the flags of \(countries[number])"
            userScore -= 1;
            if userScore < 0 {
                userScore = 0
            }
            gameCounter += 1
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restart() {
        if gameCounter == 8 {
            scoreTitle = "\(userScore)"
            showingScore = false
            restartGame = true
            userScore = 0
        }
    }
        }
#Preview {
    ContentView()
}
