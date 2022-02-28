//
//  SheetViewAjoutIngredient.swift
//  Chef-Mobile
//
//  Created by Vincent Baret on 24/02/2022.
//

import Foundation
import SwiftUI

struct SheetViewAjoutIngredient: View {
    @Environment(\.dismiss) var dismiss
    
    @State var errorMessage = "Error !"
    @State var showingAlert : Bool = false
    
    @ObservedObject var ingredientVM : IngredientViewModel = IngredientViewModel(ingredient: Ingredient(id: "", nom: "", categorie: "", quantite: 0, unite: "", coutUnitaire: 0))
    
    @ObservedObject var listIngredientVM : ListIngredientViewModel
    
    
    var intentIngredient: IntentIngredient
    
    init(vm: ListIngredientViewModel){
        self.listIngredientVM = vm
        self.intentIngredient = IntentIngredient()
        self.intentIngredient.addObserver(viewModel: listIngredientVM)
        self.intentIngredient.addObserver(viewModel: ingredientVM)
    }
    
    let formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter
    }()
    
    var body: some View {
        VStack(alignment:.leading){
            Text("Ajouter un ingrédient")
            .font(.title)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.all)
            
            HStack{
                Text("Nom : ")
                TextField("Nom de l'ingrédient", text: $ingredientVM.nom)
                    .onSubmit {
                        intentIngredient.intentToChange(nomIngredient: ingredientVM.nom)
                    }
            }
            .padding()
            
            HStack{
                Text("Catégorie : ")
                TextField("Catégorie de l'ingrédient", text: $ingredientVM.categorie)
                    .onSubmit {
                        intentIngredient.intentToChange(categorieIngredient: ingredientVM.categorie)
                    }
                }
            }
            .padding()
            
            HStack{
                Text("Quantité : ")
                TextField("Quantité de l'ingrédient", value: $ingredientVM.quantite, formatter: formatter)
                    .onSubmit {
                        intentIngredient.intentToChange(quantiteIngredient: ingredientVM.quantite)
                    }
            }
            .padding()
            
            HStack{
                Text("Unité : ")
                TextField("Unité de l'ingrédient", text: $ingredientVM.unite)
                    .onSubmit {
                        intentIngredient.intentToChange(uniteIngredient: ingredientVM.unite)
                    }
            }
            .padding()
            
            HStack{
                Text("Coût unitaire : ")
                TextField("Coût unitaire pour l'ingrédient", value: $ingredientVM.coutUnitaire , formatter: formatter)
                    .onSubmit {
                        intentIngredient.intentToChange(coutUnitIngredient: ingredientVM.coutUnitaire)
                    }
            }
            .padding()
            
            HStack{
                Button("Ajouter cette ingrédient" ,action: {
                    if(isPossibleToSend()){
                        intentIngredient.intentToChange(ingredient: Ingredient(id: UUID().uuidString, nom: ingredientVM.nom, categorie: ingredientVM.categorie, quantite: ingredientVM.quantite, unite: ingredientVM.unite, coutUnitaire: ingredientVM.coutUnitaire))
                        dismiss()
                    }
                })
                .buttonStyle(.bordered)
            }
            .padding()
        
            .alert("\(errorMessage)", isPresented: $showingAlert){
                Button("Ok", role: .cancel){}
            }
            
        }
    
    func isPossibleToSend() -> Bool {
        var possible : Bool = true
        if(ingredientVM.nom.isEmpty){
            possible = false
            self.errorMessage = "Le nom ne peut pas être vide"
            self.showingAlert = true
        } else if(ingredientVM.categorie.isEmpty){
            possible = false
            self.errorMessage = "La catégorie ne peut pas être vide"
            self.showingAlert = true
        } else if(ingredientVM.quantite == 0){
            possible = false
            self.errorMessage = "La quantité ne peut pas être 0"
            self.showingAlert = true
        } else if(ingredientVM.unite.isEmpty){
            possible = false
            self.errorMessage = "L'unité ne peut pas être vide"
            self.showingAlert = true
        } else if(ingredientVM.coutUnitaire.isZero){
            possible = false
            self.errorMessage = "Le coût unitaire ne peut pas être 0"
            self.showingAlert = true
        }
        
        return possible
    }
}
