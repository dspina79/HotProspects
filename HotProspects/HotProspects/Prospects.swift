//
//  Prospects.swift
//  HotProspects
//
//  Created by Dave Spina on 2/5/21.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}


class Prospects: ObservableObject {
    // people are locked down so they can't run append or any other modifiers
    @Published private(set) var people: [Prospect]
    static let SAVEKEY = "SavedData"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: Prospects.SAVEKEY) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoded
                return
            }
        }
        self.people = []
        
    }
    
    func add(_ prospect: Prospect) {
        self.people.append(prospect)
        self.saveData()
    }
        
    func saveData() {
        if let encoded = try? JSONEncoder().encode(self.people) {
            UserDefaults.standard.setValue(encoded, forKey: Prospects.SAVEKEY)
        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        self.saveData()
    }
}
