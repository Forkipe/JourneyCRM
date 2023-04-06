//
//  MainView.swift
//  JourneyCRM
//
//  Created by Марк Горкій on 06.04.2023.
//

import SwiftUI
let UIorange = UIColor(red: 0.7, green: 0.48, blue: 0, alpha: 1)
let orange = Color(UIorange)
struct HomeView:View {
    @State private var isExpanded = false
    @EnvironmentObject var dataManger:DataManager
    @State private var show = false
    var body: some View{
        content
    }
    var content: some View{
        NavigationView {
            List(dataManger.journeys, id: \.id) { journey in
                DisclosureGroup(isExpanded: $isExpanded, content: {
                    Text("passengers:\(journey.passengers)")
                    Text("Car number:\(journey.id)")
                    Text("Destination:\(journey.endPoint)")
                }, label: { HStack {
                    Text(journey.startPoint)
                }
                })
            }.scrollContentBackground(.hidden)
                .navigationTitle("Journeys")
                .navigationBarItems( trailing: Button(action:{
                    show.toggle()
                }, label: {
                    Image(systemName: "plus.circle").resizable()
                        .foregroundColor(orange)
                        .frame(width:30,height:30)
                }))
                .sheet(isPresented: $show){
                    NewJourneyView(show: $show)
                }.background() {
                    Color(UIColor(red: 0.01, green: 0.5, blue: 0.32, alpha: 1))
                        .ignoresSafeArea()
                    RoundedRectangle(cornerRadius: 30, style: .continuous).rotationEffect(.degrees(135))
                        .offset(x:110,y:-310)
                        .foregroundStyle(LinearGradient(colors: [.white, .gray], startPoint: .topLeading, endPoint: .bottomTrailing))
                }
            
        }
        
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(DataManager())
    }
}
