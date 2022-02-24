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
                    .onDelete {
                        (indexSet) in
                        self.indexToSupress = indexSet
                        self.presentActionSheet.toggle()
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
                SheetViewAjoutIngredient(vm: listIngredientVM)
            }
        
            .actionSheet(isPresented: $presentActionSheet) {
                ActionSheet(title: Text("Êtes-vous-sûre de vouloir supprimer cette ingrédient ?"),
                            buttons: [
                                .destructive(Text("Supprimer"),
                                             action: { self.handleSuppresionIngredient(indexToSupress: indexToSupress) }),
                                .cancel()])
            }
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
