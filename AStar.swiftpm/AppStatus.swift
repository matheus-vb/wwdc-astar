//
//  AppStatus.swift
//  AStar
//
//  Created by matheusvb on 18/04/23.
//

import Foundation

class AppStatus: ObservableObject {
    @Published var appStatus: AppStatusEnum = .intro
}

enum AppStatusEnum {
    case intro
    case algo
}
