//
//  MyMoviesVC.swift
//  Project 2
//
//  Created by Abrar Bhuiyan on 12/13/17.
//  Copyright © 2017 Abrar Bhuiyan. All rights reserved.
//

import UIKit
import Foundation

class MyMoviesVC: UIViewController
{

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var refresh: UIButton!
    
    var myMoviesDataSource = MyMoviesDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh.setImage(UIImage(named: "refresh"), for: .normal)
        refresh.setImage(UIImage(named: "refresh"), for: .highlighted)
        refresh.imageEdgeInsets = UIEdgeInsetsMake(2,2,2,2)
        
        collectionView.dataSource = myMoviesDataSource
        collectionView.reloadData()
        self.navigationItem.title = "My Movies"
    }
    
    @IBAction func reloadMyMovies(_ sender: Any)
    {
        collectionView.reloadData()
        print(myMoviesDataSource.myMovies.count)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UICollectionViewCell
        {
            let index = collectionView.indexPath(for: cell)!.row
            if segue.identifier == "myMoviesSelected"
            {
                let newViewController = segue.destination as! MyMovieSelectedVC
                newViewController.currMovie = myMoviesDataSource.myMovies[index]
                newViewController.dataSource = myMoviesDataSource
                newViewController.origTitle = myMoviesDataSource.myMovies[index].title
                newViewController.origSynopsis = myMoviesDataSource.myMovies[index].overview
                newViewController.origReleaseDate = myMoviesDataSource.myMovies[index].releaseDate
                newViewController.origBackGround = myMoviesDataSource.myMovies[index].backDrop
                newViewController.origPoster = myMoviesDataSource.myMovies[index].poster
            }
        }
    }
    
}
