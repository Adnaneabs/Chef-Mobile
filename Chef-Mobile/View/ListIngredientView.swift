//
//  ListIngredientView.swift
//  Chef-Mobile
//
//  Created by Vincent Baret on 21/02/2022.
//

import Foundation
import SwiftUI

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var listIngredientVM : ListIngredientViewModel
    @State var ingredient : Ingredient = Ingredient(id: "", nom: "", categorie: "", quantite: 0, unite: "", coutUnitaire: 0)
    
    
    var intentIngredient: IntentIngredient
    
    init(vm: ListIngredientViewModel){
        self.listIngredientVM = vm
        self.intentIngredient = IntentIngredient()
        self.intentIngredient.addObserver(viewModel: listIngredientVM)
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
                TextField("Nom de l'ingrédient", text: $ingredient.nom)
            }
            .padding()
            
            HStack{
                Text("Catégorie : ")
                TextField("Catégorie de l'ingrédient", text: $ingredient.categorie)
                }
            }
            .padding()
            
            HStack{
                Text("Quantité : ")
                TextField("Quantité de l'ingrédient", value: $ingredient.quantite, formatter: formatter)
            }
            .padding()
            
            HStack{
                Text("Unité : ")
                TextField("Unité de l'ingrédient", text: $ingredient.unite)
            }
            .padding()
            
            HStack{
                Text("Coût unitaire : ")
                TextField("Coût unitaire pour l'ingrédient", value: $ingredient.coutUnitaire , formatter: formatter)
            }
            .padding()
            
            HStack{
                Button("Ajouter cette ingrédient" ,action: {
                    intentIngredient.intentToChange(ingredient: Ingredient(id: UUID().uuidString, nom: ingredient.nom, categorie: ingredient.categorie, quantite: ingredient.quantite, unite: ingredient.unite, coutUnitaire: ingredient.coutUnitaire))
                        dismiss()
                })
                .buttonStyle(.bordered)
            }
            .padding()
            
        }
    
}

struct ListIngredientView: View {
    
    @State private var showingSheet = false
    
    @ObservedObject var listIngredientVM : ListIngredientViewModel
    
    var intentIngredient: IntentIngredient
    
    init(vm: ListIngredientViewModel){
        self.listIngredientVM = vm
        self.intentIngredient = IntentIngredient()
        self.intentIngredient.addObserver(viewModel: vm)
    }
    
    var body: some View {
            VStack{
                List{
                    ForEach(listIngredientVM.model, id: \.id) {
                        ingredient in
                        NavigationLink(destination: IngredientView(vm: IngredientViewModel(ingredient: ingredient), listVm: listIngredientVM))
                        {
                            VStack(alignment: .leading){
                                Text(ingredient.nom).bold()
                                Text("\(ingredient.categorie)")
                                Text("\(ingredient.quantite) \(ingredient.unite) ")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Ingrédients")
            .background(.red)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing:
                                    Button(action: {showingSheet.toggle()}){
                Label("Ajouter", systemImage: "plus")
            })
            .sheet(isPresented: $showingSheet) {
                SheetView(vm: listIngredientVM)
            }
    }
}

struct ListIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        
        ListIngredientView(vm: ListIngredientViewModel())
        
    }
}
