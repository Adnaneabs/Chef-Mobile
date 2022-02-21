//
//  FicheTechnique.swift
//  Chef-Mobile
//
//  Created by Vincent Baret on 21/02/2022.
//

import Foundation


class FicheTechnique {
    
    private var id : Int
    private var nomFiche : String
    private var nomAuteur : String
    private var nbCouvert : Int
    private var tabEtape : [Etape]
    
    init(id: Int, nomFiche: String, nomAuteur: String, nbCouvert: Int, tabEtape: [Etape]) {
        self.id = id;
        self.nomFiche = nomFiche;
        self.nomAuteur = nomAuteur;
        self.nbCouvert = nbCouvert;
        self.tabEtape = tabEtape;
    }
    
}
