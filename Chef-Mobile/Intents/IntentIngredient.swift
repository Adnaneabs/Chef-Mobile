//
//  IntentIngredient.swift
//  Chef-Mobile
//
//  Created by Vincent Baret on 22/02/2022.
//

import Foundation
import Combine

enum IntentStateIngredient{
    case ready
    case nomChanging(String)
    case categorieChanging(String)
    case quantiteChanging(Int)
    case uniteChanging(String)
    case coutUnitaireChanging(Double)
    case IngredientChanging(String)
    case ajoutIngredient(Ingredient)
    case supprimerIngredient(IndexSet)
    case updatingList
}

struct IntentIngredient {
    private var state = PassthroughSubject<IntentStateIngredient, Never>()
    
    func addObserver(viewModel: ListIngredientViewModel){
        self.state.subscribe(viewModel)
    }
    
    func addObserver(viewModel: IngredientViewModel){
        self.state.subscribe(viewModel)
    }
    
    func intentToChange(nomIngredient: String){
        self.state.send(.nomChanging(nomIngredient))
        self.state.send(.updatingList)
    }
    
    func intentToChange(categorieIngredient: String){
        self.state.send(.categorieChanging(categorieIngredient))
        self.state.send(.updatingList)
    }
    
    func intentToChange(quantiteIngredient: Int){
        self.state.send(.quantiteChanging(quantiteIngredient))
        self.state.send(.updatingList)
    }
    
    func intentToChange(uniteIngredient: String){
        self.state.send(.uniteChanging(uniteIngredient))
        self.state.send(.updatingList)
    }
    
    func intentToChange(coutUnitIngredient: Double){
        self.state.send(.coutUnitaireChanging(coutUnitIngredient))
        self.state.send(.updatingList)
    }
    
    func intentToChange(idIngredient: String){
        self.state.send(.IngredientChanging(idIngredient))
        self.state.send(.updatingList)
    }
    
    func intentToChange(ingredient: Ingredient){
        self.state.send(.ajoutIngredient(ingredient))
        self.state.send(.updatingList)
    }
    
    func intentToChange(indexSet: IndexSet){
        self.state.send(.supprimerIngredient(indexSet))
        self.state.send(.updatingList)
    }
    
}
