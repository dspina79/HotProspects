//
//  ContextMenuExampleView.swift
//  HotProspects
//
//  Created by Dave Spina on 2/4/21.
//

import SwiftUI

struct ContextMenuExampleView: View {
    @State private var backgroundColor = Color.red
    var body: some View {
        VStack {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .padding()
            .background(backgroundColor)
            
            Text("Change Color")
                .padding()
                .contextMenu {
                    Button(action: {
                        self.backgroundColor = Color.red
                    }) {
                        Text("Red")
                            
                    }
                    Button(action: {
                        self.backgroundColor = Color.green
                    }) {
                        Text("Green")
                    }
                
                    Button(action: {
                        self.backgroundColor = Color.blue
                    }) {
                        Text("Blue")
                    }
                }
                
        }
    }
}

struct ContextMenuExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenuExampleView()
    }
}
