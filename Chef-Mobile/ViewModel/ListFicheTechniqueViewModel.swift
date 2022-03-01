//
//  ListFicheTechniqueViewModel.swift
//  Chef-Mobile
//
//  Created by Adnane El Abbas on 01/03/2022.
//

import Foundation
import Combine
import FirebaseFirestoreSwift
import Firebase
import FirebaseFirestore

class ListFicheTechniqueViewModel : ObservableObject, Subscriber {
    
    typealias Input = IntentStateFicheTechnique
    
    typealias Failure = Never
    
    @Published var model : [FicheTechnique] = []
    private let firestore = Firestore.firestore()
    
    init(){
        fetchData()
    }
    
    func fetchData(){
        
        
        firestore.collection("Fiche technique")
            .addSnapshotListener{ (data, error) in
                guard let documents = data?.documents else {
                    return
                }
                
                self.model = documents.map{
                    (doc) -> FicheTechnique in
                    return FicheTechnique(id: doc.documentID,
                                          nomFiche: doc["NomPlat"] as? String ?? "",
                                          nomAuteur: doc["NomAuteur"] as? String ?? "",
                                          nbCouvert: doc["NbCouvert"] as? Int ?? 0,
                                          tabEtape: []
                    )
                    
                }
            }
    }
    func ajoutFicheTechnique(FT: FicheTechnique){
        firestore.collection("Fiche technique").addDocument(data: ["nomPlat" : FT.nomFiche , "nomAuteur" : FT.nomAuteur ,
                                                                   "NbCouvert" : FT.nbCouvert, "Etape" : FT.tabEtape as Any]) {
            error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func updateFicheTechnique(id: String){
        var newFT : FicheTechnique
        var i = 0
        
        while(i<self.model.count){
            if(self.model[i].id == id){
                break
            }
            i = i+1
        }
        
        newFT = self.model[i]
        
        firestore.collection("Fiche Technique").document(id).setData(
            ["NomPlat" : newFT.nomFiche, "NomAuteur" : newFT.nomAuteur, "NbCouvert" : newFT.nbCouvert
             , "Etape" : newFT.tabEtape as Any], merge:true) {
                 error in
                 if let error = error {
                     print(error.localizedDescription)
                 }
             }
    }
    
    func supprimerFichTechnique(indexSet : IndexSet){
        indexSet.map{
            model[$0]
        }.forEach {
            ft in let ftId = ft.id
            let docRef = firestore.collection("Fiche Technique").document(ftId)
            docRef.delete() { error in
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        }
    }

    func searchFTByName(nomFiche : String) -> [FicheTechnique] {
        var tabFT : [FicheTechnique] = []
        for i in 0..<self.model.count {
            if(self.model[i].nomFiche.contains(nomFiche)){
                tabFT.append(self.model[i])
            }
        }
        return tabFT
    }
    
    func receive(_ input: IntentStateFicheTechnique) -> Subscribers.Demand {
        switch input {
        case .ready:
            break
        case .updatingList:
            self.objectWillChange.send()
        case .ficheTechniqueChanging(let id):
            self.updateFicheTechnique(id: id)
        case .ajoutFT(let ficheTechnique):
            self.ajoutFicheTechnique(FT: ficheTechnique)
        case .supprimerFT(let indexSet):
            self.supprimerFichTechnique(indexSet: indexSet)
        default:
            break
        }
        return .none
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
}
