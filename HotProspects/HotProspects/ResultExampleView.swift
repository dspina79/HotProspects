//
//  ResultExampleView.swift
//  HotProspects
//
//  Created by Dave Spina on 2/3/21.
//

import SwiftUI

enum NetworkError: Error {
    case badRequest, requestFailed, unknown
}

struct ResultExampleView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                self.fetchData(from: "http://www.apple.com") { result in
                    switch result {
                    case .success(let str):
                        print(str)
                    case .failure(let error):
                        switch error {
                        case .badRequest:
                            print("Bad URL")
                        case .requestFailed:
                            print("Request failed")
                        case .unknown:
                            print("Unknown")
                        }
                    }
                }
            }
    }
    
    func fetchData(from urlString: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.badRequest))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    let stringData = String(decoding: data, as: UTF8.self)
                    completion(.success(stringData))
                } else if error != nil {
                    completion(.failure(.requestFailed))
                } else {
                    completion(.failure(.unknown))
                }
            }
        }.resume()
        
    }
}

struct ResultExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ResultExampleView()
    }
}
