//
//  MovieDetailsPresenter.swift
//  AlamofireDemo
//
//  Created by Andreev Dmitry on 10/27/18.
//  Copyright © 2018 Dmitry. All rights reserved.
//

import Foundation

protocol MoviesDetailsDelegate{
    func showProgress()
    func hideProgress()
    func moviesDetailsDidSucceed()
    func moviesDetailsDidFailed(code: Int, error: String)
}

class MoviesDetailsPresenter{
    var delegate: MoviesDetailsDelegate

    let networkService = NetworkService()
    var movieDetails : MovieDetails?
    
    init(delegate: MoviesDetailsDelegate) {
        self.delegate = delegate
    }
    
    func requestMovieDetail(movieId: String){
        
        self.delegate.showProgress()
        networkService.fetchDetail(movieId)
        
        networkService.onCompleteDetail = { result in
            self.movieDetails = result
            self.delegate.hideProgress()
            self.delegate.moviesDetailsDidSucceed()
        }
        
        networkService.onError = { code, error in
            self.delegate.moviesDetailsDidFailed(code: code, error: error);
        }
    }
}
