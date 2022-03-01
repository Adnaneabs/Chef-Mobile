//
//  MainView.swift
//  Chef-Mobile
//
//  Created by Adnane El Abbas on 01/03/2022.
//

import SwiftUI

struct MainView: View {
    var body: some View {
            TabView{
                Home()
                    .tabItem{
                        Label("Home", systemImage: "house.circle")
                    }
                ListIngredientView(vm: ListIngredientViewModel())
                    .tabItem{
                        Label("Ingredients", systemImage: "list.bullet.circle")
                    }
                SettingsView()
                    .tabItem{
                        Label("Settings", systemImage: "gear.circle")
                    }
            }
        //.navigationViewStyle(.stack)
        //.navigationBarBackButtonHidden(true)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
