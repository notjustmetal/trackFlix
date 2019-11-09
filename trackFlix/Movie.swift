//
//  Movie.swift
//  Project 2
//
//  Created by Abrar Bhuiyan on 11/28/17.
//  Copyright © 2017 Abrar Bhuiyan. All rights reserved.
//

import Foundation

class Movie: NSObject{
    
    //contants of a movie
    var id: Int
    var title: String
    var poster: String
    var releaseDate: String
    var overview: String
    var rating: Double
    var backDrop: String
    
    //enumerator to handle errors
    enum SerializationError:Error
    {
        case missing(String)
        case invalid(String, Any)
    }
    
    //initializer for movies
    init(json:[String:Any]) throws
    {
        guard let id = json["id"] as? Int else {throw SerializationError.missing("id is missing")}
        guard let title =  json["title"] as? String else {throw SerializationError.missing("title is mising")}
        guard let poster = json["poster_path"] as? String else {throw SerializationError.missing("poster is missing")}
        guard let releaseDate = json["release_date"] as? String else {throw SerializationError.missing("release date is missing")}
        guard let overview = json["overview"] as? String else {throw SerializationError.missing("overview is missing")}
        guard let rating = json["vote_average"] as? Double else {throw SerializationError.missing("rating is missing")}
        guard let backDrop = json["backdrop_path"] as? String else {throw SerializationError.missing("backdrop is missing")}
        
        self.id = id
        self.title = title
        self.poster = poster
        self.releaseDate = releaseDate
        self.overview = overview
        self.rating = rating
        self.backDrop = backDrop
    }
    
    init(inPoster: String)
    {
        self.id = 0
        self.title = "shit"
        self.poster = inPoster
        self.releaseDate = "releaseDate"
        self.overview = "overview"
        self.rating = 0
        self.backDrop = "backDrop"
    }
}
