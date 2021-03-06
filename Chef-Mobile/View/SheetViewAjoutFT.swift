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
    
    @State var etape : Etape = Etape(id: "", titre: "", description: "", duree: 0, tabIngredients: [], tabQuantites: [])
    
    @State var nomIngredient : String = ""
    @State var quantiteIng : Int = 0
    @State var tabEtape : [Etape] = []
    
    @State var tabReferenceEtape : [String] = []
    
    @State var showingAlert : Bool = false
    @State var presentActionSheetDeleteEtape : Bool = false
    @State private var indexToSupress : IndexSet = IndexSet()
    
    @State var errorMessageEnvoi = "La Fiche Technique ne peut pas être ajouté car certains champs ne sont pas remplis."
    
    @State var errorMessageChamp = ""
    @State var showingAlertChamp : Bool = false
    
    @State var sheetEtapeExistante : Bool = false
    
    @ObservedObject var ficheTechniqueVM : FTViewModel = FTViewModel(ficheTechnique: FicheTechnique(id: "", nomFiche: "", nomAuteur: "", nbCouvert: 0, tabReferenceEtape: [] ,tabEtape: []))
    
    @ObservedObject var listFicheTechniqueVM : ListFicheTechniqueViewModel
    //Pour les ingrédients
    @ObservedObject var listIngredientVM : ListIngredientViewModel
    
    var intentIngredient: IntentIngredient
    ///
    
    var intentFicheTechnique: IntentFicheTechnique
    
    var steps : [Etape] = []
    @StateObject var step : Etape = Etape(id: "", titre: "", description: "", duree: 0, tabIngredients: [], tabQuantites: [])
    @State var selection : Etape = Etape(id: "", titre: "", description: "", duree: 0, tabIngredients: [], tabQuantites: [])
    
    
    
    init(vm: ListFicheTechniqueViewModel, vmI : ListIngredientViewModel){
        self.listFicheTechniqueVM = vm
        self.listIngredientVM = vmI
        self.intentFicheTechnique = IntentFicheTechnique()
        self.intentIngredient = IntentIngredient()
        self.intentFicheTechnique.addObserver(viewModel: listFicheTechniqueVM)
        self.intentFicheTechnique.addObserver(viewModel: ficheTechniqueVM)
        self.intentIngredient.addObserver(viewModel: vmI)
        self.steps = self.listFicheTechniqueVM.tabEtape
    }
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    
    
    @State private var searchString = ""
    
    var searchIngredient : [Ingredient] {
        if searchString.isEmpty {
            return listIngredientVM.model
        } else {
            return listIngredientVM.searchIngredientByName(nom: searchString)
        }
    }
    
    //var allIngs : [String] = []
    
    
    var body: some View {
        ScrollView{
            VStack(alignment:.leading){
                Text("Votre Fiche Technique")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                
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
            }
            .padding()

            
            VStack(alignment:.leading){
                Text("Les étapes")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.all)
                ///
                Text("Ajouter un etape existante : ")
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding()
                HStack{
                    Picker( "Etapes", selection: $selection){
                        ForEach(steps, id : \.self){
                            Text($0.titre)
                        }
                    }
                    .padding()
                    .background(Color(red : 220/255, green : 220/255, blue : 220/255))
                    .foregroundColor(.white)
                    .cornerRadius(5.0)
                    .pickerStyle(.menu)
                    Button(action: {
                        print("nom de l'ing \(selection.titre)")
                        self.tabEtape.append(selection)
                        self.tabReferenceEtape.append(selection.id)
                    }){
                        Label("Ajouter", systemImage: "plus")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(.gray)
                    .cornerRadius(5.0)
                    TextField("step", text: $step.titre)
                }
                .padding()
                ///
                VStack(alignment: .leading){
                    Text("étapes à ajouter :")
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
                VStack(alignment: .leading){
                    Text("Créer une nouvelle étape")
                        .font(.headline)
                        .foregroundColor(.green)
                        .padding(.bottom)
                    Text("Titre de l'étape : ")
                        .font(.headline)
                    TextField("titre", text: $etape.titre)
                        .padding(.all)
                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                        .cornerRadius(5.0)
                }
                .padding()
                VStack(alignment: .leading){
                    Text("Description de l'étape : ")
                        .font(.headline)
                    TextField("description", text: $etape.description)
                        .padding(.all)
                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                        .cornerRadius(5.0)
                }
                .padding()
                VStack(alignment: .leading){
                    Text("Durée de l'étape : ")
                        .font(.headline)
                    TextField("durée", value: $etape.duree, formatter: formatter)
                        .padding(.all)
                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                        .cornerRadius(5.0)
                }
                .padding()
                VStack(alignment: .leading){
                    Text("Ajouter un ingrédient : ")
                        .font(.headline)
                    HStack{
                        Picker( "Ingrédient", selection: $nomIngredient){
                            ForEach(searchIngredient, id : \.nom){
                                Text($0.nom)
                            }
                        }
                        .padding()
                        .background(Color(red : 220/255, green : 220/255, blue : 220/255))
                        .foregroundColor(.white)
                        .cornerRadius(5.0)
                        .pickerStyle(.menu)
                        Button(action: {
                            print("nom de l'ing \(nomIngredient)")
                            self.etape.tabIngredients.append(nomIngredient)
                            self.etape.tabQuantites.append(quantiteIng)
                            self.nomIngredient = ""
                            print(self.etape.tabIngredients)
                        }){
                            Label("Ajouter", systemImage: "plus")
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(.gray)
                        .cornerRadius(5.0)
                        TextField("Ingrédient", text: $nomIngredient)
                    }
                    
                    
                    /*.onSubmit {
                     print("nom de l'ing \(nomIngredient)")
                     self.etape.tabIngredients.append(nomIngredient)
                     self.nomIngredient = ""
                     print(self.etape.tabIngredients)
                     }*/
                    Text("Quantité : ")
                    TextField("Quantité", value: $quantiteIng, formatter: formatter)
                    /*.onSubmit {
                     print("nom de l'ing \(nomIngredient)")
                     self.etape.tabIngredients.append(nomIngredient)
                     self.nomIngredient = ""
                     print(self.etape.tabIngredients)
                     }*/
                        .padding(.all)
                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                        .cornerRadius(5.0)
                }
                .padding()
                    VStack(alignment: .leading){
                        Text("Ingrédients de l'étape :")
                            .font(.headline)
                        ScrollView{
                            HStack{
                                List{
                                    ForEach(self.etape.tabIngredients, id :\.self){
                                        nom in
                                        VStack(alignment: .leading){
                                            Text("nom de l'ingrédient : \(nom)")
                                        }
                                    }
                                    .onDelete{
                                        (indexSet) in
                                        self.etape.tabIngredients.remove(atOffsets: indexSet)
                                        self.etape.tabQuantites.remove(atOffsets: indexSet)
                                    }
                                }
                                List{
                                    ForEach(self.etape.tabQuantites, id :\.self){
                                        q in
                                        VStack(alignment: .leading){
                                            Text("Quantité de l'ingrédient : \(q) ")
                                        }
                                    }
                                }
                                .frame(minHeight: minRowHeight * 3).border(Color.red)
                            }
                        }
                        
                    }
                    .padding()
          
                    VStack(alignment: .leading){
                        Button(action: {
                            self.etape.id = UUID().uuidString
                            self.tabEtape.append(self.etape)
                            self.tabReferenceEtape.append(self.etape.id)
                            self.etape = Etape(id: "", titre: "", description: "", duree: 0, tabIngredients: [], tabQuantites: [])
                        }) {
                            HStack {
                                Spacer()
                                Text("Ajouter cette étape")
                                    .font(.headline)
                                    .foregroundColor(Color.red)
                                Spacer()
                            }
                        }
                    }
                        .padding()
                
                        
                    }
                    //.padding()
                    
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
                        Text("Valider la Fiche Technique")
                            .font(.headline)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                }
                .padding(.vertical, 10.0)
                .background(Color.green)
                .cornerRadius(4.0)
                .padding(.horizontal, 50)
            }
            .padding()
            .background(.green)
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
        
        
        //.background(Color(red : 232/255, green : 211/255, blue : 185/255))
    }
        }
        
    
    func handleSuppressionEtape(indexToSupress: IndexSet) {
        indexToSupress.map{
            self.tabEtape[$0]
        }.forEach {
            etape in let etapeId = etape.id
            print(etapeId)
            for i in 0..<self.tabReferenceEtape.count {
                if( self.tabReferenceEtape[i] == etapeId){
                    self.tabReferenceEtape.remove(at: i)
                }
            }
        }
        self.tabEtape.remove(atOffsets: indexToSupress)
    }
}
