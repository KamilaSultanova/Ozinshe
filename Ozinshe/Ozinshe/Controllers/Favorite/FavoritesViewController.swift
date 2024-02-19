//
//  FavoritesViewController.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 18.11.2023.
//

import UIKit
import SnapKit
import SVProgressHUD
import Alamofire
import SwiftyJSON
import SDWebImage

class FavoritesViewController: UIViewController {
    
    var favorite: [Movie] = []
    
    lazy var tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor(named: "BackgroundColor")
        tv.dataSource = self
        tv.delegate = self
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BackgroundColor")
        navigationItem.title = "FAVORITES".localized()
        setupUI()
}
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.backgroundColor = UIColor(named: "TabBarColor")
        downloadFavorites()
    }
    
    func setupUI(){
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func downloadFavorites(){
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request(Urls.FAVORITE_URL, method: .get, headers: headers).responseData {
            response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                if let array = json.array{
                    self.favorite.removeAll()
                    for item in array{
                        let movie = Movie(json: item)
                        self.favorite.append(movie)
                    }
                    self.tableview.reloadData()
                }else {
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

 //MARK: UITableViewDelegate, UITableViewDataSource

extension FavoritesViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorite.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MovieTableViewCell()
        
        cell.setData(movie: favorite[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 153
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieInfoVC = MovieInfoViewController()
        movieInfoVC.movie = favorite[indexPath.row]
        navigationController?.show(movieInfoVC, sender: self)
    }
    
}
