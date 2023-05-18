//
//  WordCell.swift
//  GameOfWords
//
//  Created by Daniil Rassadin on 18/5/23.
//

import SwiftUI

struct WordCell: View {
    let word: String
    
    var body: some View {
        HStack {
            Text(self.word)
                .foregroundColor(Color.white)
                .listRowSeparator(.hidden)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding()
                .font(.system(size: 22))
            Text(String(self.word.count))
                .foregroundColor(Color.white) 
                .padding()
                .font(.system(size: 22))
        }
    }
}

struct WordCell_Previews: PreviewProvider {
    static var previews: some View {
        WordCell(word: "Word")
    }
}
