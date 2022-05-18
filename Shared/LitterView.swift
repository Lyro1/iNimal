//
//  SwiftUIView.swift
//  iNimal
//
//  Created by Louis Dupont on 18/05/2022.
//

import SwiftUI

struct LitterView: View {
    var litter: Litter
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(litter.emoji)
                    .font(.largeTitle)
                Spacer()
            }
            
            .padding()
            HStack {
                Text(litter.name)
                    .font(.headline)
                Spacer()
                Text(litter.getTimeRemaining())
                    .font(.largeTitle)
                    .bold()
            }
    
            .padding()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.gray.opacity(0.3), radius: 4)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        
        LitterView(litter: Litter(id: 1, name: "Salon", emoji: "🏠", lastClean: Date()))
    }
}
