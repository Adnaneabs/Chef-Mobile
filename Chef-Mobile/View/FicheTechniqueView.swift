//
//  FicheTechniqueView.swift
//  Chef-Mobile
//
//  Created by Adnane El Abbas on 01/03/2022.
//
import Foundation
import SwiftUI

struct FicheTechniqueView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var vm : FTViewModel
    @ObservedObject var listVm : ListFicheTechniqueViewModel
    var intent: IntentFicheTechnique
    
    @State var showingAlertBouttonModif : Bool = false
    @State var errorMessageModif = "La fiche Technique ne peut pas être modifié car certains champs ne sont pas remplis."
    
    @State var errorMessageChamp = ""
    @State var showingAlertChamp : Bool = false
    
    let formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter
    }()

    init(vm: FTViewModel, listVm: ListFicheTechniqueViewModel){
        self.vm = vm
        self.listVm = listVm
        self.intent = IntentFicheTechnique()
        self.intent.addObserver(viewModel: listVm)
        self.intent.addObserver(viewModel: vm)
    }
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                Text("Nom de la fiche : ")
                    .font(.headline)
                TextField("Nom", text:$vm.nomFiche)
                    .onSubmit {
                        intent.intentToChange(nomFiche: vm.nomFiche)
                    }
                    .padding(.all)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                    .cornerRadius(5.0)
            }
            .padding()
        VStack(alignment: .leading){
            Text("Nom de l'auteur : ")
                .font(.headline)
            TextField("nomAuteur", text:$vm.nomAuteur)
                .onSubmit {
                    intent.intentToChange(nomAuteur: vm.nomAuteur)
                }
                .padding(.all)
                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                .cornerRadius(5.0)
        }
        .padding()
        VStack(alignment: .leading){
            Text("Nombre de couverts : ")
                .font(.headline)
            TextField("Quantité", value:$vm.nbCouvert, formatter: formatter)
                .onSubmit {
                    intent.intentToChange(nbCouvert: vm.nbCouvert)
                }
                .padding(.all)
                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                .cornerRadius(5.0)
        }
        .padding()
            HStack{
                Button(action:{
                    if(vm.isPossibleToSendFT()){
                        intent.intentToChange(idFicheTechnique: vm.id)
                        dismiss()
                    } else {
                        self.showingAlertBouttonModif = true
                    }
                }) {
                    HStack {
                        Spacer()
                        Text("Modifier la fiche technique")
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
        .navigationTitle("\(vm.nomFiche)")
        .onChange(of: vm.error){ error in
            switch error {
            case .noError:
                return
            case .nomError:
                self.errorMessageChamp = "\(error)"
                self.showingAlertChamp = true
            case .auteurError:
                self.errorMessageChamp = "\(error)"
                self.showingAlertChamp = true
            case .categorieError:
                self.errorMessageChamp = "\(error)"
                self.showingAlertChamp = true
            case .nbCouvertError:
                self.errorMessageChamp = "\(error)"
                self.showingAlertChamp = true
            case .tabEtapeError:
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
struct FicheTechniqueView_Previews: PreviewProvider {
    static var previews: some View {
        //FicheTechniqueView(vm: FTViewModel(ficheTechnique: FicheTechnique(id: "1", nomFiche: "Première Fiche", nomAuteur: "Adnane", nbCouvert: 9, tabEtape: [])) )
        Text("")
    }
}
