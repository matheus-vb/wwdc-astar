//
//  TutorialView.swift
//  AStar
//
//  Created by matheusvb on 19/04/23.
//

import SwiftUI

struct TutorialView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            Rectangle()
                .fill(Color.red)
                .frame(width: 100, height: 100)
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
