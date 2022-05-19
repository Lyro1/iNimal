//
//  ContentView.swift
//  Shared
//
//  Created by Louis Dupont on 18/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var litters = getAllLitters()
    @State private var addingLitter = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(litters, id: \.id) { litter in
                        LitterView(litter: litter)
                            .padding([.leading, .trailing], 20)
                            .padding([.top, .bottom], 8)
                    }
                }
            }
            .navigationTitle("iNimal")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addingLitter.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $addingLitter, onDismiss: {litters = getAllLitters()}) {
                        AddLitterView()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
