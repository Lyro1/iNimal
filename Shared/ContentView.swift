//
//  ContentView.swift
//  Shared
//
//  Created by Louis Dupont on 18/05/2022.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @State private var litters = getAllLitters()
    @State private var addingLitter = false
    @State private var askedForNotificationPermissions = UserDefaults.standard.value(forKey: "askedForNotificationPermissions") == nil
    @State private var showingLitterDeletionConfirmation = false
    
    var body: some View {
        NavigationView {
            VStack {
                if (litters.count == 0) {
                    Text("Pas de litière...")
                    Image("Empty list cat image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .padding()
                } else {
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(litters, id: \.id) { litter in
                                LitterView(litter: litter)
                                    .confirmationDialog("Êtes-vous sûr de vouloir supprimer " + litter.name + " ?",
                                                        isPresented: $showingLitterDeletionConfirmation,
                                                        titleVisibility: .visible) {
                                        Button("Supprimer " + litter.name, role: .destructive) {
                                            deleteLitter(id: litter.id)
                                            litters = getAllLitters()
                                        }
                                        Button("Annuler", role: .cancel) {}
                                    }
                            }
                            
                        }
                        .padding()
                    }
                }
            }
            .sheet(isPresented: $askedForNotificationPermissions) {
                NotificationPermissionRequestView()
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
            .background(Color.gray.opacity(0.1))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
