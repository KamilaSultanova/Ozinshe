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
    }
    
    func setupUI(){
        view.addSubview(player)
    }
    func setupConstraints(){
        player.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
