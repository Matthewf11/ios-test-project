//
//  SearchAPI.swift
//  API-ProgrammaticUI-Practice
//
//  Created by Matthew David Fleischer on 17/11/2022.
//



import Foundation


protocol ChuckSearchServicable {
    func searchAPI(completion: @escaping (SearchResponse?) -> Void, searchQuery:String)
}

class ChuckSearchService : ChuckSearchServicable {
    func searchAPI(completion: @escaping (SearchResponse?) -> Void, searchQuery:String) {
        let headers = [
            "accept": "application/json",
            "X-RapidAPI-Key": "56d4ca6551msh6eafa1bf61fc235p12dd71jsn9d21242c8c84",
            "X-RapidAPI-Host": "matchilling-chuck-norris-jokes-v1.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://matchilling-chuck-norris-jokes-v1.p.rapidapi.com/jokes/search?query=\(searchQuery)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                
                var result:SearchResponse?
                
                print(data)
                if let data = data {
                    do{
                        result = try JSONDecoder().decode(SearchResponse.self, from: data)
                    }
                    catch{
                        print("Failed to convert: \(error.localizedDescription)")
                    }
                    completion(result)
                }
            }
        })
        
        dataTask.resume()
    }
}

class MockChuckSearchService : ChuckSearchServicable {
    func searchAPI(completion: @escaping (SearchResponse?) -> Void, searchQuery: String) {
        var response:SearchResponse?
        response?.total = 10
        response?.result = [Body(value:"HAHAHA Joke")]
        completion(response)
    }
}
