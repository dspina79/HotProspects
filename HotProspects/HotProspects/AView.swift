//
//  AView.swift
//  HotProspects
//
//  Created by Dave Spina on 2/2/21.
//

import SwiftUI

class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Text(user.name)
    }
}

struct AView: View {
    let user = User()
    var body: some View {
        VStack {
            EditView().environmentObject(user)
            DisplayView().environmentObject(user)
        }
    }
}

struct AView_Previews: PreviewProvider {
    static var previews: some View {
        AView()
    }
}
