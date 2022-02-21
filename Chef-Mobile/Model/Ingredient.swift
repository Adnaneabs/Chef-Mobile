//
//  Ingredient.swift
//  Chef-Mobile
//
//  Created by Vincent Baret on 21/02/2022.
//

import Foundation


class Ingredient {
    
    private var id : Int
    private var nom : String
    private var categorie : CategorieIngredient
    private var quantite : Int
    private var unite : Unite
    private var coutUnitaire : Double
    
    init(id : Int, nom : String, categorie : CategorieIngredient, quantite : Int, unite : Unite, coutUnitaire : Double){
        self.id = id;
        self.nom = nom;
        self.categorie = categorie;
        self.quantite = quantite;
        self.unite = unite;
        self.coutUnitaire = coutUnitaire;
    }
}
