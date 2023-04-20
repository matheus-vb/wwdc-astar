//
//  FirstCardView.swift
//  AStar
//
//  Created by matheusvb on 19/04/23.
//

import SwiftUI

struct ThirdCardView: View {
    let soundPlayer = SoundPlayer()
    
    @EnvironmentObject var appStatus: AppStatus

    var body: some View {
        ZStack {
            Rectangle()
                .strokeBorder(.black, lineWidth: 10)
                .background(Color.white)
            VStack {
                Text("It may be hard to understand how all that actually works, specially without being able to see it. But worry no more! You're about to find out how your pizza gets home so fast!")
                    .font(.system(size: 24, design: .monospaced))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                Button(action: {
                    soundPlayer.playSound(name: "ticker", type: "mp3")
                    
                    withAnimation {
                        appStatus.appStatus = .algo
                    }
                }, label: {
                    Image(uiImage: UIImage(imageLiteralResourceName: "go"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 96, height: 96)
                })
            }
            .padding(.all, 40)
        }.frame(width: 450, height: 520)
            .cornerRadius(10)
    }
}

struct ThirdCardView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdCardView()
    }
}
