//
//  MyMovieSelectedVC.swift
//  Project 2
//
//  Created by Abrar Bhuiyan on 12/13/17.
//  Copyright © 2017 Abrar Bhuiyan. All rights reserved.
//

import UIKit
import Foundation

class MyMovieSelectedVC: UIViewController
{
    var currMovie: Movie!
    var dataSource: MyMoviesDataSource!
    @IBOutlet var currBackDrop: UIImageView!
    @IBOutlet var currPoster: UIImageView!
    @IBOutlet var currTitle: UILabel!
    @IBOutlet var currReleaseDate: UILabel!
    @IBOutlet var currOverview: UILabel!
    
    var origTitle: String!
    var origBackGround: String!
    var origPoster: String!
    var origReleaseDate: String!
    var origSynopsis: String!
    
    var imageFetcher: ImageFetcher!
    
    @IBOutlet var deleteButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        currOverview.numberOfLines = 0
        currTitle.numberOfLines = 0
        currTitle.text = origTitle
        currReleaseDate.text = origReleaseDate
        currOverview.text = origSynopsis
        
        imageFetcher = ImageFetcher()
        
        let url =  "http://image.tmdb.org/t/p/w342//"
        let url2 = "http://image.tmdb.org/t/p/w500//"
        
        let posterPath = url + origPoster
        
        imageFetcher.fetchImage(url: posterPath)
        {
            (fetchResult) -> Void in
            
            switch(fetchResult)
            {
            case let .ImageSuccess(image):
                OperationQueue.main.addOperation() {
                    self.currPoster.image = image
                }
            case let .ImageFailure(error):
                OperationQueue.main.addOperation() {
                    print(error)
                }
            }
        }
        
        let backDropPath = url2 + origBackGround
        
        imageFetcher.fetchImage(url: backDropPath)
        {
            (fetchResult) -> Void in
            
            switch(fetchResult)
            {
            case let .ImageSuccess(image):
                OperationQueue.main.addOperation() {
                    self.currBackDrop.image = image
                }
            case let .ImageFailure(error):
                OperationQueue.main.addOperation() {
                    print(error)
                }
            }
        }
        
        currPoster.layer.masksToBounds = true
        currPoster.layer.borderWidth = 2.5
        currPoster.layer.backgroundColor = UIColor.white.cgColor
        currPoster.layer.cornerRadius = currPoster.bounds.width/8
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        
        view.endEditing(true)
    }
}
