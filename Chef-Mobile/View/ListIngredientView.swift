//
//  ListIngredientView.swift
//  Chef-Mobile
//
//  Created by Vincent Baret on 21/02/2022.
//

import Foundation
import SwiftUI

struct ListIngredientView: View {
    
    @State private var showingSheet = false
    
    @State private var presentActionSheet = false
    
    @State private var indexToSupress : IndexSet = IndexSet()
    
    //Pour la searchBar
    @State private var searchString = ""
    
    public var searchIngredient : [Ingredient] {
        if searchString.isEmpty {
            return listIngredientVM.model
        } else {
            return listIngredientVM.searchIngredientByName(nom: searchString)
        }
    }
    
    @ObservedObject var listIngredientVM : ListIngredientViewModel
    
    var intentIngredient: IntentIngredient
    
    init(vm: ListIngredientViewModel){
        self.listIngredientVM = vm
        self.intentIngredient = IntentIngredient()
        self.intentIngredient.addObserver(viewModel: vm)
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(searchIngredient, id: \.id) {
                    ingredient in
                    NavigationLink(destination: IngredientView(vm: IngredientViewModel(ingredient: ingredient), listVm: listIngredientVM))
                    {
                            HStack{
                            ZStack{
                                Circle()
                                    .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.red, .pink]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                        )
                                    )
                                VStack {
                                    Text("\(ingredient.quantite)")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                                                        
                                    Text("\(ingredient.unite)")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                    }
                            }
                            .frame(width: 70, height: 70, alignment: .center)
                            
                            
                            VStack(alignment: .leading){
                                Text(ingredient.nom)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .lineLimit(2)
                                    .padding(.bottom, 5)
                                
                                Text("\(ingredient.categorie)")
                                    .padding(5)
                                    .font(.system(size: 12.0, weight: .regular))
                                    .lineLimit(2)
                                    .foregroundColor(.white)
                                    .background(Color.green)
                                    .cornerRadius(5)
                            }
                        
                            .padding(.horizontal, 5)
                            }
                            .padding(15)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
               
                    }
                .onDelete {
                    (indexSet) in
                    self.indexToSupress = indexSet
                    self.presentActionSheet.toggle()
                }
                
            }
            
        .searchable(text: $searchString)
        .navigationTitle("Ingrédients")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing:
                                Button(action: {showingSheet.toggle()}){
            Label("Ajouter", systemImage: "plus")
        })
        .sheet(isPresented: $showingSheet) {
            SheetViewAjoutIngredient(vm: listIngredientVM)
        }
    
        .actionSheet(isPresented: $presentActionSheet) {
            ActionSheet(title: Text("Êtes-vous-sûre de vouloir supprimer cette ingrédient ?"),
                        buttons: [
                            .destructive(Text("Supprimer"),
                                         action: { self.handleSuppresionIngredient(indexToSupress: indexToSupress)}),
                            .cancel()])
        }
        }
        .navigationViewStyle(.stack)
        .navigationBarHidden(true)
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        
    }
    
    func handleSuppresionIngredient(indexToSupress: IndexSet) {
        intentIngredient.intentToChange(indexSet: indexToSupress)
    }
}


struct ListIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        
        ListIngredientView(vm: ListIngredientViewModel())
        
    }
}
