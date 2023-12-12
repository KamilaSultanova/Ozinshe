//
//  MoviePlayerViewController.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 07.12.2023.
//

import UIKit
import SnapKit
import youtube_ios_player_helper

class MoviePlayerViewController: UIViewController {
    
    var video_link = ""
    
     let player = {
        let view = YTPlayerView()
        view.backgroundColor = UIColor(named: "BackgroundColor")
         view.contentMode = .scaleAspectFill
         
        return view
    }()
    
    func setupUI(){
        view.addSubview(player)
        
        player.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }


    override func viewDidLoad() {
        
        setupUI()
        player.load(withVideoId: video_link)
    }
}
