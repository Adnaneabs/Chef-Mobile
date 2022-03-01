//
//  FichesTechniquesView.swift
//  Chef-Mobile
//
//  Created by Adnane El Abbas on 23/02/2022.
//

import SwiftUI

struct FichesTechniquesView: View {
    
    let cols=[GridItem(.flexible(), alignment: .leading),GridItem(.flexible(),alignment: .center)]
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                Spacer().frame(height: 30)
                VStack(alignment: .center){
                    LazyVGrid(columns: cols){
                        ForEach(1...10, id: \.self){ i in
                            HStack{
                                Text("fiche technique \(i)")
                                    .background().colorMultiply(.green)
                            }
                        }.padding()
                    }
                }
            }.navigationTitle("Fiches Techniques")
        }
    }
}

struct FichesTechniquesView_Previews: PreviewProvider {
    static var previews: some View {
        FichesTechniquesView()
    }
}
