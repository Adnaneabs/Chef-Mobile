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
    case nomError
    case categorieError
    case quantiteErrror
    case uniteError
    case coutUnitaireError
    
    var description: String {
        switch self {
        case .nomError : return "Le champ nom ne peut pas être vide"
        case .categorieError : return "Le champ catégorie ne peut pas être vide"
        case .quantiteErrror : return "La quantité ne peut pas être égale à 0"
        case .uniteError : return "Le champ unité ne peut pas être vide"
        case .coutUnitaireError : return "Le coût unitaire ne peut pas être égale à 0"
        case .noError : return "Aucune erreur"
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
    
    @Published var error : IngredientViewModelError = .noError
    
    
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
            if(self.nom.isEmpty){
                self.error = .nomError
            } else {
                self.ingredientModel.nom = nom
            }
        case .categorieChanging(let categorie):
            if(self.categorie.isEmpty){
                self.error = .categorieError
            } else {
                self.ingredientModel.categorie = categorie
            }
        case .quantiteChanging(let quantite):
            if(self.quantite == 0){
                self.error = .quantiteErrror
            } else {
                self.ingredientModel.quantite = quantite
            }
        case .uniteChanging(let unite):
            if(self.unite.isEmpty){
                self.error = .uniteError
            } else {
                self.ingredientModel.unite = unite
            }
        case .coutUnitaireChanging(let coutUnit):
            if(self.coutUnitaire == 0){
                self.error = .coutUnitaireError
            } else {
                self.ingredientModel.coutUnitaire = coutUnit
            }
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
    
    func isPossibleToSendIngredient() -> Bool {
        var possible : Bool = true
        if(self.nom.isEmpty){
            possible = false
        } else if(self.categorie.isEmpty){
            possible = false
        } else if(self.quantite == 0){
            possible = false
        } else if(self.unite.isEmpty){
            possible = false
        } else if(self.coutUnitaire.isZero){
            possible = false
        }
        return possible
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
