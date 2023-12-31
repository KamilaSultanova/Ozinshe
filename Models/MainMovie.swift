//
//  MainMovie.swift
//  OzinsheDemo
//
//  Created by Kamila Sultanova on 30.09.2023.
//

import Foundation
import SwiftyJSON


enum CellType{
    case mainBanner
    case mainMovie
    case userHistory
    case genre
    case ageCategory
}

class MainMovie{
    public var categoryId : Int = 0
    public var categoryName : String = ""
    public var movies: [Movie] = []
    
    var bannerMovie: [BannerMovie] = []
    var cellType: CellType = .mainMovie
    var categoryAges: [CategoryAge] = []
    var genres: [Genre] = []
    
    init(){

    }
    init(json: JSON){
        if let temp = json["categoryId"].int{
            self.categoryId = temp
        }
        if let temp = json["categoryName"].string{
            self.categoryName = temp
        }
        if let array = json["movies"].array{
            for item in array{
                let temp = Movie(json: item)
                self.movies.append(temp)
            }
        }
//        if let array = json["bannerMovie"].array{
//            for item in array{
//                let temp = BannerMovie(json: item)
//                self.bannerMovie.append(temp)
//            }
//        }
    
    }
}
