//
//  FicheTechniqueViewModel.swift
//  Chef-Mobile
//
//  Created by Adnane El Abbas on 01/03/2022.
//

import Foundation

import Combine

enum FTViewModelError : Error, CustomStringConvertible, Equatable {
    case noError
    case nomError
    case categorieError
    case nbCouvertError
    case tabEtapeError
    case auteurError
    var description: String {
        switch self {
        case .nomError : return "Le champ nom ne peut pas être vide"
        case .categorieError : return "Le champ catégorie ne peut pas être vide"
        case .nbCouvertError : return "Le nb de couverts ne peut pas être égale à 0"
        case .auteurError : return "Le champ auteur ne peut pas être vide"
        case .tabEtapeError : return "erreur dans le tableau des étapes"
        case .noError : return "Aucune erreur"
        }
    }
}
class FTViewModel : ObservableObject, FicheTechniqueObserver , Subscriber {
    
    var FTModel: FicheTechnique
    var id : String
    
    @Published var nomFiche : String
    @Published var nomAuteur : String
    @Published var nbCouvert : Int
    @Published var tabEtape : [Etape]
    
    @Published var error : FTViewModelError = .noError
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(_ input: IntentStateFicheTechnique) -> Subscribers.Demand {
        switch input{
        case .ready:
            break
        case .updatingList:
            break
        case .nomFicheChanging(let nomFiche):
            if(self.nomFiche.isEmpty){
                self.error = .nomError
            } else {
                self.FTModel.nomFiche = nomFiche
            }
        case .nomAuteurChanging(let nomAuteur):
            if(self.nomAuteur.isEmpty){
                self.error = .auteurError
            } else {
                self.FTModel.nomAuteur = nomAuteur
            }
        case .nbCouvertChanging(let nbCouvert):
            if(self.nbCouvert == 0){
                self.error = .nbCouvertError
            } else {
                self.FTModel.nbCouvert = nbCouvert
            }
        case .tabEtapeChanging(let tabEtape):
            if(self.tabEtape.isEmpty){
                self.error = .tabEtapeError
            } else {
                self.FTModel.tabEtape = tabEtape
            }
        default:
            break
        }
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    typealias Failure = Never
    typealias Input = IntentStateFicheTechnique
    
    func changed(nomFiche: String) {
        self.nomFiche = nomFiche
    }
        
    func changed(nomAuteur: String) {
        self.nomAuteur = nomAuteur
    }
    
    func changed(nbCouvert: Int) {
        self.nbCouvert = nbCouvert
    }
    
    func changed(tabEtape: [Etape]) {
        self.tabEtape = tabEtape
    }
    
    func isPossibleToSendFT() -> Bool {
        var possible : Bool = true
        if(self.nomFiche.isEmpty){
            possible = false
        } else if(self.nomAuteur.isEmpty){
            possible = false
        } else if(self.nbCouvert == 0){
            possible = false
        }
        return possible
    }
    
    init(ficheTechnique: FicheTechnique){
        self.id = ficheTechnique.id
        self.FTModel = ficheTechnique
        self.nomFiche = ficheTechnique.nomFiche
        self.nbCouvert = ficheTechnique.nbCouvert
        self.tabEtape = ficheTechnique.tabEtape ?? []
        self.nomAuteur = ficheTechnique.nomAuteur
        self.FTModel.observer = self
    }
}

