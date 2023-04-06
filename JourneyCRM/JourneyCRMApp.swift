//
//  JourneyCRMApp.swift
//  JourneyCRM
//
//  Created by Марк Горкій on 06.04.2023.
//

import SwiftUI
import Firebase

@main
struct JourneyCRMApp: App {
    @StateObject var dataManager = DataManager()
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(dataManager)
        }
    }
}
