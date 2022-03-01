//
//  MainView.swift
//  Chef-Mobile
//
//  Created by Adnane El Abbas on 23/02/2022.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
                ListIngredientView(vm: ListIngredientViewModel())
                    .tabItem{
                        Label("Liste des ingrédients", systemImage: "list.dash")
                    }
            
                FichesTechniquesView()
                    .tabItem{
                        Label("Fiches Techniques", systemImage: "star")
                    }
                    
            }
        }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
