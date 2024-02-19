//
//  CategoryTableViewController.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 28.11.2023.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class CategoryTableViewController: UITableViewController {
    
    var categoryID = 0
    var categoryName = ""
    
    var movies:[Movie] = []
    
    override func viewWillAppear(_ animated: Bool) {
        downloadMoviesByCategories()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "BackgroundColor")

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        navigationItem.title = categoryName

    }

    
    func downloadMoviesByCategories(){
        SVProgressHUD.show()
        
        let headers : HTTPHeaders = ["Authorization": "Bearer \(Storage.sharedInstance.accessToken)"]
        
        let parameters = ["categoryId": categoryID]
        
        AF.request(Urls.MOVIE_BY_CATEGORY_URL, method: .get, parameters: parameters,  headers: headers).responseData{
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
                
                
                
                if json["content"].exists(){
                    if let array = json["content"].array{
                        for item in array{
                            let movie = Movie(json: item)
                            self.movies.append(movie)
                        }
                        self.tableView.reloadData()
                    }
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
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MovieTableViewCell()

        cell.setData(movie: movies[indexPath.row])

        return cell
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 153
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieInfoVC = MovieInfoViewController()
        movieInfoVC.movie = movies[indexPath.row]
        navigationController?.show(movieInfoVC, sender: self)
    }

}
