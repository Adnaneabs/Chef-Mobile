//
//  Etape.swift
//  Chef-Mobile
//
//  Created by Vincent Baret on 21/02/2022.
//

import Foundation

class Etape {
    
    var id : String
    var titre : String
    var description : String
    var duree : Int
    var tabIngredients : [String]
    
    init(id: String, titre: String, description: String, duree: Int, tabIngredients: [String]){
        self.id = id;
        self.titre = titre;
        self.description = description;
        self.duree = duree;
        self.tabIngredients = tabIngredients;
    }
    
    func printTabIngredients() -> String {
        var affichage : String = ""
        for i in 0..<self.tabIngredients.count {
            affichage = affichage + " " + self.tabIngredients[i]
        }
        return affichage
    }
}
