//
//  NotificationPermissionRequestView.swift
//  iNimal
//
//  Created by Louis Dupont on 30/05/2022.
//

import SwiftUI

struct NotificationPermissionRequestView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Comment vous rappeler ?")
                .font(.title)
            Image("Notification cat image")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .padding()
            Text("We need your permission to warn you when the safe space of your little friend needs a cleanup.")
            Spacer()
            Button(action: {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        UserDefaults.standard.set(true, forKey: "askedForNotificationPermissions")
                        dismiss()
                    } else if let error = error {
                        print(error.localizedDescription)
                        dismiss()
                    }
                }
            }) {
                HStack(alignment: .center) {
                    Image(systemName: "bell")
                    Text("Activer les notifications")
                        .padding()
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

struct NotificationPermissionRequestView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPermissionRequestView()
    }
}
