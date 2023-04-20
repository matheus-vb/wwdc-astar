//
//  FirstCardView.swift
//  AStar
//
//  Created by matheusvb on 19/04/23.
//

import SwiftUI

struct FirstCardView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .strokeBorder(.black, lineWidth: 10)
                .background(Color.white)
            VStack {
                Text("How does a GPS finds the best way of getting from one point to another? Does it check every possibility and shows you the faster one? It would be impossible to check every path, the combinations are infite!")
                    .font(.system(size: 24, design: .monospaced))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            .padding(.all, 40)
        }.frame(width: 450, height: 520)
            .cornerRadius(10)
    }
}

struct FirstCardView_Previews: PreviewProvider {
    static var previews: some View {
        FirstCardView()
    }
}
