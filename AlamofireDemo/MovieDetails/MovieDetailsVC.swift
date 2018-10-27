//
//  MovieDetailsVC.swift
//  AlamofireDemo
//
//  Created by Andreev Dmitry on 10/26/18.
//  Copyright © 2018 Dmitry. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage



extension MovieDetailsVC : MoviesDetailsDelegate{
    
    func showProgress() {
    }
    
    func hideProgress() {
    }
    
    func moviesDetailsDidSucceed() {
        self.title = presenter?.movieDetails!.title
        self.movieTitle.text = presenter?.movieDetails!.title
        self.movieSummary.text = presenter?.movieDetails!.summary
        self.movieCast.text = presenter?.movieDetails!.cast
        self.movieDirector.text = presenter?.movieDetails!.director

        let imgUrl = presenter?.movieDetails!.poster
        
        Alamofire.request(imgUrl!).responseImage { response in
            debugPrint(response)
            if let image = response.result.value {
                self.poster.contentMode = UIView.ContentMode.scaleAspectFit;
                self.poster.image = image
            }
        }
        loadingIndicator.stopAnimating()
    }

    func moviesDetailsDidFailed(code: Int, error: String) {
        showError(errorMessage: error, parentView: self, errCallback: self)
    }
}


class MovieDetailsVC: UIViewController , ErrorDialogCallBack{
    var presenter: MoviesDetailsPresenter?


    let networkService = NetworkService()
//    var movieDetals : MovieDetails?

    @IBOutlet var poster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieSummary: UILabel!
    
    @IBOutlet weak var movieCast: UILabel!
    
    @IBOutlet weak var movieDirector: UILabel!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    var movieId : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadingIndicator.startAnimating()
        loadingIndicator.hidesWhenStopped = true;
        
        presenter = MoviesDetailsPresenter(delegate: self)
        presenter?.requestMovieDetail(movieId: movieId)
    }


    func onErrorClick(status: Int32) {
        print("status = \(status)")
    }
    
}
