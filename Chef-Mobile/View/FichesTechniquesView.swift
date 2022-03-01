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
                VStack(alignment: .leading){
                    //Text("Fiches Techniques").font(.title)
                      //  .bold().padding()
                    LazyVGrid(columns: cols){
                        ForEach(1...10, id: \.self){ i in
                            Text("\(i)")
                        }.padding()
                        
                    }
                }.navigationTitle("Fiches Techniques")
            }.background(Color(UIColor.systemGray6))
        }
    }
}

struct FichesTechniquesView_Previews: PreviewProvider {
    static var previews: some View {
        FichesTechniquesView()
    }
}
