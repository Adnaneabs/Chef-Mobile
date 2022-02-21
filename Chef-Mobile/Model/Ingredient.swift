//
//  Ingredient.swift
//  Chef-Mobile
//
//  Created by Vincent Baret on 21/02/2022.
//

import Foundation


class Ingredient {
    
    var id : Int
    var nom : String
    var categorie : CategorieIngredient
    var quantite : Int
    var unite : Unite
    var coutUnitaire : Double
    
    init(id : Int, nom : String, categorie : CategorieIngredient, quantite : Int, unite : Unite, coutUnitaire : Double){
        self.id = id;
        self.nom = nom;
        self.categorie = categorie;
        self.quantite = quantite;
        self.unite = unite;
        self.coutUnitaire = coutUnitaire;
    }
}
