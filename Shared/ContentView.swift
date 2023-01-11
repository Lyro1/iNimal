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
                            ForEach(litters.indices) { index in
                                ZStack {
                                    Color("Dark Pastel Green")
                                        .cornerRadius(20)
                                    HStack {
                                        Spacer()
                                        Button(action: {showingLitterDeletionConfirmation = true}) {
                                            Image(systemName: "paintbrush")
                                                .font(.title)
                                                .foregroundColor(.white)
                                                .frame(width: 65)
                                        }
                                    }
                                    LitterView(litter: litters[index])
                                        .confirmationDialog("Êtes-vous sûr de vouloir supprimer " + litters[index].name + " ?",
                                                            isPresented: $showingLitterDeletionConfirmation,
                                                            titleVisibility: .visible) {
                                            Button("Supprimer " + litters[index].name, role: .destructive) {
                                                deleteLitter(id: litters[index].id)
                                                litters = getAllLitters()
                                            }
                                            Button("Annuler", role: .cancel) {}
                                        }
                                    // drag gesture ...
                                                            .offset(x: litters[index].offset)
                                                            .gesture(DragGesture()
                                                                .onChanged({(value) in onChanged(value: value, index: index)})
                                                                .onEnded({(value) in onEnded(value: value, index: index)}))
                                }
                                .padding(.top)
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
    
    func onChanged(value: DragGesture.Value, index: Int) {
        if value.translation.width < 0 {
            litters[index].offset = value.translation.width
        }
    }
    
    func onEnded(value: DragGesture.Value, index: Int) {
        withAnimation {
            if -value.translation.width >= 50 {
                litters[index].offset = -80
            } else {
                litters[index].offset = 0
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
