//
//  PeopleMaker.swift
//  HotProspects
//
//  Created by Dave Spina on 2/7/21.
//

import Foundation

class PeopleMaker {
    static let firstNames = ["Adam", "Abagail", "Brandon", "Brenda", "Boris", "Clyde", "Candice", "David", "Deanna", "Elvis", "Evelyn", "George", "Glenda", "Henry", "Harriet", "Igmar", "Ingrid", "John", "Jane", "Kevin", "Kate", "Lenny", "Lynne", "Michael", "Michelle", "Ned", "Nancy", "Owen", "Olivia", "Peter", "Patricia", "Quentin", "Queeny", "Stuart", "Samantha", "Ted", "Tabitha", "Usher", "Ursula", "Victor", "Victoria", "Walter", "Wendy", "Xerces", "Xena", "Yan", "Yolanda", "Zeke", "Zarina"]
    static let lastNames = ["Abbot", "Abernathy", "Brooks", "Brandon", "Coleman", "Custom", "Davis", "Dennis", "Edwards", "Eggelton", "Fredricks", "Foldgers", "Gregory", "Goldman", "Holdman", "Hash", "Igloo", "Iverson", "Johnson", "Jameson", "Kildare", "Kohl", "Lemmings", "Lorimar", "Michaels", "Morris", "Noble", "Nottingham", "Oppenheimer", "Opal", "Peterson", "Peterman", "Quinn", "Quiggly", "Roberts", "Robertson", "Smith", "Samsonite", "Tisch", "Takleman", "Ulman", "Utterman", "Vicious", "Vane", "Woolworth", "Watterson", "Xeno", "Xi", "Young", "Youngman", "Zulu", "Zumerman"]
    
    static func getRandomProspect() -> Prospect {
        let firstName = firstNames.randomElement()
        let lastName = lastNames.randomElement()
        
        let prospect = Prospect()
        prospect.emailAddress = firstName!.lowercased() + "." + lastName!.lowercased() + "@nowhere.net"
        prospect.name = firstName! + " " + lastName!
        return prospect
    }
    
    static func getRandomSimulatedData() -> String {
        let firstName = firstNames.randomElement()
        let lastName = lastNames.randomElement()
        
        let emailAddress = firstName!.lowercased() + "." + lastName!.lowercased() + "@nowhere.net"
        let name = firstName! + " " + lastName!
        
        return name + "\n" + emailAddress
    }
}
