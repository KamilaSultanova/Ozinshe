//
//  CategoryAge.swift
//  OzinsheDemo
//
//  Created by Kamila Sultanova on 20.09.2023.
//

import Foundation
import SwiftyJSON
//{
//"id": 2,
//"name": "10-12",
//"fileId": 257,
//"link": "http://api.ozinshe.com/core/public/V1/show/257",
//"movieCount": null
//},

class CategoryAge{
    public var id: Int = 0
    public var name: String = ""
    public var link: String = ""
    
    init(json: JSON){
        if let temp = json["id"].int{
            self.id = temp
        }
        if let temp = json["name"].string{
            self.name = temp
        }
        if let temp = json["link"].string{
            self.link = temp
        }
    }
    
}
