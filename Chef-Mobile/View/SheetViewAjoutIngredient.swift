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
    
    @State var showingAlert : Bool = false
    
    @State var errorMessageEnvoi = "L'ingrédient ne peut pas être ajouté car certains champs ne sont pas remplis."
    
    @State var errorMessageChamp = ""
    @State var showingAlertChamp : Bool = false
    
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
            
            VStack(alignment: .leading){
                Text("Nom : ")
                    .font(.headline)
                TextField("Nom de l'ingrédient", text: $ingredientVM.nom)
                    .onSubmit {
                        intentIngredient.intentToChange(nomIngredient: ingredientVM.nom)
                    }
                    .padding(.all)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                    .cornerRadius(5.0)
            }
            .padding()
            
            VStack(alignment: .leading){
                Text("Catégorie : ")
                    .font(.headline)
                TextField("Catégorie de l'ingrédient", text: $ingredientVM.categorie)
                    .onSubmit {
                        intentIngredient.intentToChange(categorieIngredient: ingredientVM.categorie)
                    }
                    .padding(.all)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                    .cornerRadius(5.0)
                }
            }
            .padding()
            
        VStack(alignment: .leading){
                Text("Quantité : ")
                .font(.headline)
                TextField("Quantité de l'ingrédient", value: $ingredientVM.quantite, formatter: formatter)
                    .onSubmit {
                        intentIngredient.intentToChange(quantiteIngredient: ingredientVM.quantite)
                    }
                    .padding(.all)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                    .cornerRadius(5.0)
            }
            .padding()
            
        VStack(alignment: .leading){
                Text("Unité : ")
                .font(.headline)
                TextField("Unité de l'ingrédient", text: $ingredientVM.unite)
                    .onSubmit {
                        intentIngredient.intentToChange(uniteIngredient: ingredientVM.unite)
                    }
                    .padding(.all)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                    .cornerRadius(5.0)
            }
            .padding()
            
        VStack(alignment: .leading){
                Text("Coût unitaire : ")
                .font(.headline)
                TextField("Coût unitaire pour l'ingrédient", value: $ingredientVM.coutUnitaire , formatter: formatter)
                    .onSubmit {
                        intentIngredient.intentToChange(coutUnitIngredient: ingredientVM.coutUnitaire)
                    }
                    .padding(.all)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                    .cornerRadius(5.0)
            }
            .padding()
            
            HStack{
                Button(action: {
                    if(ingredientVM.isPossibleToSendIngredient()){
                        intentIngredient.intentToChange(ingredient: Ingredient(id: UUID().uuidString, nom: ingredientVM.nom, categorie: ingredientVM.categorie, quantite: ingredientVM.quantite, unite: ingredientVM.unite, coutUnitaire: ingredientVM.coutUnitaire))
                        dismiss()
                    } else {
                        self.showingAlert = true
                    }
                }) {
                    HStack {
                        Spacer()
                        Text("Ajouter cette ingrédient")
                        .font(.headline)
                        .foregroundColor(Color.white)
                        Spacer()
                    }
                }
                .padding(.vertical, 10.0)
                .background(Color.red)
                .cornerRadius(4.0)
                .padding(.horizontal, 50)
            }
            .padding()
        
            .onChange(of: ingredientVM.error){ error in
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
            
            //Message d'erreur si l'envoi ne peut pas être effectué
            .alert("\(errorMessageEnvoi)", isPresented: $showingAlert){
                Button("Ok", role: .cancel){}
            }
            
        }
}
