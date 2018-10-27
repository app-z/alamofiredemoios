//
//  MoviesPresenter.swift
//  AlamofireDemo
//
//  Created by Andreev Dmitry on 10/27/18.
//  Copyright © 2018 Dmitry. All rights reserved.
//

import Foundation

protocol MoviesDelegate{
    func showProgress()
    func hideProgress()
    func moviesDidSucceed()
    func moviesDidFailed(code: Int, error: String)
}


class MoviesPresenter{
    var delegate: MoviesDelegate
    
    let networkService = NetworkService()
    var movies : [Movie] = []
    
    init(delegate: MoviesDelegate) {
        self.delegate = delegate
    }
    
    func requestMovies(){

        self.delegate.showProgress()
        networkService.fetchMovies()
        
        networkService.onCompleteMovies = { result in
            self.movies = result
            self.delegate.hideProgress()
            self.delegate.moviesDidSucceed()
        }

        networkService.onError = { code, error in
            self.delegate.moviesDidFailed(code: code, error: error);
        }

    }
    
}

