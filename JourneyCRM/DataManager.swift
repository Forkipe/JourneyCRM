//
//  DataManager.swift
//  JourneyCRM
//
//  Created by Марк Горкій on 06.04.2023.
//

import Firebase
import SwiftUI

class DataManager: ObservableObject {
    @Published var journeys: [Journey] = []
    
    init(){
        fetchJourneys()
    }
    
    func fetchJourneys() {
        journeys.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Journeys")
        ref.getDocuments{ snapshot, error in
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
    }
    func addJourney(journeyStartPoint: String, journeyPassengers: String, journeyEndPoint: String, journeyId: String) {
        let db = Firestore.firestore()
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

}
