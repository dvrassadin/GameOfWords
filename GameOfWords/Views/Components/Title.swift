//
//  Title.swift
//  GameOfWords
//
//  Created by Daniil Rassadin on 16/5/23.
//

import SwiftUI

struct Title: View {
    @State var titleText: String
    
    var body: some View {
        Text(titleText)
            .padding()
            .frame(maxWidth: .infinity)
            .font(.custom("AvenirNext-Bold", size: 42))
            .background(Color("FirstColor"))
            .cornerRadius(15)
            .foregroundColor(.white)
    }
}

struct Title_Previews: PreviewProvider {
    static var previews: some View {
        Title(titleText: "Game of Words")
    }
}
