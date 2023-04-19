//
//  NoPathCardView.swift
//  AStar
//
//  Created by matheusvb on 19/04/23.
//

import SwiftUI

struct NoPathCardView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .strokeBorder(.black, lineWidth: 10)
                .background(Color.white)
            Text("It's impossible to get there!")
                .font(.system(size: 24, design: .monospaced))
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .padding()
        }.frame(width: 550, height: 320)
            .cornerRadius(10)
    }
}

struct NoPathCardView_Previews: PreviewProvider {
    static var previews: some View {
        NoPathCardView()
    }
}
