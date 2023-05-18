//
//  Player.swift
//  GameOfWords
//
//  Created by Daniil Rassadin on 17/5/23.
//

import Foundation

struct Player {
    let name: String
    private(set) var scores = 0
    
    mutating func addScores(_ scores: Int) {
        self.scores += scores
    }
}
