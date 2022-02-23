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
    
    //Les states var sont provisoires pour tester la vue
    @State var nomIng: String = ""
    @State var catIng: CategorieIngredient = CategorieIngredient.Viande
    @State var quantiteIng: Int = 0
    @State var uniteIng: Unite = Unite.Kg
    @State var coutUnitIng: Double = 0.0
    
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
                TextField("Nom de l'ingrédient", text: $nomIng)
            }
            .padding()
            
            HStack{
                Text("Catégorie : ")
                Picker(selection: $catIng, label: Text("Catégorie de l'ingrédient")){
                    Text("Viande").tag(CategorieIngredient.Viande)
                    Text("Légumes").tag(CategorieIngredient.Legumes)
                }
            }
            .padding()
            
            HStack{
                Text("Quantité : ")
                TextField("Quantité de l'ingrédient", value: $quantiteIng, formatter: formatter)
            }
            .padding()
            
            HStack{
                Text("Unité : ")
                Picker(selection: $uniteIng, label: Text("Unité pour cette ingrédient")){
                    Text("g").tag(Unite.g)
                    Text("L").tag(Unite.L)
                    Text("Kg").tag(Unite.Kg)
                    Text("mL").tag(Unite.mL)
                }
            }
            .padding()
            
            HStack{
                Text("Coût unitaire : ")
                TextField("Coût unitaire pour l'ingrédient", value: $coutUnitIng, formatter: formatter)
            }
            .padding()
            
            HStack{
                Button("Ajouter cette ingrédient" ,action: {})
                .buttonStyle(.bordered)
            }
            .padding()
            
        }
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
                SheetView()
            }
    }
}

struct ListIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        
        ListIngredientView(vm: ListIngredientViewModel())
        
    }
}
