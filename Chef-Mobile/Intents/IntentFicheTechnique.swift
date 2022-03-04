//
//  IntentFicheTechnique.swift
//  Chef-Mobile
//
//  Created by Adnane El Abbas on 01/03/2022.
//

import Foundation
import Combine

enum IntentStateFicheTechnique{
    case ready
    case nomFicheChanging(String)
    case nomAuteurChanging(String)
    case nbCouvertChanging(Int)
    
    case tabReferenceEtapeChanging([String])
    
    case ajoutEtape(Etape)
    
    case tabEtapeChanging(Etape)
    case ficheTechniqueChanging(String)
    case ajoutFT(FicheTechnique)
    case supprimerFT(IndexSet)
    case updatingList
}
struct IntentFicheTechnique {
    private var state = PassthroughSubject<IntentStateFicheTechnique, Never>()
    
    func addObserver(viewModel: FTViewModel){
        self.state.subscribe(viewModel)
    }
    
    func addObserver(viewModel: ListFicheTechniqueViewModel){
        self.state.subscribe(viewModel)
    }
    
    func intentToChange(nomFiche: String){
        self.state.send(.nomFicheChanging(nomFiche))
        self.state.send(.updatingList)
    }
    
    func intentToChange(nomAuteur: String){
        self.state.send(.nomAuteurChanging(nomAuteur))
        self.state.send(.updatingList)
    }
    
    func intentToChange(nbCouvert: Int){
        self.state.send(.nbCouvertChanging(nbCouvert))
        self.state.send(.updatingList)
    }
    
    func intentToChange(tabReferenceEtape: [String]){
        self.state.send(.tabReferenceEtapeChanging(tabReferenceEtape))
        self.state.send(.updatingList)
    }
    
    func intentToChange(etapeAjout: Etape){
        self.state.send(.tabEtapeChanging(etapeAjout))
        self.state.send(.updatingList)
    }
    
    func intentToChange(idFicheTechnique: String){
        self.state.send(.ficheTechniqueChanging(idFicheTechnique))
        self.state.send(.updatingList)
    }
    
    func intentToChange(ficheTechnique: FicheTechnique){
        self.state.send(.ajoutFT(ficheTechnique))
        self.state.send(.updatingList)
    }
    
    func intentToChange(indexSet: IndexSet){
        self.state.send(.supprimerFT(indexSet))
        self.state.send(.updatingList)
    }
    
    func intentToChange(etape: Etape){
        self.state.send(.ajoutEtape(etape))
        self.state.send(.updatingList)
    }
}
