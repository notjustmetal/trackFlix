//
//  NowPlayingVC.swift
//  Project 2
//
//  Created by Abrar Bhuiyan on 11/28/17.
//  Copyright © 2017 Abrar Bhuiyan. All rights reserved.
//

import UIKit
import Foundation

class NowPlayingVC: UITableViewController {
    
    var nowPlaying: NowPlaying!
    var imageFetcher: ImageFetcher!
    @IBOutlet var refresh: UIButton!
    @IBOutlet var search: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refresh.setImage(UIImage(named: "refresh"), for: .normal)
        refresh.setImage(UIImage(named: "refresh"), for: .highlighted)
        refresh.imageEdgeInsets = UIEdgeInsetsMake(2,2,2,2)
        search.setImage(UIImage(named: "search"), for: .normal)
        search.setImage(UIImage(named: "search"), for: .normal)
        search.imageEdgeInsets = UIEdgeInsetsMake(2,2,2,2)

        
        nowPlaying = NowPlaying()
        nowPlaying.getNowPlaying() {(results:[Movie]) in
            print(results.count)
        }
        
        imageFetcher = ImageFetcher()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = 150
        
        self.navigationItem.title = "Now Playing"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int
    {
        print(nowPlaying.nowPlayingArray.count)
        return nowPlaying.nowPlayingArray.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "NowPlayingCell", for: indexPath) as! NowPlayingCell

        let movie = nowPlaying.nowPlayingArray[indexPath.row]
        cell.title?.text = movie.title
        cell.rating?.text = movie.releaseDate
        
        let url =  "http://image.tmdb.org/t/p/w185//"
        
        let urlPath = url + movie.poster
        
        imageFetcher.fetchImage(url: urlPath)
        {
            (fetchResult) -> Void in

            switch(fetchResult)
            {
            case let .ImageSuccess(image):
                OperationQueue.main.addOperation() {
                    cell.poster.image = image
                }
            case let .ImageFailure(error):
                OperationQueue.main.addOperation() {
                    print(error)
                }
            }
        }
        cell.poster.dropShadow()
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell
        {
            let index = tableView.indexPath(for: cell)!.row
            if segue.identifier == "NowPlayingSegue"
            {
                let newViewController = segue.destination as! NowPlayingSelectedVC
                newViewController.currMovie = nowPlaying.nowPlayingArray[index]
                newViewController.origTitle = nowPlaying.nowPlayingArray[index].title
                newViewController.origSynopsis = nowPlaying.nowPlayingArray[index].overview
                newViewController.origReleaseDate = nowPlaying.nowPlayingArray[index].releaseDate
                newViewController.origBackGround = nowPlaying.nowPlayingArray[index].backDrop
                newViewController.origPoster = nowPlaying.nowPlayingArray[index].poster
            }
        }
    }
    
    @IBAction func refreshNowPlaying(_ sender: Any)
    {
        tableView.reloadData()
    }
}

