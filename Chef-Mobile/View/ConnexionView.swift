//
//  ConnexionView.swift
//  Chef-Mobile
//
//  Created by Adnane El Abbas on 22/02/2022.
//

import SwiftUI
import FirebaseAuth



//End of the viewModel of the connexion view

struct ConnexionView: View {
    @State var email : String = ""
    @State var password : String = ""
    
    @EnvironmentObject var viewModel : ConnexionViewModel
    
    var body: some View {
            if viewModel.isSignedIn{
                /*VStack{
                    Text("you are signed in")
                        .foregroundColor(.green)
                    Button(action: {
                        viewModel.signOut()
                    }, label: {
                        Text("Sign Out")
                            .foregroundColor(.blue)
                    })
                        .padding()
                        .buttonStyle(.bordered)
                }*/
                /*ListIngredientView(vm: ListIngredientViewModel())*/
                MainView()
            }
            else {
                EmailPasswordView()
            }
    }
}

struct EmailPasswordView: View {
    @State var email : String = ""
    @State var password : String = ""
    
    @EnvironmentObject var viewModel : ConnexionViewModel
    
    var body: some View {
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
                TextField("email", text: $email)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color(red: 0.961, green: 0.961, blue: 0.863))
                    .cornerRadius(5.0)
                    .padding()
                SecureField("Password", text: $password)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color(red: 0.961, green: 0.961, blue: 0.863))
                    .cornerRadius(5.0)
                    .padding()
                Spacer(minLength: 60)
                Button(action: {
                    guard !email.isEmpty,!password.isEmpty else {
                        return
                    }
                    
                    viewModel.signIn(email: email, password: password)
                }, label: {
                    Text("Connexion")
                        .padding()
                })
                    .frame(width: 150, height: 20)
                    .foregroundColor(.white)
                    .padding()
                    .background(.blue)
                    .cornerRadius(10)
                    .padding(.bottom, 150)
                
            }
            .padding()
            //.navigationTitle("Connexion")
        
    }
}

struct ConnexionView_Previews: PreviewProvider {
    static var previews: some View {
        ConnexionView()
    }
}

