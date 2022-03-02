//
//  ListFicheTechniqueView.swift
//  Chef-Mobile
//
//  Created by Adnane El Abbas on 01/03/2022.
//

import SwiftUI

struct ListFicheTechniqueView: View {
    
    @State private var showingSheet = false
    
    @State private var presentActionSheet = false
    
    @State private var indexToSupress : IndexSet = IndexSet()
    
    //Pour la searchBar
    @State private var searchString = ""
    
    var searchFT : [FicheTechnique] {
        if searchString.isEmpty {
            return listFichTechniqueVM.model
        } else {
            return listFichTechniqueVM.searchFTByName(nomFiche: searchString)
        }
    }
    
    @ObservedObject var listFichTechniqueVM : ListFicheTechniqueViewModel
    
    var intentFT: IntentFicheTechnique
    
    init(vm: ListFicheTechniqueViewModel){
        self.listFichTechniqueVM = vm
        self.intentFT = IntentFicheTechnique()
        self.intentFT.addObserver(viewModel: vm)
    }
    
    var body: some View {
        List{
            ForEach(searchFT, id: \.id) {
                FT in
                NavigationLink(destination: FicheTechniqueView(vm: FTViewModel(ficheTechnique: FT), listVm: listFichTechniqueVM))
                {
                        HStack{
                        ZStack{
                            Circle()
                                .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [.red, .pink]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                    )
                                )
                            VStack {
                                Text("\(FT.nbCouvert)")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                                    
                                Text("couverts")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                }
                        }
                        .frame(width: 70, height: 70, alignment: .center)
                        
                        
                        VStack(alignment: .leading){
                            Text(FT.nomFiche)
                                .font(.headline)
                                .fontWeight(.bold)
                                .lineLimit(2)
                                .padding(.bottom, 5)
                            
                            Text("\(FT.nomAuteur)")
                                .padding(5)
                                .font(.system(size: 12.0, weight: .regular))
                                .lineLimit(2)
                                .foregroundColor(.white)
                                .background(Color.green)
                                .cornerRadius(5)
                        }
                    
                        .padding(.horizontal, 5)
                        }
                        .padding(15)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
           
                }
            .onDelete {
                (indexSet) in
                self.indexToSupress = indexSet
                self.presentActionSheet.toggle()
            }
            
        }
        .searchable(text: $searchString)
        .navigationTitle("Fiches Techniques")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing:
                                Button(action: {showingSheet.toggle()}){
            Label("Ajouter", systemImage: "plus")
        })
        .sheet(isPresented: $showingSheet) {
            SheetViewAjoutFT(vm: listFichTechniqueVM)
        }
        .actionSheet(isPresented: $presentActionSheet) {
            ActionSheet(title: Text("Êtes-vous-sûre de vouloir supprimer cette fiche technique ?"),
                        buttons: [
                            .destructive(Text("Supprimer"),
                                         action: { self.handleSuppressionFT(indexToSupress: indexToSupress)}),
                            .cancel()])
        }
    }
    func handleSuppressionFT(indexToSupress: IndexSet) {
        intentFT.intentToChange(indexSet: indexToSupress)
    }
}


struct ListFicheTechniqueView_Previews: PreviewProvider {
    static var previews: some View {
        ListFicheTechniqueView(vm: ListFicheTechniqueViewModel())
    }
}
