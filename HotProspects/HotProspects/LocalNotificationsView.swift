//
//  LocalNotificationsView.swift
//  HotProspects
//
//  Created by Dave Spina on 2/4/21.
//

import UserNotifications
import SwiftUI

struct LocalNotificationsView: View {
    var body: some View {
        VStack {
            Button("Ask Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            
            Button("Push Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the Cat"
                content.subtitle = "It looks hungry."
                content.sound = .default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }
            
            Button("Push Additional Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Another Notification"
                content.subtitle = "There is another meaning for other groups of people, but did you leave the iron on?"
                content.sound = .default
                content.badge = 1
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

struct LocalNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationsView()
    }
}
