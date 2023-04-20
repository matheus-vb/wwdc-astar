//
//  FirstCardView.swift
//  AStar
//
//  Created by matheusvb on 19/04/23.
//

import SwiftUI

struct SecondCardView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .strokeBorder(.black, lineWidth: 10)
                .background(Color.white)
            VStack {
                Text("And here is where the ASTAR Algorithm comes in place! The algorithm keeps checking the distance of a possible path to the final spot, and if a spot is closer to the end than your current location, it is considered as a candidate to the best possible path.")
                    .font(.system(size: 24, design: .monospaced))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            .padding(.all, 40)
        }.frame(width: 450, height: 520)
            .cornerRadius(10)
    }
}

struct SecondCardView_Previews: PreviewProvider {
    static var previews: some View {
        SecondCardView()
    }
}
