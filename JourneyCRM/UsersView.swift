//
//  UsersView.swift
//  JourneyCRM
//
//  Created by Марк Горкій on 06.04.2023.
//

import Foundation
import Firebase
import SwiftUI

struct UsersView: View {
    @State private var isShowingMenu = false
    @State private var id = ""
    @EnvironmentObject var dataManger: DataManager
    @State private var isExpanded = false
    @State private var role: String = ""
    let Roles:[String] = ["Administrator", "Driver", "Passenger"]
    var body: some View{
        ZStack {
            NavigationView{
                List{
                    ForEach(dataManger.users, id: \.id.self) { user in
                        DisclosureGroup(user.name) {
                            VStack{
                                Text("Age: \(user.age)")
                                Text("Email: \(user.email)")
                                Text("Role: \(user.role)")
                                    Picker("Role", selection: $role) {
                                        ForEach(Roles, id: \.self) { option in
                                            Text(option)
                                        }
                                    }
                                    .pickerStyle(SegmentedPickerStyle())
                                
                                Button {
                                    dataManger.editRole(userRole: role, userId: user.id)
                                    print("hi")
                                } label:  {
                                    Text("Save").frame(width:120, height: 40)
                                        .foregroundColor(.white)
                                        .background(RoundedRectangle(cornerRadius: 14)
                                            .foregroundColor(orange))
                                }
                            }
                        }
                    }
                }.background() {
                    Color(UIColor(red: 0.01, green: 0.5, blue: 0.32, alpha: 1))
                        .ignoresSafeArea()
                    RoundedRectangle(cornerRadius: 30, style: .continuous).rotationEffect(.degrees(135))
                        .offset(x:110,y:-310)
                        .foregroundStyle(LinearGradient(colors: [.white, .gray], startPoint: .topLeading, endPoint: .bottomTrailing))
                }.navigationBarItems(
                    leading: Button(action: {
                        isShowingMenu.toggle()
                    }) {
                        Image(systemName: "list.bullet").foregroundColor(.black)
                    }
                )
                .scrollContentBackground(.hidden)
                .navigationTitle("Users")
            }
        GeometryReader { geometry in
                        ZStack {
                            Color.black.opacity(0.3)
                                .opacity(isShowingMenu ? 1 : 0)
                                .animation(.easeInOut(duration: 0.3))
                                .onTapGesture {
                                    isShowingMenu = false
                                }
                            
                            SideMenu(isShowingMenu: $isShowingMenu).offset(x:-60)
                                .frame(width: geometry.size.width * 0.7)
                                .offset(x: isShowingMenu ? 0 : -geometry.size.width * 0.8)
                                .animation(.easeInOut(duration: 0.3))
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .navigationBarTitleDisplayMode(.inline)
            }
    }



struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView().environmentObject(DataManager())
    }
}
