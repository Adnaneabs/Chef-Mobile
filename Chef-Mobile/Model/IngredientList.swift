//
//  IngredientList.swift
//  Chef-Mobile
//
//  Created by Vincent Baret on 22/02/2022.
//

import Foundation

protocol IngredientListObserver : Decodable {
    
}


class IngredientList {
    var tabIngredient = [Ingredient]()
    var observer : IngredientListObserver?
    
    init(tabIngredient: [Ingredient]) {
        self.tabIngredient = tabIngredient
    }
}
