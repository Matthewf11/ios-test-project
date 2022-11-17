//
//  API.swift
//  API-ProgrammaticUI-Practice
//
//  Created by Matthew David Fleischer on 17/11/2022.
//

import Foundation


func requestJoke(completion: @escaping (Response?) -> Void, endPoint:String) {
    let headers = [
        "accept": "application/json",
        "X-RapidAPI-Key": "56d4ca6551msh6eafa1bf61fc235p12dd71jsn9d21242c8c84",
        "X-RapidAPI-Host": "matchilling-chuck-norris-jokes-v1.p.rapidapi.com"
    ]
    
    let request = NSMutableURLRequest(url: NSURL(string: "https://matchilling-chuck-norris-jokes-v1.p.rapidapi.com/jokes/\(endPoint)")! as URL, cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        if (error != nil) {
            print(error)
        } else {
            let httpResponse = response as? HTTPURLResponse
            print("This code is reached")
            var result:Response?
            if let data = data {
                do{
                    result = try JSONDecoder().decode(Response.self, from: data)
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

