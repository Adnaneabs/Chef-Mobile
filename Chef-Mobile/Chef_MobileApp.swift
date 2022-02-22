//
//  Chef_MobileApp.swift
//  
//
//  Created by Adnane El Abbas on 14/02/2022.
//

import SwiftUI

import Firebase

@main
struct Chef_MobileApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
//            ListIngredientView(vm: ListIngredientViewModel())
            ConnexionView()
        }
    }
}
