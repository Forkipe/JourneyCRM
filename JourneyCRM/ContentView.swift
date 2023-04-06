//
//  ContentView.swift
//  JourneyCRM
//
//  Created by Марк Горкій on 06.04.2023.
//

import SwiftUI
import Firebase
struct ContentView: View {
    @EnvironmentObject var dataManger:DataManager
    @State private var userIsLoggedIn = false
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        if userIsLoggedIn{
            HomeView()
        } else {
            content
        }
    }
    var content: some View {
        ZStack{
            Color(UIColor(red: 0.01, green: 0.5, blue: 0.32, alpha: 1))
                .ignoresSafeArea()
            RoundedRectangle(cornerRadius: 30, style: .continuous).rotationEffect(.degrees(135))
                .offset(x:100,y:-300)
                .foregroundStyle(LinearGradient(colors: [.white, .gray], startPoint: .topLeading, endPoint: .bottomTrailing))
            
            VStack {
                Text("Welcome").offset(x:-95,y:-50)
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .foregroundColor(orange)
                TextField("", text: $email)
                    .placeholder(when: email.isEmpty) {
                    Text("Email")
                        .bold()
                        .foregroundColor(.white)
                    }.offset(x:20)
                    .textFieldStyle(.plain)
                    .foregroundColor(.white)
                Rectangle()
                    .offset(y:-10)
                    .foregroundColor(.white)
                    .frame(width:350, height:1)
                SecureField("", text:$password).placeholder(when: password.isEmpty){
                    Text("Password")
                        .bold()
                        .foregroundColor(.white)
                }.offset(x:20)
                    .textFieldStyle(.plain)
                    .foregroundColor(.white)
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width:350, height:1)
                Button{
                    register()
                } label: {
                    Text("Sign up")
                        .frame(width:200, height:40)
                        .bold()
                        .foregroundColor(.black)
                        .background(RoundedRectangle(cornerRadius: 14,style: .continuous).foregroundStyle((LinearGradient(colors: [.white, .gray], startPoint: .top, endPoint: .bottomTrailing))))
                        
                }
                .padding(.top)
                .offset(y:100)
                Button{
                    login()
                } label: {
                    Text("Already have an account?Login")
                        .bold()
                        .foregroundColor(.white)
                }
                .padding(.top)
                .offset(y:110)
            }.frame(width:350)
                .onAppear{
                    Auth.auth().addStateDidChangeListener {auth, user in if user != nil {
                        userIsLoggedIn.toggle()
                    }
                    }
                }.modifier(CustomTransition())
        }
        .ignoresSafeArea()
    }
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) {result, error in if error != nil{
            print(error!.localizedDescription)
        }
            
        }
    }
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in if error != nil {
            print(error!.localizedDescription)
        }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(DataManager())
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
struct CustomTransition: ViewModifier {
    func body(content: Content) -> some View {
        content
            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
    }
}
