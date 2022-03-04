//
//  SheetViewAjoutEtape.swift
//  Chef-Mobile
//
//  Created by Vincent Baret on 04/03/2022.
//

import Foundation
import SwiftUI


struct SheetViewAjoutEtape : View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var etape : Etape = Etape(id: "", titre: "", description: "", duree: 0, tabIngredients: [])
    
    @ObservedObject var ficheTechniqueVM : FTViewModel
    
    @ObservedObject var listFicheTechniqueVM : ListFicheTechniqueViewModel
    
    var intentFicheTechnique: IntentFicheTechnique
    
    init(vm: ListFicheTechniqueViewModel, FTvm: FTViewModel){
        self.listFicheTechniqueVM = vm
        self.ficheTechniqueVM = FTvm
        self.intentFicheTechnique = IntentFicheTechnique()
        self.intentFicheTechnique.addObserver(viewModel: listFicheTechniqueVM)
        self.intentFicheTechnique.addObserver(viewModel: ficheTechniqueVM)
    }
    
    var body: some View {
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
            
            HStack{
                Button(action: {
                    intentFicheTechnique.intentToChange(etape: self.etape)
                    intentFicheTechnique.intentToChange(etapeAjout: self.etape)
                    print("tableau : \(self.ficheTechniqueVM.tabEtape)")
                        dismiss()
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
    }
}
