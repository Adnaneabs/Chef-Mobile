//
//  ListIngredientViewModel.swift
//  Chef-Mobile
//
//  Created by Vincent Baret on 22/02/2022.
//

import Foundation
import Combine
import FirebaseFirestoreSwift
import Firebase
import FirebaseFirestore

class ListIngredientViewModel : ObservableObject, Subscriber {
    
    @Published var model : [Ingredient] = []
    private let firestore = Firestore.firestore()
    
    init(){
        fetchData()
    }
    
    func fetchData(){

        
        firestore.collection("Ingrédients")
            .addSnapshotListener{ (data, error) in
                guard let documents = data?.documents else {
                    return
                }
                
                self.model = documents.map{
                    (doc) -> Ingredient in
                    return Ingredient(id: doc.documentID,
                                      nom: doc["nom"] as? String ?? "",
                                      categorie: doc["categorie"] as? String ?? "",
                                      quantite: doc["quantite"] as? Int ?? 0,
                                      unite: doc["unite"] as? String ?? "",
                                      coutUnitaire: doc["coutUnitaire"] as? Double ?? 0)
                    
                }
            }
    }
    
    func updateIngredient(id: String){
        var newIngredient : Ingredient
        var i = 0
        
        while(i<self.model.count){
            if(self.model[i].id == id){
                break
            }
            i = i+1
        }
        
        newIngredient = self.model[i]
        
        firestore.collection("Ingrédients").document(id).setData(
            ["nom" : newIngredient.nom, "categorie" : newIngredient.categorie, "quantite" : newIngredient.quantite
             , "coutUnitaire" : newIngredient.coutUnitaire], merge:true)
    }
    
    typealias Input = IntentStateIngredient
    
    typealias Failure = Never
    
    func receive(_ input: IntentStateIngredient) -> Subscribers.Demand {
        switch input {
        case .ready:
            break
        case .updatingList:
            self.objectWillChange.send()
        case .IngredientChanging(let id):
            self.updateIngredient(id: id)
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
