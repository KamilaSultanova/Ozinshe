//
//  Screenshot.swift
//  OzinsheDemo
//
//  Created by Kamila Sultanova on 20.09.2023.
//

import Foundation
import SwiftyJSON


//{
//"id": 148,
//"link": "http://api.ozinshe.com/core/public/V1/show/620",
//"fileId": 620,
//"movieId": 116
//}

class Screenshot {
    public var id: Int = 0
    public var link: String = ""
    
    init(json:JSON){
        if let temp = json["id"].int{
            self.id = temp
        }
        if let temp = json["link"].string{
            self.link = temp
        }
    }
}


