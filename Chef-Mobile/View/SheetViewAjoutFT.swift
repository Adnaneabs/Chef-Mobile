//
//  SheetViewAjoutFT.swift
//  Chef-Mobile
//
//  Created by Adnane El Abbas on 02/03/2022.
//

import Foundation
import SwiftUI

struct SheetViewAjoutFT : View {
    
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.defaultMinListRowHeight) var minRowHeight
    
    @State var selectedEtape = "test"
    
    @State var etape : Etape = Etape(id: "", titre: "", description: "", duree: 0, tabIngredients: [])
    @State var nomIngredient : String = ""
    
    @State var tabEtape : [Etape] = []
    
    @State var tabReferenceEtape : [String] = []
    
    @State var showingAlert : Bool = false
    @State var presentActionSheetDeleteEtape : Bool = false
    @State private var indexToSupress : IndexSet = IndexSet()
    
    @State var errorMessageEnvoi = "La Fiche Technique ne peut pas être ajouté car certains champs ne sont pas remplis."
    
    @State var showingSheetAjoutEtape = false
    
    @State var errorMessageChamp = ""
    @State var showingAlertChamp : Bool = false
    
    @ObservedObject var ficheTechniqueVM : FTViewModel = FTViewModel(ficheTechnique: FicheTechnique(id: "", nomFiche: "", nomAuteur: "", nbCouvert: 0, tabReferenceEtape: [] ,tabEtape: []))
    
    @ObservedObject var listFicheTechniqueVM : ListFicheTechniqueViewModel
    
    var intentFicheTechnique: IntentFicheTechnique
    
    init(vm: ListFicheTechniqueViewModel){
        self.listFicheTechniqueVM = vm
        self.intentFicheTechnique = IntentFicheTechnique()
        self.intentFicheTechnique.addObserver(viewModel: listFicheTechniqueVM)
        self.intentFicheTechnique.addObserver(viewModel: ficheTechniqueVM)
    }
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        ScrollView{
            VStack(alignment:.leading){
                Text("Ajouter une Fiche Technique")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.all)
                
                VStack(alignment: .leading){
                    Text("Nom du Plat : ")
                        .font(.headline)
                    TextField("Nom du plat", text: $ficheTechniqueVM.nomFiche)
                        .onSubmit {
                            intentFicheTechnique.intentToChange(nomFiche: ficheTechniqueVM.nomFiche)
                        }
                        .padding(.all)
                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                        .cornerRadius(5.0)
                }
                //.padding()
                
                VStack(alignment: .leading){
                    Text("Nom de l'auteur : ")
                        .font(.headline)
                    TextField("Auteur de la fiche", text: $ficheTechniqueVM.nomAuteur)
                        .onSubmit {
                            intentFicheTechnique.intentToChange(nomAuteur: ficheTechniqueVM.nomAuteur)
                        }
                        .padding(.all)
                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                        .cornerRadius(5.0)
                }
            }
            .padding()
            VStack(alignment: .leading){
                Text("Nombre de couverts : ")
                    .font(.headline)
                TextField("Nombre de couverts", value: $ficheTechniqueVM.nbCouvert, formatter: formatter)
                    .onSubmit {
                        intentFicheTechnique.intentToChange(nbCouvert: ficheTechniqueVM.nbCouvert)
                    }
                    .padding(.all)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                    .cornerRadius(5.0)
            }
            .padding()
            
            //        VStack{
            //            Button(action: {
            //                showingSheetAjoutEtape.toggle()
            //            }) {
            //                HStack {
            //                    Spacer()
            //                    Text("Ajouter une étape")
            //                    .font(.headline)
            //                    .foregroundColor(Color.white)
            //                    Spacer()
            //                }
            //            }
            //            .padding(.vertical, 10.0)
            //            .background(Color.red)
            //            .cornerRadius(4.0)
            //            .padding(.horizontal, 50)
            //        }
            
            
            VStack(alignment:.leading){
                Text("Ajouter une étape")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.all)
                
                VStack(alignment: .leading){
                    Text("Titre de l'étape : ")
                        .font(.headline)
                    TextField("titre", text: $etape.titre)
                        .padding(.all)
                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                        .cornerRadius(5.0)
                }
                
                VStack(alignment: .leading){
                    Text("Description de l'étape : ")
                        .font(.headline)
                    TextField("description", text: $etape.description)
                        .padding(.all)
                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                        .cornerRadius(5.0)
                }
                
                VStack(alignment: .leading){
                    Text("Durée de l'étape : ")
                        .font(.headline)
                    TextField("durée", value: $etape.duree, formatter: formatter)
                        .padding(.all)
                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                        .cornerRadius(5.0)
                }
                
                VStack(alignment: .leading){
                    Text("Ingrédients de l'étape : ")
                        .font(.headline)
                    TextField("ingrédient", text: $nomIngredient)
                        .onSubmit {
                            self.etape.tabIngredients.append(nomIngredient)
                            self.nomIngredient = ""
                        }
                        .padding(.all)
                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                        .cornerRadius(5.0)
                }
                
                VStack(alignment: .leading){
                    Text("Ingrédients :")
                        .font(.headline)
                    ScrollView{
                        List{
                            ForEach(self.etape.tabIngredients, id: \.self){
                                nom in
                                VStack(alignment: .leading){
                                    Text(nom)
                                }
                            }
                            .onDelete{
                                (indexSet) in
                                self.etape.tabIngredients.remove(atOffsets: indexSet)
                            }
                        }
                        .frame(minHeight: minRowHeight * 3).border(Color.red)
                    }
                    
                }
                
                
                HStack{
                    Button(action: {
                        self.etape.id = UUID().uuidString
                        intentFicheTechnique.intentToChange(etape: self.etape)
                        self.tabEtape.append(self.etape)
                        self.tabReferenceEtape.append(self.etape.id)
                        self.etape = Etape(id: "", titre: "", description: "", duree: 0, tabIngredients: [])
                    }) {
                        HStack {
                            Spacer()
                            Text("Ajouter cette étape")
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
                .padding()
                
            }
            
            
            VStack(alignment: .leading){
                Text("étapes à ajoutées :")
                    .font(.headline)
                ScrollView{
                    List{
                        ForEach(self.tabEtape, id: \.id){
                            etape in
                            VStack(alignment: .leading){
                                Text(etape.titre)
                            }
                        }
                        .onDelete{
                            (indexSet) in
                            self.indexToSupress = indexSet
                            self.presentActionSheetDeleteEtape.toggle()
                        }
                    }
                    .frame(minHeight: minRowHeight * 3).border(Color.red)
                }
                
            }
            .padding()
            
            
            .sheet(isPresented: $showingSheetAjoutEtape){
                SheetViewAjoutEtape(vm: listFicheTechniqueVM, FTvm: ficheTechniqueVM)
            }
            
            HStack{
                Button(action: {
                    if(ficheTechniqueVM.isPossibleToSendFT()){
                        intentFicheTechnique.intentToChange(ficheTechnique: FicheTechnique(id: UUID().uuidString, nomFiche: ficheTechniqueVM.nomFiche, nomAuteur: ficheTechniqueVM.nomAuteur, nbCouvert: ficheTechniqueVM.nbCouvert, tabReferenceEtape: self.tabReferenceEtape, tabEtape: self.tabEtape))
                        dismiss()
                    } else {
                        print(self.ficheTechniqueVM.tabEtape)
                        self.showingAlert = true
                    }
                }) {
                    HStack {
                        Spacer()
                        Text("Ajouter cette Fiche Technique")
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
            .padding()
            .onChange(of: ficheTechniqueVM.error){ error in
                switch error {
                case .noError:
                    return
                case .nomError:
                    self.errorMessageChamp = "\(error)"
                    self.showingAlertChamp = true
                case .auteurError:
                    self.errorMessageChamp = "\(error)"
                    self.showingAlertChamp = true
                case .nbCouvertError:
                    self.errorMessageChamp = "\(error)"
                    self.showingAlertChamp = true
                case .tabEtapeError:
                    self.errorMessageChamp = "\(error)"
                    self.showingAlertChamp = true
                case .categorieError:
                    self.errorMessageChamp = "\(error)"
                    self.showingAlertChamp = true
                }
            }
            //Message d'erreur pour les champs
            .alert("\(errorMessageChamp)", isPresented: $showingAlertChamp){
                Button("Ok", role: .cancel){}
            }
            
            //Message d'erreur si l'envoi ne peut pas être effectué
            .alert("\(errorMessageEnvoi)", isPresented: $showingAlert){
                Button("Ok", role: .cancel){}
            }
            
            .actionSheet(isPresented: $presentActionSheetDeleteEtape) {
                ActionSheet(title: Text("Êtes-vous-sûre de vouloir supprimer cette étape ?"),
                            buttons: [
                                .destructive(Text("Supprimer"),
                                             action: { self.handleSuppressionEtape(indexToSupress: indexToSupress)}),
                                .cancel()])
            }
        }
    }
    
    func handleSuppressionEtape(indexToSupress: IndexSet) {
        intentFicheTechnique.intentToChange(indexSetEtape: indexToSupress)
    }
}
