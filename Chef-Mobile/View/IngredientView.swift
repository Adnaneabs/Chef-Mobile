//
//  IngredientView.swift
//  Chef-Mobile
//
//  Created by Vincent Baret on 21/02/2022.
//

import Foundation
import SwiftUI

struct IngredientView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var vm : IngredientViewModel
    @ObservedObject var listVm : ListIngredientViewModel
    var intent: IntentIngredient
    
    @State var showingAlertBouttonModif : Bool = false
    @State var errorMessageModif = "L'ingrédient ne peut pas être modifié car certains champs ne sont pas remplis."
    
    @State var errorMessageChamp = ""
    @State var showingAlertChamp : Bool = false
    
    let formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter
    }()
    
    init(vm: IngredientViewModel, listVm: ListIngredientViewModel){
        self.vm = vm
        self.listVm = listVm
        self.intent = IntentIngredient()
        self.intent.addObserver(viewModel: listVm)
        self.intent.addObserver(viewModel: vm)
    }
    
    var body : some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                Text("Nom de l'ingrédient : ")
                    .font(.headline)
                TextField("Nom", text:$vm.nom)
                    .onSubmit {
                        intent.intentToChange(nomIngredient: vm.nom)
                    }
                    .padding(.all)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                    .cornerRadius(5.0)
            }
            .padding()
            
            VStack(alignment: .leading){
                Text("Catégorie de l'ingrédient : ")
                    .font(.headline)
                TextField("Catégorie", text:$vm.categorie)
                    .onSubmit {
                        intent.intentToChange(categorieIngredient: vm.categorie)
                    }
                    .padding(.all)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                    .cornerRadius(5.0)
            }
            .padding()
            
            VStack(alignment: .leading){
                Text("Quantié de l'ingrédient : ")
                    .font(.headline)
                TextField("Quantité", value:$vm.quantite, formatter: formatter)
                    .onSubmit {
                        intent.intentToChange(quantiteIngredient: vm.quantite)
                    }
                    .padding(.all)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                    .cornerRadius(5.0)
            }
            .padding()
            
            VStack(alignment: .leading){
                Text("Coût unitaire de l'ingrédient : ")
                    .font(.headline)
                TextField("Coût unitaire", value:$vm.coutUnitaire, formatter: formatter)
                    .onSubmit {
                        intent.intentToChange(coutUnitIngredient: vm.coutUnitaire)
                    }
                    .padding(.all)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                    .cornerRadius(5.0)
            }
            .padding()
            
            HStack{
                Button(action:{
                    if(vm.isPossibleToSendIngredient()){
                        intent.intentToChange(idIngredient: vm.id)
                        dismiss()
                    } else {
                        self.showingAlertBouttonModif = true
                    }
                }) {
                    HStack {
                        Spacer()
                        Text("Modifier l'ingrédient")
                        .font(.headline)
                        .foregroundColor(Color.white)
                        Spacer()
                    }
                }
                .padding(.vertical, 10.0)
                .background(Color.red)
                .cornerRadius(4.0)
                .padding(.horizontal, 50)
            }
        }
        
        .onChange(of: vm.error){ error in
            switch error {
            case .noError:
                return
            case .nomError:
                self.errorMessageChamp = "\(error)"
                self.showingAlertChamp = true
            case .coutUnitaireError:
                self.errorMessageChamp = "\(error)"
                self.showingAlertChamp = true
            case .uniteError:
                self.errorMessageChamp = "\(error)"
                self.showingAlertChamp = true
            case .categorieError:
                self.errorMessageChamp = "\(error)"
                self.showingAlertChamp = true
            case .quantiteErrror:
                self.errorMessageChamp = "\(error)"
                self.showingAlertChamp = true
            }
        }
        
        //Message d'erreur pour les champs
        .alert("\(errorMessageChamp)", isPresented: $showingAlertChamp){
            Button("Ok", role: .cancel){}
        }
        
        //Message d'erreur si la modification ne peut pas être effectué
        .alert("\(errorMessageModif)", isPresented: $showingAlertBouttonModif){
            Button("Ok", role: .cancel){}
        }
    }
}

struct IngredientView_previews: PreviewProvider{
    var ingredient : Ingredient
    
    static var previews: some View {
        
        //Pour ne pas avoir de bug à la preview
        Text("")
    }
}
