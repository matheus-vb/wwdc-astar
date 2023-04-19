//
//  NoPathView.swift
//  AStar
//
//  Created by matheusvb on 19/04/23.
//

import SwiftUI

struct NoPathView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            NoPathCardView()
        }
    }
}

struct NoPathView_Previews: PreviewProvider {
    static var previews: some View {
        NoPathView()
    }
}
