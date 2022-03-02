//
//  Home.swift
//  Chef-Mobile
//
//  Created by Adnane El Abbas on 01/03/2022.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView{
            ListFicheTechniqueView(vm : ListFicheTechniqueViewModel())
                .navigationTitle("Fiches Techniques")
                .navigationViewStyle(.stack)
        }
        .navigationViewStyle(.stack)
        .navigationBarHidden(true)
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
