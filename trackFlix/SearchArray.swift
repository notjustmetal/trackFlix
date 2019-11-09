//
//  SearchArray.swift
//  Project 2
//
//  Created by Abrar Bhuiyan on 12/13/17.
//  Copyright © 2017 Abrar Bhuiyan. All rights reserved.
//

import UIKit
import Foundation

class SearchArray: NSObject
{
    var searchResults: [Movie] = []
    var inputString = ""
    
    var basePathSearch = "https://api.themoviedb.org/3/search/movie?api_key=f48cf716e48b8a3128c61c3d0634bed5&query="
    
    func searchResults(completion: @escaping ([Movie]) -> ()) {
        changeString(string: inputString)
        let url = basePathSearch + inputString
        let request = URLRequest(url: URL(string: url)!)
        var count = 0
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            if let data = data
            {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let searchPlaying = json["results"] as? [[String:Any]] {
                            for currMovie in searchPlaying {
                                if let movieObject =  try? Movie(json: currMovie)
                                {
                                    self.searchResults.append(movieObject)
                                    count = count + 1
                                }
                            }
                        }
                    }
                }catch {
                    print(error.localizedDescription)
                }
                
                completion(self.searchResults)
            }
            
            
        }
        
        task.resume()
    }
    
    func changeString(string: String)
    {
        var newString = string.replacingOccurrences(of: " ", with: "+")
        inputString = newString
    }
    
    
    
}

