//
//  MoviePlayerViewController.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 07.12.2023.
//

import UIKit
import SnapKit
import youtube_ios_player_helper
import SVProgressHUD
import Alamofire
import SwiftyJSON

class MoviePlayerViewController: UIViewController {
    
    var video_link = ""
    
    var movieId: Int = 0
    
    var watchedMovies:[Movie] = []
    
    let player = {
        let view = YTPlayerView()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    override func viewDidLoad() {
        
        setupUI()
        setupConstraints()
        player.load(withVideoId: video_link)
        print()
        saveWatchHistory(ID: movieId)
    }
    
    func setupUI(){
        view.addSubview(player)
    }
    func setupConstraints(){
        player.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func saveWatchHistory(ID: Int){
        
        let parameters: [String: Any] = [
            "movieId": movieId,
            "timeCode": 0
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        print("\(movieId)")
        
        print("Bearer is \(Storage.sharedInstance.accessToken)")
        
        AF.request(Urls.ADD_USER_HISTORY_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    print("JSON: \(json)")
                    let watchedMovie = Movie(json: json)
                    
                    watchedMovie.timing = 0
                    
                    self.watchedMovies.append(watchedMovie)
                case .failure(let error):
                    print("Error: \(error)")
                }
        }
    }
}
