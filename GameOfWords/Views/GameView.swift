//
//  GameView.swift
//  GameOfWords
//
//  Created by Daniil Rassadin on 16/5/23.
//

import SwiftUI

struct GameView: View {
    @State private var word = ""
    @State private var confirmPresent = false
    @State private var alertPresent = false
    @State private var alertText = ""
    let viewModel: GameViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.accentColor.ignoresSafeArea()
            VStack(spacing: 16) {
                HStack {
                    Button {
                        confirmPresent.toggle()
                    } label: {
                        Text("Quit")
                            .padding(6)
                            .padding(.horizontal)
                            .background(Color("FirstColor"))
                            .cornerRadius(15)
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                }
                
                Text(viewModel.word)
                    .font(.system(size: 36))
                    .foregroundColor(.white)
                HStack(spacing: 12) {
                    VStack {
                        Text(String(self.viewModel.firstPlayer.scores))
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                        Text(self.viewModel.firstPlayer.name)
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                    .padding(20)
                    .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                    .background(Color.red)
                    .cornerRadius(15)
                    .shadow(color: .red, radius: self.viewModel.isFirst ? 12 : 0)
                    .opacity(self.viewModel.isFirst ? 1 : 0.5)
                    
                    VStack {
                        Text(String(self.viewModel.secondPlayer.scores))
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                        Text(self.viewModel.secondPlayer.name)
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                    .padding(20)
                    .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                    .background(Color.blue)
                    .cornerRadius(15)
                    .shadow(color: .blue, radius: self.viewModel.isFirst ? 0 : 12)
                    .opacity(self.viewModel.isFirst ? 0.5 : 1)
                }
                
                WordTextField(placeholder: "Your word…", text: $word)
                    .padding(.horizontal, 20)
                
                Button {
                    do {
                        try self.viewModel.checkWord(self.word)
                        self.word = ""
                        // TODO: Find how to hide keyboard
                        UIApplication.shared.keyWindow?.endEditing(true)
                    } catch WordError.alreadyWas {
                        self.alertText = WordError.alreadyWas.rawValue
                        self.alertPresent.toggle()
                    } catch WordError.likeMainWord {
                        self.alertText = WordError.likeMainWord.rawValue
                        self.alertPresent.toggle()
                    } catch WordError.tooShort {
                        self.alertText = WordError.tooShort.rawValue
                        self.alertPresent.toggle()
                    } catch WordError.wrongLetters {
                        self.alertText = WordError.wrongLetters.rawValue
                        self.alertPresent.toggle()
                    } catch {
                        self.alertText = "Unexpected error."
                    }
                } label: {
                    Text("Accept")
                        .foregroundColor(Color.gray)
                        .font(.custom("AvenirNext-Bold", size: 35))
                        .frame(height: 40)
                }
                .padding()
                .frame(width: 300)
                .background(Color("SecondColor"))
                .cornerRadius(15)
                .padding(.top, 40)
                
                List {
                    ForEach(0..<self.viewModel.words.count, id: \.description) { item in
                        WordCell(word: self.viewModel.words[item])
                        // TODO: Setup the color of the cell depends of which player was first
                            .background(item % 2 == 0 ? Color.red : Color.blue)
                            .listRowInsets(EdgeInsets())
                    }
                }
                .listStyle(.plain)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }.confirmationDialog("Are you sure you want to quit?",
                             isPresented: $confirmPresent,
                             titleVisibility: .visible) {
            Button(role: .destructive) {
                self.dismiss()
            } label: {
                Text("Yes")
            }
        }.alert(self.alertText,
                isPresented: $alertPresent) {
            Text("OK")
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(firstPlayer: Player(name: "Vasya"),
                                          secondPlayer: Player(name: "Masha"),
                                          word: "Word"))
    }
}
