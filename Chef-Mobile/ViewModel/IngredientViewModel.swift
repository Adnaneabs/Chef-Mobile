//
//  IngredientViewModel.swift
//  Chef-Mobile
//
//  Created by Vincent Baret on 22/02/2022.
//

import Foundation
import Combine

enum IngredientViewModelError : Error, CustomStringConvertible, Equatable {
    case noError
    case nameError(String)
    
    var description: String {
        switch self {
        case .nameError(_) : return "Le champ nom ne peut pas être vide"
        case .noError : return "No error"
        }
    }
}

class IngredientViewModel : ObservableObject, IngredientObserver, Subscriber {
    
    var ingredientModel: Ingredient
    
    var id : String
    @Published var nom : String
    @Published var categorie : String
    @Published var quantite : Int
    @Published var unite : String
    @Published var coutUnitaire : Double
    
    
    typealias Input = IntentStateIngredient
    
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(_ input: IntentStateIngredient) -> Subscribers.Demand {
        switch input{
        case .ready:
            break
        case .updatingList:
            break
        case .nomChanging(let nom):
            self.ingredientModel.nom = nom
        case .categorieChanging(let categorie):
            self.ingredientModel.categorie = categorie
        case .quantiteChanging(let quantite):
            self.ingredientModel.quantite = quantite
        case .uniteChanging(let unite):
            self.ingredientModel.unite = unite
        case .coutUnitaireChanging(let coutUnit):
            self.ingredientModel.coutUnitaire = coutUnit
        default:
            break
        }
        
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func changed(nom: String) {
        self.nom = nom
    }
    
    func changed(categorie: String) {
        self.categorie = categorie
    }
    
    func changed(quantite: Int) {
        self.quantite = quantite
    }
    
    func changed(unite: String) {
        self.unite = unite
    }
    
    func changed(coutUnitaire: Double) {
        self.coutUnitaire = coutUnitaire
    }
    
    
    init(ingredient: Ingredient){
        self.id = ingredient.id
        self.ingredientModel = ingredient
        self.nom = ingredient.nom
        self.categorie = ingredient.categorie
        self.quantite = ingredient.quantite
        self.unite = ingredient.unite
        self.coutUnitaire = ingredient.coutUnitaire
        self.ingredientModel.observer = self
    }
}
