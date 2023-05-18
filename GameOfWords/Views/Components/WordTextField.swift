//
//  WordTextField.swift
//  GameOfWords
//
//  Created by Daniil Rassadin on 16/5/23.
//

import SwiftUI

struct WordTextField: View {
    var placeholder: String
    @State var text: Binding<String>
    
    var body: some View {
        TextField(placeholder, text: text)
            .padding()
            .font(.title3)
            .background(Color.white)
            .cornerRadius(15)
    }
}

struct WordTextField_Previews: PreviewProvider {
    static var previews: some View {
        WordTextField(placeholder: "Enter the text", text: .constant(""))
    }
}
