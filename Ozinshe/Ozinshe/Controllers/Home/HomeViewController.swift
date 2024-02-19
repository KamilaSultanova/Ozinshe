//
//  HomeViewController.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 18.11.2023.
//

import UIKit
import SVProgressHUD
import SwiftyJSON
import Alamofire

class HomeViewController: UIViewController, MovieProtocol {
    
    var mainMovies:[MainMovie] = []
    
    lazy var tableview = {
        let tv = UITableView()
        tv.backgroundColor = UIColor(named: "BackgroundColor")
        tv.dataSource = self
        tv.delegate = self
        tv.register(MainBannerTableViewCell.self, forCellReuseIdentifier: "mainBannerCell")
        tv.register(MainCellTableViewCell.self, forCellReuseIdentifier: "mainCell")
        tv.register(HistoryTableViewCell.self, forCellReuseIdentifier: "historyCell")
        tv.register(GenreAgeTableViewCell.self, forCellReuseIdentifier: "genreAgeCell")

        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BackgroundColor")
        tableview.separatorStyle = .none
        setupUI()
        setupConstraints()
        addNavBarItem()
        downloadMainBanners()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let nextViewController = navigationController?.topViewController as? MovieInfoViewController {
            nextViewController.navigationController?.setNavigationBarHidden(true, animated: false)
        }else{
            navigationController?.setNavigationBarHidden(false, animated: false)
            navigationItem.title = ""
            navigationController?.navigationBar.tintColor = UIColor(named: "arrowColor")
        }
    }
    
    func setupUI(){
        view.addSubview(tableview)
    }
    
    func setupConstraints(){
        tableview.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func addNavBarItem(){
        let image = UIImage(named: "logoMainPage")
        let imageView = UIImageView(image: image)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
    }
    
    func movieDidSelect(movie: Movie) {
        let movieInfoVC = MovieInfoViewController()
        movieInfoVC.movie = movie
        navigationController?.show(movieInfoVC, sender: self)
    }
    
    //MARK: DOWNLOADS
    //step1 - banner
    func downloadMainBanners(){
        
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request(Urls.MAIN_BANNER_URL, method: .get, headers: headers).responseData { response in
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
                    let movie = MainMovie()
                    movie.cellType = .mainBanner
                    for item in array{
                        let bannerMovie = BannerMovie(json: item)
                        movie.bannerMovie.append(bannerMovie)
                    }
                    self.mainMovies.append(movie)
                    self.tableview.reloadData()
                    
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
            self.downloadUserHistory()
        }
    }
    
    //step2 - user History
    
    func downloadUserHistory(){
        
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request(Urls.USER_HISTORY_URL, method: .get, headers: headers).responseData { response in

            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                if let array = json.array {
                    let movie = MainMovie()
                    movie.cellType = .userHistory
                    for item in array {
                        let historyMovie = Movie(json: item)
                        movie.movies.append(historyMovie)
                    }
                    if array.count > 0 {
                        self.mainMovies.append(movie)
                    }
                    self.tableview.reloadData()
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
            self.downloadMainMovies()
        }
        
    }
    
    //step3 - category
    func downloadMainMovies(){
        SVProgressHUD.show()
        
        let headers : HTTPHeaders = ["Authorization": "Bearer \(Storage.sharedInstance.accessToken)"]
        
        
        AF.request(Urls.MOVIE_MAIN_URL, method: .get, headers: headers).responseData{
            response in
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data{
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200{
                let json = JSON(response.data!)
                print("JSON: \(json)")
                    
                    if let array = json.array{
                        for item in array{
                            if let movieJSON = item["movies"].array{
                                if !movieJSON.isEmpty{
                                    let movie = MainMovie(json: item)
                                    self.mainMovies.append(movie)
                                }
                            }
                            
                        }
                    self.tableview.reloadData()
                }else{
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                }
            }else{
                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = response.response?.statusCode {
                    ErrorString = ErrorString + " \(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
                
            }
            self.downloadGenres()
        }
    }
    //step4-genres
    
    func downloadGenres(){
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request(Urls.GENRE_CATEGORY_URL, method: .get, headers: headers).responseData { response in

            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                if let array = json.array{
                    let movie = MainMovie()
                    movie.cellType = .genre
                    for item in array{
                        let genreCategory = Genre(json: item)
                        movie.genres.append(genreCategory)
                    }
                    if self.mainMovies.count > 4{
                        if self.mainMovies[1].cellType == .userHistory{
                            self.mainMovies.insert(movie, at: 4)
                        }else{
                            self.mainMovies.insert(movie, at: 3)
                        }
                    }else{
                        self.mainMovies.append(movie)
                    }
                    
                    self.tableview.reloadData()
                    
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
            self.downloadCategoryAges()
        }
    }
    
    //step5-categoryAges
    
    func downloadCategoryAges(){
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request(Urls.AGE_CATEGORY_URL, method: .get, headers: headers).responseData { response in
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
                    let movie = MainMovie()
                    movie.cellType = .ageCategory
                    for item in array{
                        let ageCategory = CategoryAge(json: item)
                        movie.categoryAges.append(ageCategory)
                    }
                    if self.mainMovies.count > 8{
                        if self.mainMovies[1].cellType == .userHistory{
                            self.mainMovies.insert(movie, at: 8)
                        }else{
                            self.mainMovies.insert(movie, at: 7)
                        }
                    }else{
                        self.mainMovies.append(movie)
                    }
                    
                    self.tableview.reloadData()
                    
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                //main Banner
        if mainMovies[indexPath.row].cellType == .mainBanner{
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainBannerCell", for: indexPath) as! MainBannerTableViewCell

            cell.setData(mainMovie: mainMovies[indexPath.row])
            cell.delegate = self

            return cell

        }

        //userHistory cell
        if mainMovies[indexPath.row].cellType == .userHistory{
            let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell

            cell.setData(mainMovie: mainMovies[indexPath.row])
            cell.delegate = self
            return cell

        }
        //genres or agecategory
        if mainMovies[indexPath.row].cellType == .genre || mainMovies[indexPath.row].cellType == .ageCategory{
            let cell = tableView.dequeueReusableCell(withIdentifier: "genreAgeCell", for: indexPath) as! GenreAgeTableViewCell

            cell.setData(mainMovie: mainMovies[indexPath.row])

            return cell

        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainCellTableViewCell

        cell.setData(mainMovie: mainMovies[indexPath.row])
        cell.delegate = self

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if mainMovies[indexPath.row].cellType == .mainBanner{
            return 272
        }
        if mainMovies[indexPath.row].cellType == .genre || mainMovies[indexPath.row].cellType == .ageCategory{
            return 184
        }
        if mainMovies[indexPath.row].cellType == .userHistory{
            return 196
        }
        
        return 288
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if mainMovies[indexPath.row].cellType != .mainMovie{
            return
        }
        let categoryTableView = CategoryTableViewController()
        
        categoryTableView.categoryID = mainMovies[indexPath.row].categoryId
        categoryTableView.categoryName = mainMovies[indexPath.row].categoryName
        navigationController?.show(categoryTableView, sender: self)
    }
}
