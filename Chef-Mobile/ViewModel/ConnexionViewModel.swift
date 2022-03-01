//
//  ConnexionViewModel.swift
//  Chef-Mobile
//
//  Created by Adnane El Abbas on 23/02/2022.
//

import Foundation
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
