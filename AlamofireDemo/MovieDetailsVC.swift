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

class MovieDetailsVC: UIViewController {

    let networkService = NetworkService()
//    var movieDetals : MovieDetails?

    @IBOutlet var poster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieSummary: UILabel!
    
    var movieId : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkService.fetchDetail(movieId)
        
        networkService.onCompleteDetail = { result in
            self.title = result.title
            self.movieTitle.text = result.title
            self.movieSummary.text = result.summary
            
            let imgUrl = result.poster
            
            Alamofire.request(imgUrl!).responseImage { response in
                debugPrint(response)
                if let image = response.result.value {
                    self.poster.contentMode = UIView.ContentMode.scaleAspectFit;
                    self.poster.image = image
                }
            }
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
