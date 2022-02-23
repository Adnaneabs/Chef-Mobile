//
//  ConnexionView.swift
//  Chef-Mobile
//
//  Created by Adnane El Abbas on 22/02/2022.
//

import SwiftUI
import FirebaseAuth

//The viewModel of the connexion view

class ConnexionViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String){
        return auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil , error == nil else {
                return
            }
            DispatchQueue.main.async {
                //compte connecté
                self?.signedIn = true
            }
            
        }
    }
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil , error == nil else {
                return
            }
        }
        DispatchQueue.main.async {
            //compte créé
            self.signedIn = true
        }
    }
    func signOut(){
        try? auth.signOut()
        
        self.signedIn = false
    }
}

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
                ListIngredientView(vm: ListIngredientViewModel())
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

