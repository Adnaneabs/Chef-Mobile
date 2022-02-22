//
//  ContentView.swift
//  Chef-Mobile
//
//  Created by Adnane El Abbas on 14/02/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            NavigationLink(destination : ConnexionView()){
                Text("Connexion")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
