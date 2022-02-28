//
//  IngredientView.swift
//  Chef-Mobile
//
//  Created by Vincent Baret on 21/02/2022.
//

import Foundation
import SwiftUI

struct IngredientView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var vm : IngredientViewModel
    @ObservedObject var listVm : ListIngredientViewModel
    var intent: IntentIngredient
    
    @State var showingAlertBouttonModif : Bool = false
    @State var errorMessageModif = "L'ingrédient ne peut pas être modifié car certains champs ne sont pas remplis."
    
    @State var errorMessageChamp = ""
    @State var showingAlertChamp : Bool = false
    
    let formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter
    }()
    
    init(vm: IngredientViewModel, listVm: ListIngredientViewModel){
        self.vm = vm
        self.listVm = listVm
        self.intent = IntentIngredient()
        self.intent.addObserver(viewModel: listVm)
        self.intent.addObserver(viewModel: vm)
    }
    
    var body : some View {
        VStack{
            HStack{
                Text("Nom de l'ingrédient : ")
                TextField("Nom", text:$vm.nom)
                    .onSubmit {
                        intent.intentToChange(nomIngredient: vm.nom)
                    }
            }
            .padding()
            
            HStack{
                Text("Catégorie de l'ingrédient : ")
                TextField("Catégorie", text:$vm.categorie)
                    .onSubmit {
                        intent.intentToChange(categorieIngredient: vm.categorie)
                    }
            }
            .padding()
            
            HStack{
                Text("Quantié de l'ingrédient : ")
                TextField("Quantité", value:$vm.quantite, formatter: formatter)
                    .onSubmit {
                        intent.intentToChange(quantiteIngredient: vm.quantite)
                    }
            }
            .padding()
            
            HStack{
                Text("Coût unitaire de l'ingrédient : ")
                TextField("Coût unitaire", value:$vm.coutUnitaire, formatter: formatter)
                    .onSubmit {
                        intent.intentToChange(coutUnitIngredient: vm.coutUnitaire)
                    }
            }
            .padding()
            
            HStack{
                Button("Modifier l'ingrédient", action:{
                    if(vm.isPossibleToSendIngredient()){
                        intent.intentToChange(idIngredient: vm.id)
                        dismiss()
                    } else {
                        self.showingAlertBouttonModif = true
                    }
                })
            }
        }
        
        .onChange(of: vm.error){ error in
            switch error {
            case .noError:
                return
            case .nomError:
                self.errorMessageChamp = "\(error)"
                self.showingAlertChamp = true
            case .coutUnitaireError:
                self.errorMessageChamp = "\(error)"
                self.showingAlertChamp = true
            case .uniteError:
                self.errorMessageChamp = "\(error)"
                self.showingAlertChamp = true
            case .categorieError:
                self.errorMessageChamp = "\(error)"
                self.showingAlertChamp = true
            case .quantiteErrror:
                self.errorMessageChamp = "\(error)"
                self.showingAlertChamp = true
            }
        }
        
        //Message d'erreur pour les champs
        .alert("\(errorMessageChamp)", isPresented: $showingAlertChamp){
            Button("Ok", role: .cancel){}
        }
        
        //Message d'erreur si la modification ne peut pas être effectué
        .alert("\(errorMessageModif)", isPresented: $showingAlertBouttonModif){
            Button("Ok", role: .cancel){}
        }
    }
}

struct IngredientView_previews: PreviewProvider{
    var ingredient : Ingredient
    
    static var previews: some View {
        
        //Pour ne pas avoir de bug à la preview
        Text("")
    }
}
