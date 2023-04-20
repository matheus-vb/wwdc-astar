//
//  NoPathCardView.swift
//  AStar
//
//  Created by matheusvb on 19/04/23.
//

import SwiftUI

struct PathDoneCardView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .strokeBorder(.black, lineWidth: 10)
                .background(Color.white)
            Text("Your pizza is finally here!")
                .font(.system(size: 24, design: .monospaced))
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .padding()
        }.frame(width: 550, height: 320)
            .cornerRadius(10)
    }
}

struct PathDoneCardView_Previews: PreviewProvider {
    static var previews: some View {
        PathDoneCardView()
    }
}
