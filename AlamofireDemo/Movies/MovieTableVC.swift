//
//  MovieTableVC.swift
//  AlamofireDemo
//
//  Created by Dmitry on 10/25/18.
//  Copyright © 2018 Dmitry. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension MoviesTableVC : MoviesDelegate{
    func showProgress() {
    }
    
    func hideProgress() {
    }
    
    func moviesDidSucceed() {
        tableView.reloadData()
    }
    
    func moviesDidFailed(code: Int, error: String) {
        showError(errorMessage: error, parentView: self, errCallback: self)
    }
}


class MoviesTableVC: UITableViewController, ErrorDialogCallBack {

//    let networkService = NetworkService()
//    var movies : [Movie] = []
    
    var presenter: MoviesPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableHeaderView = nil;
        self.tableView.tableFooterView = nil;
        self.tableView.separatorStyle = .none

        self.presenter = MoviesPresenter(delegate: self)
        self.presenter?.requestMovies()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.presenter?.movies.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idMovieViewCell", for: indexPath) as! MovieViewCell

        cell.movieId = (self.presenter?.movies[indexPath.row].id)!
        
        let imgUrl = self.presenter?.movies[indexPath.row].poster
        
        Alamofire.request(imgUrl!).responseImage { response in
            debugPrint(response)
            if let image = response.result.value {
                cell.movieImage.contentMode = UIView.ContentMode.scaleAspectFit;
                cell.movieImage.image = image
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showdetails", sender: self)
        
        // Safe Push VC
//        if let movieDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "idMovieDetailsVC") as? MovieDetailsVC {
//            movieDetailsVC.movieId = movies[indexPath.row].id
//            if let navigator = self.navigationController {
//                navigator.pushViewController(movieDetailsVC, animated: true)
//            }
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let controller = destination as? MovieDetailsVC {
            
            controller.movieId = (self.presenter?.movies[(self.tableView.indexPathForSelectedRow!.row)].id)!
            tableView.deselectRow(at: self.tableView.indexPathForSelectedRow!, animated: true)
        }
        
    }
    

    func onErrorClick(status: Int32) {
        print("status = \(status)")
    }
    
}
