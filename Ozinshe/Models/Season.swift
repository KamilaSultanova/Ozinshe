//
//  Season.swift
//  OzinsheDemo
//
//  Created by Kamila Sultanova on 26.10.2023.
//

import Foundation
import SwiftyJSON

class Series {
    var id: Int = 0
    var link: String = ""
    var number: Int = 0
    
    init(json:JSON){
        if let temp = json["id"].int{
            self.id = temp
        }
        if let temp = json["link"].string{
            self.link = temp
        }
        if let temp = json["number"].int{
            self.number = temp
        }
    }
}

class Season{
    var id: Int = 0
    var movieId: Int = 0
    var number: Int = 0
    var videos: [Series] = []
    
    init(json:JSON){
        if let temp = json["id"].int{
            self.id = temp
        }
        if let temp = json["movieId"].int{
            self.movieId = temp
        }
        if let temp = json["number"].int{
            self.number = temp
        }
        if let array = json["videos"].array{
            for item in array{
                let video = Series(json: item)
                videos.append(video)
            }
        }
    }
}
