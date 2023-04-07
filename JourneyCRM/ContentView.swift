//
//  ContentView.swift
//  JourneyCRM
//
//  Created by Марк Горкій on 06.04.2023.
//

import SwiftUI
import Firebase
struct ContentView: View {
    var roles = ["Administrator", "Driver", "Passenger"]
    @EnvironmentObject var dataManger:DataManager
    @State private var userIsLoggedIn = false
    @State private var email = ""
    @State private var password = ""
    @State private var role = ""
    @State private var age = ""
    @State private var name = ""
    @State private var id = ""
    
    var body: some View {
        if userIsLoggedIn{
            UsersView()
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
                .foregroundStyle(LinearGradient(colors: [.white, .gray], startPoint: .top, endPoint: .bottomTrailing))
            
            VStack {
                Text("Welcome").offset(x:-95,y:-50)
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                
                TextField("", text: $email)
                    .placeholder(when: email.isEmpty) {
                    Text("Email")
                        .bold()
                        .foregroundColor(.white)
                    }.offset(x:20)
                    .textFieldStyle(.plain)
                    .foregroundColor(.white)

                TextField("", text: $name)
                    .placeholder(when: name.isEmpty) {
                    Text("Name")
                        .bold()
                        .foregroundColor(.white)
                    }.offset(x:20)
                    .textFieldStyle(.plain)
                    .foregroundColor(.white)

                TextField("", text: $age)
                    .placeholder(when: age.isEmpty) {
                    Text("Age")
                        .bold()
                        .foregroundColor(.white)
                    }.offset(x:20)
                    .textFieldStyle(.plain)
                    .foregroundColor(.white)

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
                
                Picker("", selection: $role){
                    ForEach(roles, id: \.self){
                        Text($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                Button{
                    register()
                    dataManger.addUser(userAge: age, userEmail: email, userRole: role, userId: uuid, userName: name)
                } label: {
                    Text("Sign up")
                        .frame(width:200, height:40)
                        .bold()
                        .foregroundColor(.black)
                        .background(RoundedRectangle(cornerRadius: 14,style: .continuous).foregroundStyle((LinearGradient(colors: [.white, .gray], startPoint: .top, endPoint: .bottomTrailing))))
                        
                }
                .padding(.top)
                .offset(y:100)
                Button {
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
