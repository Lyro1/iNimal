//
//  AddLitterView.swift
//  iNimal
//
//  Created by Louis Dupont on 19/05/2022.
//

import SwiftUI

struct AddLitterView: View {
    @Environment(\.dismiss) var dismiss
    @State var name: String = ""
    @State var emoji: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nom", text: $name)
                EmojiTextField(text: $emoji, placeholder: "Icone")
            }
            .navigationTitle("Ajouter une litière")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Annuler") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addLitter(name: name, emoji: emoji)
                        dismiss()
                    } label: {
                        Text("Enregistrer").bold()
                    }
                }
            }
        }
        
    }
}

struct AddLitterView_Previews: PreviewProvider {
    static var previews: some View {
        AddLitterView()
    }
}
