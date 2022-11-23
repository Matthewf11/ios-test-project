//
//  dictonaryAPI.swift
//  API-ProgrammaticUI-Practice
//
//  Created by Matthew David Fleischer on 21/11/2022.
//

import Foundation

struct Definitions:Codable {
    var list : [Definition]
}

struct Definition:Codable {
    var definition: String?
    var permalink:String?
    var thumbs_up:Int?
    var sound_urls:[String?]
    var author:String?
    var word:String?
    var defid:Int?
    var currentVote:String?
    var written_on:String?
    var example:String?
    var thumbs_down:Int?
}

protocol DictonaryResponse {
    func queryDictonary(completion: @escaping (Definitions?) -> Void, query:String)
}


class DictonaryApi:DictonaryResponse{
    func queryDictonary(completion: @escaping (Definitions?) -> Void, query:String) {
        let headers = [
            "X-RapidAPI-Key": "0a7e318632msh40a8c872dd77589p1efba8jsn65809613d804",
            "X-RapidAPI-Host": "mashape-community-urban-dictionary.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://mashape-community-urban-dictionary.p.rapidapi.com/define?term=\(query)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                var result:Definitions?
                if let data = data {
                    do{
                        result = try JSONDecoder().decode(Definitions.self, from: data)
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
class MockDictionaryAPI:DictonaryResponse {
    func queryDictonary(completion: @escaping (Definitions?) -> Void, query:String){
        var result:Definitions?
        
        result?.list = [Definition(thumbs_up: 10, sound_urls: [""]),
                  Definition(thumbs_up: 20, sound_urls: [""]),
                  Definition(thumbs_up: 30, sound_urls: [""]),
                  Definition(thumbs_up: 40, sound_urls: [""]),
                  Definition(thumbs_up: 50, sound_urls: [""]),
                  Definition(thumbs_up: 60, sound_urls: [""]),
                  Definition(thumbs_up: 70, sound_urls: [""])]
        completion(result)
    }
}
