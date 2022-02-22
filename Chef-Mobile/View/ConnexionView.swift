//
//  ConnexionView.swift
//  Chef-Mobile
//
//  Created by Adnane El Abbas on 22/02/2022.
//

import SwiftUI

struct ConnexionView: View {
    @State var username : String = ""
    @State var password : String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Bienvenue")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom, 20)
                Image("Logo")
                                .resizable()
                                //.aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 200)
                                .clipped()
                                .cornerRadius(150)
                                .padding(.bottom, 20)
                TextField("Username", text: $username)
                                .padding()
                                .background(Color(red: 0.961, green: 0.961, blue: 0.863))
                                .cornerRadius(5.0)
                                .padding(.bottom, 20)
                            SecureField("Password", text: $password)
                                .padding()
                                .background(Color(red: 0.961, green: 0.961, blue: 0.863))
                                .cornerRadius(5.0)
                                .padding(.bottom, 150)
            }
            .padding()
            //.navigationTitle("Connexion")
        }
        
    }
}

struct ConnexionView_Previews: PreviewProvider {
    static var previews: some View {
        ConnexionView()
    }
}
