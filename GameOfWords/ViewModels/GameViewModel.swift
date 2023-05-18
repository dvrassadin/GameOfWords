//
//  GameViewModel.swift
//  GameOfWords
//
//  Created by Daniil Rassadin on 17/5/23.
//

import Foundation

enum WordError: String, Error {
    case likeMainWord = "Don't repeat the main word."
    case tooShort = "This word is too short."
    case alreadyWas = "This word already was."
    case wrongLetters = "Not all the letters are in the main word."
}

class GameViewModel: ObservableObject {
    @Published private(set) var firstPlayer: Player
    @Published private(set) var secondPlayer: Player
    @Published private(set) var words = [String]()
    private(set) var isFirst = Bool.random()
    let word: String
    
    init(firstPlayer: Player, secondPlayer: Player, word: String) {
        self.firstPlayer = firstPlayer
        self.secondPlayer = secondPlayer
        self.word = word.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
    
    private func validate(word: String) throws {
        let word = word.lowercased()
        
        guard word != self.word else {
            print(WordError.likeMainWord.rawValue)
            throw WordError.likeMainWord
        }
        
        guard !self.words.contains(word) else {
            print(WordError.alreadyWas.rawValue)
            throw WordError.alreadyWas
        }
        
        guard word.count > 1 else {
            print(WordError.tooShort.rawValue)
            throw WordError.tooShort
        }
    }
    
    private func wordToDict(word: String) -> [Character: Int] {
        var charsDict = [Character: Int]()
        
        for char in word.lowercased() {
            if let value = charsDict[char] {
                charsDict[char] = value + 1
            } else {
                charsDict[char] = 1
            }
        }
        return charsDict
    }
    
    func checkWord(_ word: String) throws {
        do {
            try self.validate(word: word)
        } catch {
            throw error
        }
        
        var mainWordDict = wordToDict(word: self.word)
        let word = word.lowercased()
        
        for char in word {
            if let value = mainWordDict[char] {
                if value == 1 {
                    mainWordDict.removeValue(forKey: char)
                } else {
                    mainWordDict[char] = value - 1
                }
            } else {
                print(WordError.wrongLetters.rawValue)
                throw WordError.wrongLetters
            }
        }
        self.words.append(word)
        
        self.isFirst ? self.firstPlayer.addScores(word.count) : self.secondPlayer.addScores(word.count)
        self.isFirst.toggle()
    }
}
