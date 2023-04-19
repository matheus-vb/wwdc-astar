//
//  IntroView.swift
//  AStar
//
//  Created by matheusvb on 18/04/23.
//

import SwiftUI

struct IntroView: View {
    @EnvironmentObject var appStatus: AppStatus
    
    var body: some View {
        ZStack {
            Color.theme.darkBackground
                .edgesIgnoringSafeArea(.all)
            VStack() {
                Image(uiImage: UIImage(imageLiteralResourceName: "logo"))
                    .resizable()
                    .scaledToFit()
                TabView {
                    Group {
                        FirstCardView()
                    }
                    
                    Group {
                        SecondCardView()
                    }
                    Group {
                        ThirdCardView()
                            .environmentObject(appStatus)
                    }
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .offset(y: -100)
                Spacer()
                
            }
        }
    }
}
