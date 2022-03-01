//
//  SettingsView.swift
//  Chef-Mobile
//
//  Created by Adnane El Abbas on 01/03/2022.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel : ConnexionViewModel
    var body: some View {
        NavigationView{
            List{
                Button(action: {
                    viewModel.signOut()
                }, label: {
                    Label("Sign Out", systemImage: "arrow.right.to.line")
                    
                })
            }.navigationTitle("Settings")
        }
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden(true)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
