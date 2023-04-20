//
//  NoPathView.swift
//  AStar
//
//  Created by matheusvb on 19/04/23.
//

import SwiftUI

struct PathDoneView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            PathDoneCardView()
        }
    }
}

struct PathDoneView_Previews: PreviewProvider {
    static var previews: some View {
        PathDoneView()
    }
}
