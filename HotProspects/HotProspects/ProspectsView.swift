//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Dave Spina on 2/5/21.
//

import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var isShowingSheet = false
    
    var isShowingIcons = false
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted People"
        case.uncontacted:
            return "Uncontacted People"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.prospectPeople
        case .contacted:
            return prospects.prospectPeople.filter {$0.isContacted}
        case .uncontacted:
            return prospects.prospectPeople.filter {!$0.isContacted}
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(prospect.name)
                                .font(.headline)
                            if self.isShowingIcons && prospect.isContacted {
                                Image(systemName: "person.crop.circle.badge.checkmark")
                            }
                        }
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                            self.prospects.toggle(prospect)
                        }
                        
                        if !prospect.isContacted {
                            Button("Remind Me") {
                                self.addNotification(for: prospect)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(trailing: HStack{
                Button(action: {
                    self.isShowingScanner = true
                }) {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
                }
                Button(action: {
                self.isShowingSheet = true
                }) {
                    Image(systemName: "arrow.up.arrow.down.square.fill")
                    Text("Sort")
                }
            })
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: PeopleMaker.getRandomSimulatedData(), completion: handleScan)
            }
            .actionSheet(isPresented: $isShowingSheet) {
                ActionSheet(title: Text("Sort Order"), message: Text("Select sort order for prospects."), buttons: [
                    .default(Text("By Name")){self.prospects.sortByDate = false},
                    .default(Text("By Recent")) { self.prospects.sortByDate = true},
                    .cancel()
                    ])
            }
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else {
                print("Invalid number of line rows returned.")
                return
            }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            self.prospects.add(person)
            self.prospects.saveData()
        case .failure(let error):
            print("Scanning Failed")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = "Use email address: \(prospect.emailAddress)"
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            
            //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings {settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("Authorization not provided.")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
