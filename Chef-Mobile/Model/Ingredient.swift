//
//  Ingredient.swift
//  Chef-Mobile
//
//  Created by Vincent Baret on 21/02/2022.
//

import Foundation

protocol IngredientObserver {
    func changed(nom: String)
    func changed(categorie: String)
    func changed(quantite: Int)
    func changed(unite: String)
    func changed(coutUnitaire: Double)
}


class Ingredient{
    
    var id : String
    var nom : String {
        didSet {
            self.observer?.changed(nom: self.nom)
        }
    }
    var categorie : String {
        didSet {
            self.observer?.changed(categorie: self.categorie)
        }
    }
    var quantite : Int {
        didSet {
            self.observer?.changed(quantite: self.quantite)
        }
    }
    var unite : String {
        didSet {
            self.observer?.changed(unite: self.unite)
        }
    }
    var coutUnitaire : Double {
        didSet {
            self.observer?.changed(coutUnitaire: self.coutUnitaire)
        }
    }
    
    var observer : IngredientObserver?
    
    init(id : String, nom : String, categorie : String, quantite : Int, unite : String, coutUnitaire : Double){
        self.id = id;
        self.nom = nom;
        self.categorie = categorie;
        self.quantite = quantite;
        self.unite = unite;
        self.coutUnitaire = coutUnitaire;
    }
}
