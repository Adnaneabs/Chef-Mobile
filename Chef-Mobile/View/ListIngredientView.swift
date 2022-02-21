//
//  ListIngredientView.swift
//  Chef-Mobile
//
//  Created by Vincent Baret on 21/02/2022.
//

import Foundation
import SwiftUI

struct ListIngredientView: View {
    
    //Tableau d'ingrédients provisoire pour tester la vue
    var tabIng : [Ingredient] = [
        Ingredient(id: 0, nom: "Poulet", categorie: CategorieIngredient.Viande, quantite: 3, unite: Unite.Kg, coutUnitaire: 2.5),
        
        Ingredient(id: 1, nom: "Carotte", categorie: CategorieIngredient.Legumes, quantite: 1, unite: Unite.Kg, coutUnitaire: 0.5),
        
        Ingredient(id: 2, nom: "Salade", categorie: CategorieIngredient.Legumes, quantite: 500, unite: Unite.g, coutUnitaire: 1.0)
    ]
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(tabIng, id: \.id) {
                        ingredient in
                        NavigationLink(destination: IngredientView())
                        {
                            VStack(alignment: .leading){
                                Text(ingredient.nom).bold()
                                Text("\(ingredient.categorie.rawValue)")
                                Text("\(ingredient.quantite) \(ingredient.unite.rawValue) ")
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("Liste des ingrédients")
        }
    }
}

struct ListIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        ListIngredientView()
    }
}
