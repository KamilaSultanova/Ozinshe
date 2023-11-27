//
//  Movie.swift
//  OzinsheDemo
//
//  Created by Kamila Sultanova on 20.09.2023.
//

import Foundation
import SwiftyJSON


/*{
 "id": 116,
 "movieType": "SERIAL",
 "name": "Алпамыс",
 "keyWords": "батыр Алпамы ",
 "description": "Қазақ даласын қою қараңғылық басып, қақтығыстар күшейген кезде\nаспанда халыққа үміт отын ұялатқан бір нышан пайда болады. Жерге төнген қалың қара\nбұлттарды қақ жарған жарық сәуле көрінеді. Сол жарық сәуле ауыл ортасындағы киіз\nүйдің төбесіне шұғыласын шашқан сәтте дүниеге шыр етіп сәби келеді. Көк аспан\nАлпамыс деген алып батырдың өмірге келуін жаһанға осылай жариялады. Ол\nқиындықтан қажыған халықтың үмітін оятып, сүйеу болады және зұлым күштерден\nқорғайды. Бала сүю бақытынан әлдеқашан күдер үзген ата-ананың қуанышында шек\nболмады. Сәби күн санап емес, сағат санап өседі. Ол күшті әрі епті болады. Алты\nжасында Алпамыс жас батырға айналады. Енді оған жауға шабатын жүйрік тұлпар\nқажет. Сонымен жүйрік ат іздеп әкесіне келгенде алдынан тепсінген шұбар ат шығады.\nАлпамыстың атты ерттеп мінгені сол еді, тұлпар құстай ұша жөнеледі. Іздегені\nтабылып, нағыз батырға лайық сәйгүліктің кездескеніне жас бала қатты қуанады. Сол\nкүні Алпамыс жай ғана жүйрікті емес, сенімді серігін табады. Оны Байшұбар деп\nатайды. Алпамыс шайқасқа бек дайын. Буыны бекімеген жас бала алып күш иесіне\nайналады. Оның бойында қайтпас қайсарлық, ержүректілік, өткір өжеттік, рухты\nбатырлық пайда болады. Енді тек әрекет ету керек! Туған ауылын жау ойрандап,\nмүшкіл халге түсірген. Сауыт-сайманын сайлап, қарулы найза қолға алып, сенімді серігі\nБайшұбарға мініп жауға аттанады. Жау әскеріне қарсы құйындата шауып, олардың күл-\nталқанын шығарады. Жеңілуді білмейтін Алпамыс нағыз\nбатырлықтың нышанына айналады. Енді міне қарсы алдында күйреген жау әскерінің\nқолбасшысы тұр. Алпамыс оны жекпе жекке шақырады. Сөйтіп жойқын шайқас\nбасталады. Ұзаққа созылған ұрыста әлсірей бастаған әскербасы Алпамысты жеңе\nалмайтынына көзі жетеді. Тіс батпайтын хас батырға қылыш та, жебе де тимейді. Аман\nқалған бірнеше жауынгерін ертіп алып, қашуға мәжбүр болады. Туған жерін қорғау\nүшін бүтін бір әскерді жалғыз өзі жойған жойқын күш иесіне төтеп беру мүмкін емес\n\nекенін түсінеді. Жас батыр Алпамыс алғашқы шайқаста-ақ шыңдала туседі. Бірақ алда\nоны көптеген қауіпті жорықтар мен шытырман оқиғалар күтіп тұрды. Себебі, зұлым\nкүш иелері қорғансыз халықты шырмауына алып, туған жерінің берекесін қашырды.\nЖер бетіне қараңғылық түскен кезде құбыжықтарға жан бітіп, берперделері шешілетін.\nЖорық кезінде Алпамыс қанішер Айдаһарман, уытты алып Дәумен, зымиян\nЖезтырнақпен, сонымен қатар қазақ мифологиясында кездесетін көптеген\nкейіпкерлермен бетпе-бет келеді. Біздің батырдың мифтік серіктері мен көмекшілері де\nбар. Зұлым күштерді жою үшін оған аңдар мен құстар, тіпті табиғаттың өзі көмекке\nкеледі.",
 "year": 2020,
 "trend": true,
 "timing": 6,
 "director": "Дильшат Рахматуллин",
 "producer": "Кенжебаева С.Б.",
 "poster": {
 "id": 131,
 "link": "http://api.ozinshe.com/core/public/V1/show/645",
 "fileId": 645,
 "movieId": 116
 },
 "video": null,
 "watchCount": 1818,
 "seasonCount": 1,
 "seriesCount": 10,
 "createdDate": "2022-06-03T11:34:30.444+00:00",
 "lastModifiedDate": "2022-07-14T07:01:42.313+00:00",
 "screenshots": [
 {
 "id": 148,
 "link": "http://api.ozinshe.com/core/public/V1/show/620",
 "fileId": 620,
 "movieId": 116
 },
 {
 "id": 149,
 "link": "http://api.ozinshe.com/core/public/V1/show/621",
 "fileId": 621,
 "movieId": 116
 },
 {
 "id": 150,
 "link": "http://api.ozinshe.com/core/public/V1/show/622",
 "fileId": 622,
 "movieId": 116
 }
 ],
 "categoryAges": [
 {
 "id": 2,
 "name": "10-12",
 "fileId": 257,
 "link": "http://api.ozinshe.com/core/public/V1/show/257",
 "movieCount": null
 },
 {
 "id": 1,
 "name": "8-10",
 "fileId": 353,
 "link": "http://api.ozinshe.com/core/public/V1/show/353",
 "movieCount": null
 }
 ],
 "genres": [
 {
 "id": 27,
 "name": "Ғылыми-танымдық",
 "fileId": 346,
 "link": "http://api.ozinshe.com/core/public/V1/show/346",
 "movieCount": null
 },
 {
 "id": 29,
 "name": "Шытырман оқиғалы",
 "fileId": 349,
 "link": "http://api.ozinshe.com/core/public/V1/show/349",
 "movieCount": null
 }
 ],
 "categories": [
 {
 "id": 9,
 "name": "Мультсериалдар",
 "fileId": null,
 "link": null,
 "movieCount": null
 },
 {
 "id": 1,
 "name": "ÖZINŞE–де танымал",
 "fileId": null,
 "link": "http://api.ozinshe.com/core/public/V1/show/null",
 "movieCount": null
 }
 ],
 "favorite": true
 }
 */

