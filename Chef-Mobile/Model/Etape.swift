//
//  Etape.swift
//  Chef-Mobile
//
//  Created by Vincent Baret on 21/02/2022.
//

import Foundation

class Etape {
    
    private var id : Int
    var titre : String
    private var description : String
    private var duree : Int
    private var tabIngredients : [Ingredient]
    
    init(id: Int, titre: String, description: String, duree: Int, tabIngredients: [Ingredient]){
        self.id = id;
        self.titre = titre;
        self.description = description;
        self.duree = duree;
        self.tabIngredients = tabIngredients;
    }
}
