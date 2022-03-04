//
//  FicheTechnique.swift
//  Chef-Mobile
//
//  Created by Vincent Baret on 21/02/2022.
//

import Foundation

protocol FicheTechniqueObserver {
    func changed(nomFiche: String)
    //func changed(id: Int)
    func changed(nomAuteur: String)
    func changed(nbCouvert: Int)
    func changed(tabReferenceEtape: [String])
    func changed(tabEtape : [Etape])
}

class FicheTechnique {
    
    var id : String
    var nomFiche : String{
        didSet {
            self.observer?.changed(nomFiche: self.nomFiche)
        }
    }
    var nomAuteur : String{
        didSet {
            self.observer?.changed(nomAuteur: self.nomAuteur)
        }
    }
    var nbCouvert : Int{
        didSet {
            self.observer?.changed(nbCouvert: self.nbCouvert)
        }
    }
    var tabReferenceEtape : [String]
    
    var tabEtape : [Etape]
    
    var observer : FicheTechniqueObserver?
    
    init(id: String, nomFiche: String, nomAuteur: String, nbCouvert: Int, tabReferenceEtape: [String] ,tabEtape: [Etape]) {
        self.id = id;
        self.nomFiche = nomFiche;
        self.nomAuteur = nomAuteur;
        self.nbCouvert = nbCouvert;
        self.tabReferenceEtape = tabReferenceEtape;
        self.tabEtape = tabEtape ;
    }
    
}
