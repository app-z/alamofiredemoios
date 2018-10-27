//
//  NetworkService.swift
//  FastBuy
//
//  Created by Andreev Dmitry on 4/29/18.
//  Copyright © 2018 Andreev Dmitry. All rights reserved.
//

import Foundation
import Alamofire


let BaseURL : String = "https://raw.githubusercontent.com/android10/Sample-Data/master/Android-CleanArchitecture-Kotlin/"

class NetworkService {

    let URL_MOVIE_LIST : String = BaseURL + "movies.json"
    let URL_MOVIE_DETAIL : String = BaseURL + "movie_%@.json"
    var onCompleteDetail: ((_ result: MovieDetails)->())? //an optional function
    var onCompleteMovies: ((_ result: [Movie])->())? //an optional function
    

    var onError: ((_ code: Int , _ description: String)->())?
    
    var headers: HTTPHeaders = [
        "deviceType": "iPhone:1.0",
    ]
    


    /*
 
        Get Movies List
     
    */
    func fetchMovies(){
        
        var movies : [Movie] = []
        
        Alamofire.request(URL_MOVIE_LIST,  method: .get, headers: headers).responseJSON { response in
            // debugPrint(response)
            switch response.result {
            case .success:
                let code = response.response?.statusCode
                if (code == 200){
                    if let result = response.result.value {
                        let jsonData = result as! NSArray
                        do {
                            let decoder = DictionaryDecoder()
                            for moviesData in jsonData {
                                let moviesResp = try decoder.decode(Movie.self, from: moviesData as! NSDictionary)
                                movies.append(moviesResp)
                            }
                            self.onCompleteMovies!(movies)
                        } catch {
                            print("caught: \(error)")
                            self.onError!( -1, "\(error)")
                        }
                    }
                } else {
                    switch code  {
                        case 404:
                            self.onError!(404, "NotFound, Movies does not exist");
                            break;
                        default:
                            self.onError!(code! as Int, "Error login! Unknown Error \(String(describing: code))")
                        }
                    }

            case .failure(let err):
                print(err.localizedDescription)
                self.onError!(-1, err.localizedDescription)

            }
        }
    }
    
    
    
    /*
     
     Get Movies Detail
     
     */
    func fetchDetail(_ movie_id: String){
        let decoder = DictionaryDecoder()
        let url = String(format: URL_MOVIE_DETAIL, movie_id);
        
        //Sending http post request
        Alamofire.request(url, method: .get, headers: headers).responseJSON
            {
                response in
                // print(response)
                switch response.result {
                case .success:
                    let code = response.response?.statusCode
                    if (code == 200){
                        if let result = response.result.value {
                            let jsonData = result as! NSDictionary
                            do {
                                let detailResponse = try decoder.decode(MovieDetails.self, from: jsonData)
                                self.onCompleteDetail!(detailResponse)
                            } catch {
                                print("caught: \(error)")
                                self.onError!( -1, "\(error)")
                            }
                        }
                    } else {
                        switch code  {
                            case 404:
                                self.onError!(404, "Page not found")
                                break
                            default:
                                self.onError!(code! as Int, "Unknown Error \(String(describing: code))")
                            }
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                    self.onError!(-1, err.localizedDescription)
                }
        }
    }


    
}

