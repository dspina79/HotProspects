//
//  TabExampleView.swift
//  HotProspects
//
//  Created by Dave Spina on 2/2/21.
//

import SwiftUI

struct TabExampleView: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Hello")
                .onTapGesture {
                    self.selectedTab = 1
                }
                .tabItem {
                    Image(systemName: "1.circle.fill")
                    Text("First")
                }
            Text("World")
                .tabItem {
                    Image(systemName: "2.circle.fill")
                    Text("Second")
            }
            .tag(1)
            
        }
    }
}

struct TabExampleView_Previews: PreviewProvider {
    static var previews: some View {
        TabExampleView()
    }
}
