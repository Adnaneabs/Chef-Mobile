//
//  Etape.swift
//  Chef-Mobile
//
//  Created by Vincent Baret on 21/02/2022.
//

import Foundation

class Etape : ObservableObject, Hashable {
    
    static func == (lhs: Etape, rhs: Etape) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id : String
    var titre : String
    var description : String
    var duree : Int
    var tabIngredients : [String]
    var tabQuantites : [Int]
    
    init(id: String, titre: String, description: String, duree: Int, tabIngredients: [String], tabQuantites : [Int]){
        self.id = id;
        self.titre = titre;
        self.description = description;
        self.duree = duree;
        self.tabIngredients = tabIngredients;
        self.tabQuantites = tabQuantites
    }
    
    func printTabIngredients() -> String {
        var affichage : String = ""
        for i in 0..<self.tabIngredients.count {
            affichage = affichage + "Ingrédient : " + self.tabIngredients[i] + " || " + " Quantité : \(self.tabQuantites[i])" + "\n"
        }
        return affichage
    }
}
