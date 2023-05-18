//
//  SplashScreenView.swift
//  GameOfWords
//
//  Created by Daniil Rassadin on 16/5/23.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            StartView()
        } else {
            ZStack {
                Color.accentColor.ignoresSafeArea()
                VStack {
                    Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                        .resizable()
                        .frame(maxWidth: 120, maxHeight: 120)
                        .cornerRadius(17)
                        .padding()
                        .font(.system(size: 80))
                        .foregroundColor(Color("FirstColor").opacity(0.8))
                    
                    Text("Game of Words")
                        .padding()
                        .foregroundColor(Color("SecondColor"))
                        .font(.custom("AvenirNext-Bold", size: 42))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 1.0
                        self.opacity = 1.0
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
