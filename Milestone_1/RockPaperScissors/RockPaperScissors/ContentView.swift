//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Emrehan Kaya on 31.08.2024.
//

import SwiftUI


struct buttonLook: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: 15.0))
            .shadow(color: .white, radius: 3, x: 0.0, y: 0.0)
            .background(.blue.secondary)
    }
}

extension View {
    func buttonStyle() -> some View {
        self.modifier(buttonLook())
    }
}

struct ContentView: View {

    var possibleMoves = ["Taş", "Kağıt", "Makas"]

    @State private var appChoice = Int.random(in: 0 ..< 3)
    @State private var playerWinLose = Bool.random()

    var winOrLoseText: String {
        if playerWinLose == true {
            return "KAZAN!"
        } else {
            return "KAYBET!"
        }
    }

    @State private var playerScore = 0
    @State private var playCount = 1

    @State private var gameOver = false
    @State private var title = false
    @State private var titleString = ""

    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color(red: 0.2, green: 0.2, blue: 0.5)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 50) {
                VStack {
                    Text("Siri'nin seçimi")
                    Text("\(possibleMoves[appChoice])")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Image(self.possibleMoves[appChoice])
                        .buttonStyle()
                }
                
                VStack {
                    Text("\(winOrLoseText)")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(playerWinLose ? Color.green : Color.red)
                    
                }
                
                VStack(spacing: 5) {
                    HStack(spacing: 60) {
                        Text("🪨")
                        Text("🗒️")
                        Text("✂️")
                    }
                    .font(.largeTitle)
                    HStack {
                        ForEach(0 ..< 3) { item in
                            Button(action: {
                                self.playerChoice(item)
                                continueGame()
                            }) {
                                Image(self.possibleMoves[item])
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .buttonStyle()
                            }
                        }
                    }
                }
                
                VStack(spacing: 10) {
                    Text("Round \(playCount) of 10")
                        .fontWeight(.bold)
                    Text("Score: \(playerScore)")
                        .fontWeight(.bold)
                }
            }
            .foregroundColor(.white)
        }
        .alert(isPresented: $gameOver) {
            Alert(title: Text("Game over!"), message: Text("Final skorun \(playerScore)/10"), dismissButton: .default(Text("Tekrar Oyna")) {
                resetGame()
            })
        }
    }

    func playerChoice (_ item : Int) {
        if playerWinLose == true {
            if item == appChoice {
                print("Berabere")
            } else if item == 2 && item == 0 {
                print("Kaybettin, sen makas seçtin, bilgisayar taş seçti")
            } else if item == 0 && item == 1 {
                print("Kaybettin, sen taş sectin, bilgisayar kağıt")
            } else if item == 1 && item == 2  {
                print("Kaybettin, sen kağıt seçtin, bilgisayar makas")
            } else {
                print("Kazandın")
                playerScore += 1
            }
        } else  {
            if item == appChoice {
                print("berabere")
            } else if item == 2 && item == 0 {
              print("Kazandin, sen makas sectin, bilgisayar taş secti")
                playerScore += 1
            } else if item == 0 && item == 1 {
                print("Kazandin, sen taş sectin, bilgisatar kağıt secti")
                playerScore += 1
            } else if item == 1 && item == 2 {
                print("Kazandin, sen kagıt sectin, bilgisayar makas secti")
                 playerScore += 1
            } else {
                print("Kaybettin")
            }
        }
    }

    func continueGame() {
        if playCount == 10 {
            gameOver = true
        } else {
            playCount += 1
            appChoice = Int.random(in: 0 ..< 3)
            playerWinLose = Bool.random()
        }
    }

    func resetGame() {
        appChoice = Int.random(in: 0 ..< 3)
        playerWinLose = Bool.random()
        playCount = 1
        playerScore = 0
    }
}

#Preview {
    ContentView()
}
