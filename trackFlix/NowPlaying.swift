//
//  NowPlaying.swift
//  Project 2
//
//  Created by Abrar Bhuiyan on 11/28/17.
//  Copyright © 2017 Abrar Bhuiyan. All rights reserved.
//

import Foundation

class NowPlaying: NSObject
{
    var nowPlayingArray: [Movie] = []
    
    let basePathNowPlaying = "https://api.themoviedb.org/3/movie/now_playing?api_key=f48cf716e48b8a3128c61c3d0634bed5&language=en-US&page=1"
    
    func getNowPlaying(completion: @escaping ([Movie]) -> ()) {
        let url = basePathNowPlaying
        let request = URLRequest(url: URL(string: url)!)
        var count = 0
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            if let data = data
            {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let nowPlaying = json["results"] as? [[String:Any]] {
                            for currMovie in nowPlaying {
                                if let movieObject =  try? Movie(json: currMovie)
                                {
                                    self.nowPlayingArray.append(movieObject)
                                    count = count + 1
                                }
                            }
                        }
                    }
                }catch {
                    print(error.localizedDescription)
                }
                
                completion(self.nowPlayingArray)
                
                
            }
            
            
        }
        
        task.resume()
    }
    
    
    
}
