//
//  CreditsView.swift
//  AStar
//
//  Created by matheusvb on 20/04/23.
//

import SwiftUI

struct CreditsView: View {
    @EnvironmentObject var appStatus: AppStatus
    
    let soundPlayer = SoundPlayer()
    
    var body: some View {
        ZStack {
            Color.theme.background
        
            VStack {
                ScrollView {
                    Text("Credits")
                        .font(.system(size: 42, design: .monospaced))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.top, 60)
                    
                    Text("Button sound: https://freesound.org/people/joedeshon/sounds/119415/, Author: joedeshon")
                        .font(.system(size: 32, design: .monospaced))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(60)
                    
                    Text("Running algorithm sound: https://freesound.org/people/kubawolanin/sounds/185609/, Author: kubawolanin")
                        .font(.system(size: 32, design: .monospaced))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(60)
                    
                    Text("Showing path sound: https://freesound.org/people/NenadSimic/sounds/268108/, Author: NenadSimic")
                        .font(.system(size: 32, design: .monospaced))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(60)
                    
                    Text("Placing end and start sound: https://freesound.org/people/trullilulli/sounds/422642/, Author: trullilulli")
                        .font(.system(size: 32, design: .monospaced))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(60)
                    
                    Text("Background music: https://freesound.org/people/Unlistenable/sounds/416778/, Author: Unlistenable")
                        .font(.system(size: 32, design: .monospaced))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(60)
                    
                    Text("A special thank you note for the Apple Developer Academy, the Federal University of Pernambuco and Apple!")
                        .font(.system(size: 22, design: .monospaced))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(60)
                }
            }
            Button(action: {                
                soundPlayer.playSound(name: "ticker", type: "mp3")
                
                withAnimation {
                    appStatus.appStatus = .algo
                }
                
            }, label: {
                Image(uiImage: UIImage(imageLiteralResourceName: "back"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 64, height: 64)
                    .position(x: 50, y: 70)
            })
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
