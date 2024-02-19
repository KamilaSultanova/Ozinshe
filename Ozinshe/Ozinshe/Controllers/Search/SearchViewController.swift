//
//  SearchViewController.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 18.11.2023.
//

import UIKit
import SnapKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController {
    
    var categories: [Category] = []
    
    var movies:[Movie] = []
        
    lazy var searchTextfield = {
        let tf = TextFieldWithPadding()
        tf.padding = UIEdgeInsets(top: 0, left: 16.0, bottom: 0, right: 16.0)
        tf.placeholder = "TO_SEARCH".localized()
        tf.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        tf.backgroundColor = UIColor(named: "TabBarColor")
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        tf.addTarget(self, action: #selector(textEditDidBegin), for: .editingDidBegin)
        tf.addTarget(self, action: #selector(textEditDidEnd), for: .editingDidEnd)
        tf.addTarget(self, action: #selector(textfieldEditDidChanged), for: .editingChanged)

        return tf
    }()
    
    let clearButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "erase"), for: .normal)
        button.addTarget(self, action: #selector(clearButton), for: .touchDown)

        return button
    }()
    
    let searchBtn = {
        let button = UIButton()
        button.setImage(UIImage(named: "searchBtn"), for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(named: "CategoryColor")
        button.addTarget(self, action: #selector(searchButton), for: .touchDown)
        
        return button
    }()
    
    let topLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "FontColor")
        label.text = "CATEGORIES".localized()
        
        return label
    }()
    
    lazy var collectionView = {
        
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16.0, left: 24.0, bottom: 16.0, right: 24.0)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 16
        layout.estimatedItemSize.width = 100
        
        var collView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collView.backgroundColor = UIColor(named: "BackgroundColor")
        collView.delegate = self
        collView.dataSource = self
        collView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "cvCell")
        
        return collView
    }()
    
    lazy var tableview = {
        let tv = UITableView()
        tv.backgroundColor = UIColor(named: "BackgroundColor")
        tv.dataSource = self
        tv.delegate = self
        
        return tv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        languageDidChange()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = ""
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = UIColor(named: "arrowColor")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BackgroundColor")
        navigationItem.title = "SEARCH".localized()
        
        configureView()
        setupUI()
        setupConstraints()
        hideKeyboardWhenTapped()
        downloadCategories()
    }
    
    func languageDidChange() {
        navigationItem.title = "SEARCH".localized()
        searchTextfield.placeholder = "TO_SEARCH".localized()
        if searchTextfield.text!.isEmpty{
            topLabel.text = "CATEGORIES".localized()
        }
        else{
            topLabel.text = "SEARCH_RESULTS".localized()
        }
    }
    
    func setupUI(){
        
        view.addSubview(searchTextfield)
        view.addSubview(searchBtn)
        view.addSubview(topLabel)
        view.addSubview(collectionView)
        view.addSubview(tableview)
        view.addSubview(clearButton)
    }
    
    func setupConstraints(){
        searchTextfield.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.left.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        clearButton.snp.makeConstraints { make in
            make.size.equalTo(56)
            make.centerY.equalTo(searchTextfield)
            make.right.equalTo(searchTextfield.snp.right)
        }
        
        searchBtn.snp.makeConstraints { make in
            make.top.equalTo(searchTextfield.snp.top)
            make.right.equalToSuperview().inset(24)
            make.size.equalTo(56)
            make.left.equalTo(searchTextfield.snp.right).offset(16)
        }
        
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(searchTextfield.snp.bottom).offset(35)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom)
            make.bottom.right.left.equalTo(view.safeAreaLayoutGuide)
        }
    }
    func configureView(){
        if searchTextfield.state.isEmpty == true{
            clearButton.isHidden = true
        }
    }
    
    @objc func textEditDidBegin(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
        searchBtn.setImage(UIImage(named: "searchBtnSelected"), for: .normal)
    }
    
    
    @objc func textEditDidEnd(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1.00).cgColor
        searchBtn.setImage(UIImage(named: "searchBtn"), for: .normal)
    }
    
    @objc func textfieldEditDidChanged(_ sender: Any) {
        downloadSearchMovies()
    }
    
    func hideKeyboardWhenTapped(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func clearButton(_ sender: Any) {
            searchTextfield.text = ""
            downloadSearchMovies()
        }
    
    @objc func searchButton(_ sender: UIButton) {
            downloadSearchMovies()
        }
        
    func downloadCategories(){
        SVProgressHUD.show()
            
        let headers : HTTPHeaders = ["Authorization": "Bearer \(Storage.sharedInstance.accessToken)"]
            
        AF.request(Urls.CATEGORY_URL, method: .get,  headers: headers).responseData{
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
                        let category = Category(json: item)
                        self.categories.append(category)
                    }
                    self.collectionView.reloadData()
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
        
        func downloadSearchMovies(){
            
            if searchTextfield.text!.isEmpty{
                topLabel.text = "CATEGORIES".localized()
                collectionView.isHidden = false
                tableview.isHidden = true
                clearButton.isHidden = true
                movies.removeAll()
                tableview.reloadData()
                return
            }
            else{
                topLabel.text = "SEARCH_RESULTS".localized()
                clearButton.isHidden = false
                
                //unhide tableview
                tableview.snp.makeConstraints { make in
                    make.top.equalTo(topLabel.snp.bottom)
                    make.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
                }
                collectionView.isHidden = true
                tableview.isHidden = false
                
            }
            
            SVProgressHUD.show()
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
            ]
            let parameters = ["search": searchTextfield.text!]
            
            AF.request(Urls.SEARCH_MOVIE_URL, method: .get,parameters: parameters, headers: headers).responseData {
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
                        self.movies.removeAll()
                        self.tableview.reloadData()
                        for item in array{
                            let movie = Movie(json: item)
                            self.movies.append(movie)
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

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvCell", for: indexPath) as! CategoryCollectionViewCell
        
        let label = cell.viewWithTag(1001) as! UILabel
        label.text = categories[indexPath.row].name

//        cell.setData(categories: categories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let categoryTVC = CategoryTableViewController()
        categoryTVC.categoryID = categories[indexPath.row].id
        categoryTVC.categoryName = categories[indexPath.row].name
       
        navigationController?.show(categoryTVC, sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 153
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MovieTableViewCell()
        
        cell.setData(movie: movies[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieInfoVC = MovieInfoViewController()
        movieInfoVC.movie = movies[indexPath.row]
        navigationController?.show(movieInfoVC, sender: self)
    }
}
