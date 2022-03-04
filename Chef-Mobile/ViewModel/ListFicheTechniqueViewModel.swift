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
    
    //Contient les étapes de toutes les recettes 
    @Published var tabEtape : [Etape] = []
    
    init(){
        
        //Ordre important : d'abord les étapes puis les fiches techniques
        fetchEtape()
        fetchData()
    }
    
    func fetchData(){
        
        
        firestore.collection("fiche technique")
            .addSnapshotListener{ (data, error) in
                guard let documents = data?.documents else {
                    return
                }
                
                self.model = documents.map{
                    (doc) -> FicheTechnique in
                    return FicheTechnique(id: doc.documentID,
                                          nomFiche: doc["nomFiche"] as? String ?? "",
                                          nomAuteur: doc["nomAuteur"] as? String ?? "",
                                          nbCouvert: doc["nbCouvert"] as? Int ?? 0,
                                          tabReferenceEtape: doc["tabEtape"] as? [String] ?? [],
                                          tabEtape: self.convertReferencesToEtapes(tabReference: doc["tabEtape"] as? [String] ?? [])
                    )
                }
            }
    }
    
    func fetchEtape(){
        firestore.collection("etape")
            .addSnapshotListener{ (data, error) in
                guard let documents = data?.documents else {
                    return
                }
                
                self.tabEtape = documents.map{
                    (doc) -> Etape in
                    return Etape(id: doc["id"] as? String ?? "",
                                 titre: doc["titre"] as? String ?? "",
                                 description: doc["description"] as? String ?? "",
                                 duree: doc["duree"] as? Int ?? 0,
                                 tabIngredients: doc["tabIngredients"] as? [String] ?? []
                    )
                    
                }
            }
    }
    
    func verifReference(idEtape: String) -> Int {
        //Retourne l'indice de l'étape concernée
        var indice : Int = -1
        var i = 0
        while(i < self.tabEtape.count){
            if(self.tabEtape[i].id == idEtape) {
                indice = i
            }
            i = i + 1
        }
        return indice
    }
    
    func convertReferencesToEtapes(tabReference: [String]) -> [Etape] {
        //Convertit le tableau contenant les id des étapes nécessaires à la recette en tableau d'étape
        var i = 0
        var tabEtape : [Etape] = []
        while(i<tabReference.count){
            let indice = self.verifReference(idEtape: tabReference[i])
            if( indice != -1 ){
                tabEtape.append(self.tabEtape[indice])
            }
            i = i + 1
        }
        return tabEtape
    }
    
    func ajoutFicheTechnique(FT: FicheTechnique){
        firestore.collection("fiche technique").addDocument(data: ["nomFiche" : FT.nomFiche , "nomAuteur" : FT.nomAuteur ,
                                                                   "nbCouvert" : FT.nbCouvert, "tabEtape" : FT.tabReferenceEtape]) {
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
        
        firestore.collection("Fiche technique").document(id).setData(
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
            let docRef = firestore.collection("fiche technique").document(ftId)
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
    
    func ajoutEtape(etape : Etape){
        firestore.collection("etape").addDocument(data: ["id": etape.id , "titre" : etape.titre , "description" : etape.description ,
                                                         "duree" : etape.duree , "tabIngredients" : etape.tabIngredients]) {
            error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func supprimerEtape(indexSet : IndexSet){
        indexSet.map{
            tabEtape[$0]
        }.forEach {
            etape in let etapeId = etape.id
            let docRef = firestore.collection("etape").document(etapeId)
            docRef.delete() { error in
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        }
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
        case .ajoutEtape(let tab):
            self.ajoutEtape(etape: tab)
        case .supprimmerEtape(let indexSet):
            self.supprimerEtape(indexSet: indexSet)
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
