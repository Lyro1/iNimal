//
//  ContentView.swift
//  Shared
//
//  Created by Louis Dupont on 18/05/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("iNimal")
                    .font(.title)
                Spacer()
            }
            .padding()
            VStack(alignment: .leading, spacing: 0) {
                LitterView(litter: Litter(id: 1, name: "Salon", emoji: "🏠", lastClean: Date()))
                    .padding()
                LitterView(litter: Litter(id: 2, name: "Ambre", emoji: "🏠", lastClean: Date()))
                    .padding()
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
