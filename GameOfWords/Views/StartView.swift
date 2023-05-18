//
//  StartView.swift
//  GameOfWords
//
//  Created by Daniil Rassadin on 16/5/23.
//

import SwiftUI

struct StartView: View {
    @State private var mainWord: String = ""
    @State private var firstPlayerName: String = ""
    @State private var secondPlayerName: String = ""
    @State private var isShowedGame = false
    @State private var isAlertPresented = false
    
    var body: some View {
        ZStack {
            Color.accentColor.ignoresSafeArea()
            VStack {
                Title(titleText: "Game of Words")
                
                WordTextField(placeholder: "A big word", text: $mainWord)
                    .padding(20)
                    .padding(.top, 60)
                
                WordTextField(placeholder: "The first player's name", text: $firstPlayerName)
                    .padding(.horizontal, 20)
                
                WordTextField(placeholder: "The second player's name", text: $secondPlayerName)
                    .padding(.horizontal, 20)
                
                Button {
                    if self.mainWord.count > 5 {
                        self.isShowedGame.toggle()
                    } else {
                        self.isAlertPresented.toggle()
                    }
                } label: {
                    Text("Start")
                        .foregroundColor(Color.gray)
                        .font(.custom("AvenirNext-Bold", size: 35))
                        .frame(height: 40)
                }
                .alert("The word is too short", isPresented: $isAlertPresented, actions: {
                    Text("OK")
                })
                .padding()
                .frame(width: 300)
                .background(Color("SecondColor"))
                .cornerRadius(15)
                .padding(.top, 40)
            }
        }
        .fullScreenCover(isPresented: $isShowedGame) {
            GameView(viewModel: GameViewModel(firstPlayer: Player(name: self.firstPlayerName.isEmpty ? "First player" : self.firstPlayerName),
                                              secondPlayer: Player(name: self.secondPlayerName.isEmpty ? "Second player" : self.secondPlayerName),
                                              word: self.mainWord))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
