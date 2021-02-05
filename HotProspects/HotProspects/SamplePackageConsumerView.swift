//
//  SamplePackageConsumerView.swift
//  HotProspects
//
//  Created by Dave Spina on 2/4/21.
//

import SamplePackage
import SwiftUI

struct SamplePackageConsumerView: View {
    let possibleNumbers = Array(1...60)
    var results: String {
        let randomArray = possibleNumbers.random(7).sorted()
        let strings = randomArray.map(String.init)
        return strings.joined(separator: ", ")
    }
    var body: some View {
        Text(results)
    }
}

struct SamplePackageConsumerView_Previews: PreviewProvider {
    static var previews: some View {
        SamplePackageConsumerView()
    }
}
