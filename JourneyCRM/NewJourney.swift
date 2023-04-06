//
//  NewJourney.swift
//  JourneyCRM
//
//  Created by Марк Горкій on 06.04.2023.
//

import SwiftUI

struct NewJourneyView: View{
    @Binding var show: Bool
    @EnvironmentObject var dataManager: DataManager
    @State private var number = ""
    @State private var from = ""
    @State private var to = ""
    @State private var passengers = ""
    var body: some View {
        ZStack{
            Color(UIColor(red: 0.01, green: 0.5, blue: 0.32, alpha: 1))
            Text("ADD JOURNEY").offset(x:0,y:-170)
                .font(.system(size: 42))
                .bold()
                .foregroundColor(orange)
            VStack {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width:350, height:1)
                
                TextField("", text: $number).placeholder(when: number.isEmpty) {
                    Text("Car number:")
                        .foregroundColor(.white)
                        .offset(x:30)
                        .bold()
                }
                
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width:350, height:1)
                
                TextField("", text: $from).placeholder(when: from.isEmpty) {
                    Text("From:")
                        .foregroundColor(.white)
                        .offset(x:30)
                        .bold()
                }
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width:350, height:1)
                
                TextField("", text: $to).placeholder(when: to.isEmpty) {
                    Text("Destinition:").foregroundColor(.white)
                        .offset(x:30)
                        .bold()
                }
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width:350, height:1)
                
                TextField("", text: $passengers).placeholder(when: passengers.isEmpty) {
                    Text("Passengers:")
                        .foregroundColor(.white)
                        .offset(x:30)
                        .bold()
                }
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width:350, height:1)
                
                Button {
                    show = false
                    dataManager.addJourney(journeyStartPoint: from, journeyPassengers: passengers, journeyEndPoint: to, journeyId: number)
                } label: {
                    Text("Save").frame(width:120, height: 40)
                        .foregroundColor(.black)
                        .background(RoundedRectangle(cornerRadius: 14)
                            .foregroundStyle(.linearGradient(colors: [.white,.white], startPoint: .top, endPoint: .bottomTrailing)))
                }.offset(y:50)
                .padding(.top)
                
                
            }
        }.ignoresSafeArea()
    }
}

