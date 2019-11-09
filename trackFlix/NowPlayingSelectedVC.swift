//
//  NowPlayingSelected.swift
//  Project 2
//
//  Created by Abrar Bhuiyan on 11/28/17.
//  Copyright © 2017 Abrar Bhuiyan. All rights reserved.
//

import UIKit
import Foundation

class NowPlayingSelectedVC: UIViewController
{
    
    var currMovie: Movie!
    var movieDataSource: MyMoviesDataSource!
    @IBOutlet var currTitle: UILabel!
    @IBOutlet var currBackGround: UIImageView!
    @IBOutlet var currPoster: UIImageView!
    @IBOutlet var currReleaseDate: UILabel!
    @IBOutlet var currSynopsis: UILabel!
    @IBOutlet var addMovieButton: UIButton!
    
    var origTitle: String!
    var origBackGround: String!
    var origPoster: String!
    var origReleaseDate: String!
    var origSynopsis: String!
    
    var imageFetcher: ImageFetcher!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addMovieButton.setImage(UIImage(named: "addMovie"), for: .normal)
        addMovieButton.setImage(UIImage(named: "addMovie"), for: .highlighted)
        addMovieButton.imageEdgeInsets = UIEdgeInsetsMake(2,2,2,2)
        
        currSynopsis.numberOfLines = 0
        currTitle.numberOfLines = 0
        currTitle.text = origTitle
        currReleaseDate.text = origReleaseDate
        currSynopsis.text = origSynopsis
        
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
                    self.currBackGround.image = image
                }
            case let .ImageFailure(error):
                OperationQueue.main.addOperation() {
                    print(error)
                }
            }
        }
        currPoster.dropShadow()
//        currPoster.layer.masksToBounds = true
//        currPoster.layer.borderWidth = 2.5
//        currPoster.layer.backgroundColor = UIColor.white.cgColor
//        currPoster.layer.cornerRadius = currPoster.bounds.width/8
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
    }
    
    @IBAction func addCurrMovie(_ sender: Any)
    {
        let navController = self.tabBarController?.viewControllers![1] as! UINavigationController
        let vc = navController.topViewController as! MyMoviesVC
        
        if vc.myMoviesDataSource.checkMovie(currMovie) == false
        {
            vc.myMoviesDataSource.addMovie(currMovie)
        }
    }
}
