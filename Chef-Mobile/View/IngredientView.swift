//
//  IngredientView.swift
//  Chef-Mobile
//
//  Created by Vincent Baret on 21/02/2022.
//

import Foundation
import SwiftUI

struct IngredientView: View {
    
    
    var body : some View {
        VStack{
            HStack{
                Text("Nom de l'ingrédient :")
            }
            .padding()
            
            HStack{
                Text("Catégorie de l'ingrédient :")
            }
            .padding()
            
            HStack{
                Text("Quantié de l'ingrédient :")
            }
            .padding()
            
            HStack{
                Text("Coût unitaire de l'ingrédient :")
            }
            .padding()
        }
    }
}

struct IngredientView_previews: PreviewProvider{
    static var previews: some View {
        IngredientView()
    }
}
