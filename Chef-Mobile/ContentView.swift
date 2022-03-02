//
//  ContentView.swift
//  Chef-Mobile
//
//  Created by Adnane El Abbas on 14/02/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel : ConnexionViewModel
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                NavigationLink(destination : ConnexionView()){
                    Text("Connexion")
                }
                .padding()
                .buttonStyle(.bordered)
                NavigationLink(destination : ContentView()){
                    Text("Fiches Techniques")
                }
                .padding()
                .buttonStyle(.bordered)
            }
            .padding(.bottom,100)
            .navigationViewStyle(.stack)
            
        }
        //        .padding()
        .onAppear(perform: {
            viewModel.signedIn = viewModel.isSignedIn
        })
        .navigationViewStyle(.stack)
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

