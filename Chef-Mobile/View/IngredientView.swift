//
//  IngredientView.swift
//  Chef-Mobile
//
//  Created by Vincent Baret on 21/02/2022.
//

import Foundation
import SwiftUI

struct IngredientView: View {
    
    @ObservedObject var vm : IngredientViewModel
    @ObservedObject var listVm : ListIngredientViewModel
    var intent: IntentIngredient
    
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
                    intent.intentToChange(idIngredient: vm.id)
                })
            }
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
