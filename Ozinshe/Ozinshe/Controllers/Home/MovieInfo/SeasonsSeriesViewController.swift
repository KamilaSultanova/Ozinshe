//
//  SeasonsSeriesViewController.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 07.12.2023.
//

import UIKit
import SnapKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class SeasonsSeriesViewController: UIViewController {
    
    var movie = Movie()
    var seasons: [Season] = []
    var currentSeason = 0
    
    lazy var seasonCollectView = {
            
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 24, left: 24, bottom: 0, right: 24)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.estimatedItemSize.height = 34
        layout.scrollDirection = .horizontal
        
        var collView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collView.backgroundColor = UIColor(named: "BackgroundColor")
        collView.showsHorizontalScrollIndicator = false
        collView.delegate = self
        collView.dataSource = self
        collView.register(SeasonCollectionViewCell.self, forCellWithReuseIdentifier: "SeasonCell")
        
        return collView
    }()
    
    lazy var tableview = {
        let tv = UITableView()
        tv.backgroundColor = UIColor(named: "BackgroundColor")
        tv.dataSource = self
        tv.delegate = self
        tv.register(SeriesTableViewCell.self, forCellReuseIdentifier: "SeriesCell")
        return tv 
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        navigationItem.title = "SERIES".localized()
        
        setupUI()
        setupConstraints()
        downloadSeasons()
    }
    
    func setupUI(){
        view.addSubview(seasonCollectView)
        view.addSubview(tableview)
    }
    
    func setupConstraints(){
        seasonCollectView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(72)
        }
        
        tableview.snp.makeConstraints { make in
            make.top.equalTo(seasonCollectView.snp.bottom).offset(24)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func downloadSeasons() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request(Urls.GET_SEASONS + String(movie.id), method: .get, headers: headers).responseData { response in
            
            print("\(String(describing: response.request))")  // original URL request
            print("\(String(describing: response.request?.allHTTPHeaderFields))")  // all HTTP Header Fields
            print("\(String(describing: response.response))") // HTTP URL response
            print("\(String(describing: response.data))")     // server data
            print("\(response.result)")   // result of response serialization
            print("\(String(describing: response.value))")   // result of response serialization
            
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                if let array = json.array {
                    for item in array {
                        let season = Season(json: item)
                        self.seasons.append(season)
                    }
                    self.tableview.reloadData()
                    self.seasonCollectView.reloadData()
                } else {
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                }
            } else {
                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = response.response?.statusCode {
                    ErrorString = ErrorString + " \(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
        }
    }

}


extension SeasonsSeriesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource{    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if seasons.isEmpty{
            return 0
        }
        return seasons[currentSeason].videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SeriesCell") as! SeriesTableViewCell
        
        let label = cell.viewWithTag(2001) as! UILabel
        label.text = "\(seasons[currentSeason].videos[indexPath.row].number) " + "EPISODE".localized()
        
        let imageview = cell.viewWithTag(2000) as! UIImageView
        imageview.sd_setImage(with: URL(string: "https://img.youtube.com/vi/\(seasons[currentSeason].videos[indexPath.row].link)/hqdefault.jpg"), completed: nil)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let playerVC = MoviePlayerViewController()
        
        playerVC.video_link = seasons[currentSeason].videos[indexPath.row].link
     
        navigationController?.show(playerVC, sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seasons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeasonCell", for: indexPath) as! SeasonCollectionViewCell
        
        let label = cell.viewWithTag(1001) as! UILabel
        label.text = "\(seasons[indexPath.row].number) " + "SEASON".localized()
        
        let backview = cell.viewWithTag(1000)!
        
        if currentSeason == seasons[indexPath.row].number - 1 {
            label.textColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
            backview.backgroundColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1)
        } else {
            label.textColor = UIColor(red: 0.22, green: 0.25, blue: 0.32, alpha: 1)
            backview.backgroundColor = UIColor(red: 0.22, green: 0.25, blue: 0.32, alpha: 1)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        currentSeason = seasons[indexPath.row].number - 1
        tableview.reloadData()
        collectionView.reloadData()
    }
}
