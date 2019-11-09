//
//  MyMoviesDataSource.swift
//  Project 2
//
//  Created by Abrar Bhuiyan on 12/13/17.
//  Copyright © 2017 Abrar Bhuiyan. All rights reserved.
//

import UIKit
import Foundation

class MyMoviesDataSource: NSObject, UICollectionViewDataSource
{
    var myMovies: [Movie]
    var imageFetcher: ImageFetcher!
    
    override init() {
        myMovies = [Movie]()
        imageFetcher = ImageFetcher()
    }
    
    func addMovie(_ movie: Movie) -> Int
    {
        myMovies.insert(movie, at: 0)
        //myMovies.append(movie)
        return myMovies.index(of: movie)!
    }
    
    func deleteMovie(_ movie: Movie)
    {
        let count = myMovies.count
        for i in 0..<count
        {
            if movie.id == myMovies[i].id
            {
                myMovies.remove(at: i)
            }
        }
    }
    
    func checkMovie(_ movie: Movie) -> Bool
    {
        var added = false
        let count = myMovies.count
        for i in 0..<count
        {
            if movie.id == myMovies[i].id
            {
                added = true
            }
        }
        
        return added
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "MyMoviesCell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MyMoviesViewCell
        
        let movie = myMovies[indexPath.row]
        
        let url =  "http://image.tmdb.org/t/p/w185//"
        
        let urlPath = url + movie.poster
        
        imageFetcher.fetchImage(url: urlPath)
        {
            (fetchResult) -> Void in
            
            switch(fetchResult)
            {
            case let .ImageSuccess(image):
                OperationQueue.main.addOperation() {
                    cell.posterImage.image = image
                }
            case let .ImageFailure(error):
                OperationQueue.main.addOperation() {
                    print(error)
                }
            }
        }
        
        cell.posterImage.dropShadow()
        
        return cell
    }
}
