//
//  DataManager.swift
//  JourneyCRM
//
//  Created by Марк Горкій on 06.04.2023.
//

import Firebase
import SwiftUI

class DataManager: ObservableObject {
    let db = Firestore.firestore()
    @Published var journeys: [Journey] = []
    @Published var users: [User] = []
    @Published var names = []
    init(){
        fetchData()
    }
    
    func fetchData() {
        journeys.removeAll()
        let ref = db.collection("Journeys")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let passengers = data["passengers"] as? String ?? ""
                    let startPoint = data["startPoint"] as? String ?? ""
                    let endPoint = data["endPoint"] as? String ?? ""
                    
                    let journey = Journey(id: id, passengers: passengers, startPoint: startPoint, endPoint: endPoint)
                    self.journeys.append(journey)
                }
            }
        }
        users.removeAll()
        let ref1 = db.collection("Users")
        ref1.getDocuments{ snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let id = data["id"] as? String ?? ""
                    let age = data["age"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    let role = data["role"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    
                    let user = User(id: id, email: email, role: role, age: age, name: name)
                    self.users.append(user)
                }
            }
        }
    }
    
    
    
    func addJourney(journeyStartPoint: String, journeyPassengers: String, journeyEndPoint: String, journeyId: String) {
        let journeyData = ["startPoint": journeyStartPoint,
                           "passengers": journeyPassengers,
                           "endPoint": journeyEndPoint,
                           "id": journeyId]
        db.collection("Journeys").document(journeyId).setData(journeyData) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func addUser(userAge: String, userEmail:String, userRole:String, userId:String, userName: String){
        let userData = [ "email": userEmail,
                         "age": userAge,
                         "role": userRole,
                         "id": userId,
                         "name": userName]
        db.collection("Users").document(userId).setData(userData) { error in if let error = error {
            print(error.localizedDescription)
        }
            
        }
    }
    func editRole(userRole: String, userId: String){
        let userrole = ["role": userRole]
        db.collection("Users").document(userId).updateData(userrole) { error in if let error = error {
            print(error.localizedDescription)
        }
        }
    }
}

