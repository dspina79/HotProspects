//
//  ManualPublishExampleView.swift
//  HotProspects
//
//  Created by Dave Spina on 2/3/21.
//

import SwiftUI

class DelayedUpdater: ObservableObject {
    //@Published var value = 0 // <-- old way
    // new way with manual dispatch
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}


class DelayedDecrementer: ObservableObject {
    var startingValue = 10 {
        willSet {
            objectWillChange.send()
        }
    }
    
    init(_ start: Int) {
        self.startingValue = start
        
        for i in 0...start {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.startingValue -= 1
            }
        }
    }
}

struct ManualPublishExampleView: View {
    @ObservedObject var updater = DelayedUpdater()
    @ObservedObject var decrimenter = DelayedDecrementer(30)
    var body: some View {
        VStack {
            Text("Incrememter value: \(updater.value)")
            Text("Decrementer value: \(decrimenter.startingValue)")
        }
    }
}

struct ManualPublishExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ManualPublishExampleView()
    }
}
