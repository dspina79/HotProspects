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
    var dateAdded = Date()
    fileprivate(set) var isContacted = false
}


class Prospects: ObservableObject {
    // people are locked down so they can't run append or any other modifiers
    @Published private(set) var people: [Prospect]
    @Published var sortByDate = false
    
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
    
    var prospectPeople: [Prospect] {
        if self.sortByDate {
            return peopleByRecent
        }
        
        return peopleByName
    }
    
    var peopleByName: [Prospect] {
        return self.people.sorted(by: compareByName)
    }
    
    var peopleByRecent: [Prospect] {
        return self.people.sorted(by: compareByDate)
        
    }
    
    func compareByDate(lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.dateAdded < rhs.dateAdded
    }
    
    func compareByName(lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.name < rhs.name
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