class Movie {
    public var id: Int = 0
    public var movieType: String = ""
    public var name: String = ""
    public var keyWords: String = ""
    public var description: String = ""
    public var year: Int = 0
    public var trend: Bool = false
    public var timing: Int = 0
    public var director: String = ""
    public var producer: String = ""
    public var poster_link: String = ""
    public var video_link: String = ""
    public var watchCount: Int = 0
    public var seasonCount: Int = 0
    public var seriesCount: Int = 0
    public var createdDate: String = ""
    public var lastModifiedDate: String = ""
    public var screenshots: [Screenshot] = []
    public var categoryAges: [CategoryAge] = []
    public var genres: [Genre] = []
    public var categories: [Category] = []
    public var favorite: Bool = false
    
    init() {
    }
    
    init(json: JSON) {
        if let temp = json["id"].int {
            self.id = temp
        }
        if let temp = json["movieType"].string {
            self.movieType = temp
        }
        if let temp = json["name"].string {
            self.name = temp
        }
        if let temp = json["keyWords"].string {
            self.keyWords = temp
        }
        if let temp = json["description"].string {
            self.description = temp
        }
        if let temp = json["year"].int {
            self.year = temp
        }
        if let temp = json["trend"].bool {
            self.trend = temp
        }
        if let temp = json["timing"].int {
            self.timing = temp
        }
        if let temp = json["director"].string {
            self.director = temp
        }
        if let temp = json["producer"].string {
            self.producer = temp
        }
        if json["poster"].exists() {
            if let temp = json["poster"]["link"].string {
                self.poster_link = temp
            }
        }
        if json["video"].exists() {
            if let temp = json["video"]["link"].string {
                self.video_link = temp
            }
        }
        if let temp = json["watchCount"].int {
            self.watchCount = temp
        }
        if let temp = json["seasonCount"].int {
            self.seasonCount = temp
        }
        if let temp = json["seriesCount"].int {
            self.seriesCount = temp
        }
        if let temp = json["createdDate"].string {
            self.createdDate = temp
        }
        if let temp = json["lastModifiedDate"].string {
            self.lastModifiedDate = temp
        }
        if let array = json["screenshots"].array {
            for item in array {
                let temp = Screenshot(json: item)
                self.screenshots.append(temp)
            }
        }
        if let array = json["categoryAges"].array {
            for item in array {
                let temp = CategoryAge(json: item)
                self.categoryAges.append(temp)
            }
        }
        if let array = json["genres"].array {
            for item in array {
                let temp = Genre(json: item)
                self.genres.append(temp)
            }
        }
        if let array = json["categories"].array {
            for item in array {
                let temp = Category(json: item)
                self.categories.append(temp)
            }
        }
        if let temp = json["favorite"].bool {
            self.favorite = temp
        }
    }
}
