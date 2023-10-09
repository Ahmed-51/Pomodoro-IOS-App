//
//  dataFetching.swift
//  Pomodoro
//
//  Created by Ashfaq on 12/24/22.
//

import Foundation

class dataFetching: ObservableObject {
    @Published var datalist = [About]()
    
    init()
    {
        let url = URL(string: "https://run.mocky.io/v3/80e5533c-19b1-420f-9467-503cc50c3ef3")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do{
                if let todoData = data {
                    let decodeData = try JSONDecoder().decode([About].self, from: todoData)
                    DispatchQueue.main.async {
                        self.datalist = decodeData
                    }
                } else {
                    print("No Data")
                }
            } catch {
                print("Error")
            }
        }.resume()
    }
}
