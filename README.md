# alamofiredemoios
Alamofire demo ios

Using Swift's Encoder/Decoder protocols which uses NSDictionary as its underlying container mechanism for Alamofire.

[DictionaryCoding](https://github.com/elegantchaos/DictionaryCoding)


  - Simple connecting to project
  - No need anotation for parse field of model
  - Magic like POJO


### Model
```
struct Movie : Codable {
    let id: String
    let poster: String
}
```

### NetworkService
```
class NetworkService {

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
```

### Result processing

```
class NetworkService {

    let URL_MOVIE_LIST : String = BaseURL + "movies.json"
    var onCompleteMovies: ((_ result: [Movie])->())? //an optional function
    

    var onError: ((_ code: Int , _ description: String)->())?
    
\
```

### Use case

```
class MoviesTableVC: UITableViewController,  ErrorDialogCallBack {
    
    let networkService = NetworkService()
    var movies : [Movie] = []
    
        override func viewDidLoad() {
        super.viewDidLoad()
        // request Movie list
        networkService.fetchMovies()
        // Result call back
        networkService.onCompleteMovies = { result in
            self.movies = result
            self.tableView.reloadData();
        }
        // Error processing
        networkService.onError = { code, error in
            showError(errorMessage: error, parentView: self, errCallback: self);
        }
    }
```
