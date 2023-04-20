//
//  TutorialCardView.swift
//  AStar
//
//  Created by matheusvb on 19/04/23.
//

import SwiftUI

struct TutorialCardView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .strokeBorder(.black, lineWidth: 10)
                .background(Color.white)
            VStack {
                HStack {
                    Image(uiImage: UIImage(imageLiteralResourceName: "biker"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .padding(.trailing)
                    Text("1º - Select where you want your pizza to come from! This will be the starting point")
                        .font(.system(size: 24, design: .monospaced))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom)
                }
                HStack {
                    Image(uiImage: UIImage(imageLiteralResourceName: "house"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .padding(.trailing)
                    Text("2º - Select where you are! This will be the ending point")
                        .font(.system(size: 24, design: .monospaced))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom)
                }
                HStack {
                    Rectangle()
                        .frame(width: 96, height: 96)
                        .foregroundColor(Color.theme.darkBlue)
                        .cornerRadius(10)
                        .padding(.trailing)
                    Text("3º - Draw any possible barriers! They will represent paths that our delivery man can not go through")
                        .font(.system(size: 24, design: .monospaced))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding(.all, 40)
        }.frame(width: 550, height: 620)
            .cornerRadius(10)
    }
}

struct TutorialCardView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialCardView()
    }
}
