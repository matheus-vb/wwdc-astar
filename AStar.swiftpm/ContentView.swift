//
//  ContentView.swift
//  AStar
//
//  Created by matheusvb on 18/04/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var appStatus = AppStatus()
    
    var body: some View {
        switch(appStatus.appStatus) {
        case .intro:
            IntroView()
                .environmentObject(appStatus)
        case .algo:
            AStarView()
                .environmentObject(appStatus)
        case .credits:
            CreditsView()
                .environmentObject(appStatus)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
