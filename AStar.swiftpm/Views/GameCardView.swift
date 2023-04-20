//
//  GameCardView.swift
//  AStar
//
//  Created by matheusvb on 20/04/23.
//

import SwiftUI

enum GameSteps {
    case first
    case second
    case third
}

struct GameCardView: View {
    let step: GameSteps
    
    var body: some View {
        ZStack{
            Color.theme.lightGreen
            switch(step) {
            case .first:
                HStack {
                    Image(uiImage: UIImage(imageLiteralResourceName: "biker"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .padding(.trailing)
                    Text("1º - Tap on where you want your pizza to come from!")
                        .font(.system(size: 22, design: .monospaced))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom)
                        .frame(height: 80)
                }
                .padding()
            case .second:
                HStack {
                    Image(uiImage: UIImage(imageLiteralResourceName: "house"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .padding(.trailing)
                    Text("2º - Tap on where you are!")
                        .font(.system(size: 22, design: .monospaced))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom)
                }
            case .third:
                HStack {
                    Rectangle()
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color.theme.darkBlue)
                        .cornerRadius(10)
                        .padding(.trailing)
                    Text("3º - Draw any possible barriers!")
                        .font(.system(size: 22, design: .monospaced))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
            }
        }
        .frame(width: 620, height: 80)
        .cornerRadius(20)
    }
}

struct GameCardView_Previews: PreviewProvider {
    static var previews: some View {
        GameCardView(step: .third)
    }
}
