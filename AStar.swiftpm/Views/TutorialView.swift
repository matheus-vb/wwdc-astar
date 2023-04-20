//
//  TutorialView.swift
//  AStar
//
//  Created by matheusvb on 19/04/23.
//

import SwiftUI

struct TutorialView: View {
    @Binding var showingTutorial: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation() {
                        showingTutorial = false                        
                    }
                }
            TutorialCardView()
        }
    }
}


