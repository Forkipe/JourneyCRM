//
//  SideMenuItem.swift
//  JourneyCRM
//
//  Created by Марк Горкій on 07.04.2023.
//

import Foundation
import SwiftUI

//struct SideMenu: View {
//    var body: some View {
//        NavigationView {
//            List {
//                NavigationLink(destination: Text("Option 1")) {
//                    Label("Option 1", systemImage: "1.circle")
//                }
//                NavigationLink(destination: Text("Option 2")) {
//                    Label("Option 2", systemImage: "2.circle")
//                }
//            }
//            .listStyle(SidebarListStyle())
//            .navigationTitle("Menu")
//            Text("Select an option")
//        }
//    }
//}
//

struct SideMenu: View {
    @Binding var isShowingMenu:Bool
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: UsersView()) {
                    Label("Users", systemImage: "1.circle")
                }
                NavigationLink(destination: JourneyView()) {
                    Label("Journeys", systemImage: "2.circle")
                }
            }.background() {
                Color(UIColor(red: 0.01, green: 0.5, blue: 0.32, alpha: 1)).ignoresSafeArea()
                
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Menu")
            .listStyle(SidebarListStyle())
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isShowingMenu.toggle()
                }) {
                    Text("Close")
                }
            }
        }
    }
}


