//
//  SearchVC.swift
//  Project 2
//
//  Created by Abrar Bhuiyan on 12/13/17.
//  Copyright © 2017 Abrar Bhuiyan. All rights reserved.
//

import UIKit
import Foundation

class SearchVC: UITableViewController, UITextFieldDelegate
{

    var searchArray: SearchArray!
    var imageFetcher: ImageFetcher!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    
    let basePathSearch = "https://api.themoviedb.org/3/search/movie?api_key={f48cf716e48b8a3128c61c3d0634bed5}&query="
    
    override func viewDidLoad() {
        
        searchButton.setImage(UIImage(named: "search"), for: .normal)
        searchButton.setImage(UIImage(named: "search"), for: .normal)
        searchButton.imageEdgeInsets = UIEdgeInsetsMake(2,2,2,2)
        
        searchArray = SearchArray()
        searchArray.searchResults() {(results:[Movie]) in
            print(results.count)
        }
        
        searchTextField.delegate = self
        
        imageFetcher = ImageFetcher()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = 150
        
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
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
        return searchArray.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        
        let movie = searchArray.searchResults[indexPath.row]
        cell.title?.text = movie.title
        cell.realeaseDate?.text = movie.releaseDate
        
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
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell
        {
            let index = tableView.indexPath(for: cell)!.row
            if segue.identifier == "searchSegue"
            {
                let newViewController = segue.destination as! NowPlayingSelectedVC
                newViewController.currMovie = searchArray.searchResults[index]
                newViewController.origTitle = searchArray.searchResults[index].title
                newViewController.origSynopsis = searchArray.searchResults[index].overview
                newViewController.origReleaseDate = searchArray.searchResults[index].releaseDate
                newViewController.origBackGround = searchArray.searchResults[index].backDrop
                newViewController.origPoster = searchArray.searchResults[index].poster
                print(newViewController.currMovie.title)
            }
            
        }
    }

    @IBAction func test(_ sender: Any) {
        tableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        searchArray = SearchArray()
        searchArray.inputString = searchTextField.text!
        searchArray.searchResults() {(results:[Movie]) in

        }
        tableView.reloadData()
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        searchArray = SearchArray()
        searchArray.inputString = searchTextField.text!
        searchArray.searchResults() {(results:[Movie]) in
            
        }
        tableView.reloadData()
    }
}
