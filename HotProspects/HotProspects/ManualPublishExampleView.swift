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

struct ManualPublishExampleView: View {
    @ObservedObject var updater = DelayedUpdater()
    var body: some View {
        Text("Updater value: \(updater.value)")
    }
}

struct ManualPublishExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ManualPublishExampleView()
    }
}
