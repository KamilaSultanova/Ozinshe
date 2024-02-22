//
//  MovieInfoViewController.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 02.12.2023.
//

import UIKit
import SnapKit
import SDWebImage
import SVProgressHUD
import Alamofire
import SwiftyJSON

class MovieInfoViewController: UIViewController {
    
    var movie = Movie()
    
    var similarMovies:[Movie] = []
    
    lazy var scrollView = {
        let scrollview = UIScrollView()
        scrollview.backgroundColor = UIColor(named: "BackgroundColor")
        scrollview.contentInsetAdjustmentBehavior = .never
        scrollview.isScrollEnabled = true
        scrollview.bounces = false
        
        return scrollview
    }()
    
    lazy var maincontentView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let posterImage = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    let gradientView = {
        let view = GradientView()
        view.startColor = .clear
        view.endColor = .black
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    let favoriteButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favButton"), for: .normal)
        button.contentHorizontalAlignment = .center
        button.tintColor = .white
        button.addTarget(self, action: #selector(addFavorite), for: .touchUpInside)
    
        return button
    }()
    
    let playButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "playButton"), for: .normal)
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(playButtonClicked), for: .touchUpInside)
    
        return button
    }()
    
    let shareButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "shareButton"), for: .normal)
        button.contentHorizontalAlignment = .center
        button.tintColor = .white
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
      
        return button
    }()
    
    let backButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.contentHorizontalAlignment = .center
        button.tintColor = .white
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    
        return button
    }()
    
    let favoriteLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1)
        label.text = "ADD_TO_FAV".localized()
        label.numberOfLines = 2
        label.textAlignment = .center
        
        return label
    }()
    
    let shareLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1)
        label.text = "SHARE".localized()
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var backroundView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
        return view
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "FontColor")
        label.text = "title"
        
        return label
    }()
    
    let yearGenreLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        label.text = "year"
        
        return label
    }()
    
    let lineView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "ViewLineColor")
        
        return view
    }()
    
    let secondLineView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "ViewLineColor")
        
        return view
    }()
    
    lazy var descriptionLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        label.contentMode = .left
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.lineBreakStrategy = .standard
        label.text = "title"

        return label
    }()
    
    lazy var fullDescriptButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        button.setTitle("FULL".localized(), for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(fullDescriptionClicked), for: .touchUpInside)
    
        return button
    }()
    
    let descriptionGradient = {
        let view = GradientView()
        view.startColor = UIColor(named: "transparent")!
        view.endColor = UIColor(named: "BackgroundColor")!
        view.startLocation = 0.1
        view.endLocation = 1
        view.backgroundColor = .clear
        
        return view
    }()
    
    let directorLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(red: 0.29, green: 0.33, blue: 0.39, alpha: 1)
        label.text = "DIRECTOR".localized()
        
        return label
    }()
    
    let producerLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(red: 0.29, green: 0.33, blue: 0.39, alpha: 1)
        label.text = "PRODUCER".localized()
        
        return label
    }()
    
    let nameOfDirectorLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        label.text = "name"
        
        return label
    }()
    
    let nameOfProducerLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        label.text = "name"
        
        return label
    }()
    
    let seriesLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "FontColor")
        label.text = "SERIES".localized()
        
        return label
    }()
    
    let seasonButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        button.setTitle("5 сезон, 46 серия", for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(playButtonClicked), for: .touchUpInside)
    
        return button
    }()
    
    let arrowImage = {
        let iv = UIImageView()
        iv.image = UIImage(named: "arrow")
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    let screenshotLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "FontColor")
        label.text = "SCREENSHOTS".localized()
        
        return label
    }()

    
    lazy var screenshotsCollectView = {
        
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.estimatedItemSize.width = 184
        layout.estimatedItemSize.height = 112
        layout.scrollDirection = .horizontal
        
        var collView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collView.backgroundColor = UIColor(named: "BackgroundColor")
        collView.showsHorizontalScrollIndicator = false
        collView.delegate = self
        collView.dataSource = self
        collView.register(ScreenshotsCollectionViewCell.self, forCellWithReuseIdentifier: "screenshotCell")
        
        return collView
    }()
    
    
    let similarLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "FontColor")
        label.text = "SIMILAR".localized()
        
        return label
    }()
    
    lazy var similarCollectView = {
        
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24.0, bottom: 0, right: 24.0)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.estimatedItemSize.width = 112
        layout.estimatedItemSize.height = 220
        layout.scrollDirection = .horizontal
        
        var collView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collView.backgroundColor = UIColor(named: "BackgroundColor")
        collView.showsHorizontalScrollIndicator = false
        collView.delegate = self
        collView.dataSource = self
        collView.register(SimilarMovieCollectionViewCell.self, forCellWithReuseIdentifier: "similarMovieCell")
        
        return collView
    }()
    
    let allButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.setTitle("ALL".localized(), for: .normal)
        button.contentHorizontalAlignment = .right
        
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.title = ""
        navigationController?.navigationBar.tintColor = UIColor(named: "arrowColor")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setData()
        setupUI()
        setupConstraints()
        configureViews()
        downloadSimilar()
        
    }
    
    func setupUI(){
        view.addSubview(scrollView)
        scrollView.addSubview(maincontentView)
        maincontentView.addSubview(posterImage)
        maincontentView.addSubview(gradientView)
        maincontentView.addSubview(favoriteLabel)
        maincontentView.addSubview(favoriteButton)
        maincontentView.addSubview(playButton)
        maincontentView.addSubview(shareLabel)
        maincontentView.addSubview(shareButton)
        maincontentView.addSubview(backButton)
        maincontentView.addSubview(backroundView)
        backroundView.addSubview(titleLabel)
        backroundView.addSubview(yearGenreLabel)
        backroundView.addSubview(lineView)
        backroundView.addSubview(secondLineView)
        backroundView.addSubview(descriptionLabel)
        backroundView.addSubview(descriptionGradient)
        backroundView.addSubview(fullDescriptButton)
        backroundView.addSubview(directorLabel)
        backroundView.addSubview(nameOfDirectorLabel)
        backroundView.addSubview(producerLabel)
        backroundView.addSubview(nameOfProducerLabel)
        backroundView.addSubview(seriesLabel)
        backroundView.addSubview(seasonButton)
        backroundView.addSubview(arrowImage)
        backroundView.addSubview(screenshotLabel)
        backroundView.addSubview(screenshotsCollectView)
        backroundView.addSubview(similarLabel)
        backroundView.addSubview(similarCollectView)
        backroundView.addSubview(allButton)  
    }
    
    func setupConstraints(){
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)

        }
        
        maincontentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()

        }
        
        posterImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(364)
        }
        
        gradientView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.height.equalTo(364)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(37)
            make.top.equalToSuperview().inset(204)
            make.size.equalTo(100)
        }
        
        playButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(172)
            make.size.equalTo(120)
        }
        
        shareButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(37)
            make.top.equalToSuperview().inset(204)
            make.size.equalTo(100)
        }
        
        favoriteLabel.snp.makeConstraints { make in
            make.centerX.equalTo(favoriteButton)
            make.top.equalTo(favoriteButton.snp.bottom).inset(40)
        }
        
        shareLabel.snp.makeConstraints { make in
            make.centerX.equalTo(shareButton)
            make.top.equalTo(shareButton.snp.bottom).inset(40)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.width.equalTo(100)
            make.left.equalToSuperview()
        }
        
        backroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(324)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(24)
        }
        
        yearGenreLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(yearGenreLabel.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        descriptionGradient.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(descriptionLabel)
            make.bottom.equalTo(descriptionLabel)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
    
        fullDescriptButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
        }
        
        directorLabel.snp.makeConstraints { make in
            make.top.equalTo(fullDescriptButton.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24)
        }
   
        nameOfDirectorLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(115)
            make.centerY.equalTo(directorLabel)
            make.right.equalToSuperview().inset(24)
        }
        
        producerLabel.snp.makeConstraints { make in
            make.top.equalTo(directorLabel.snp.bottom).offset(8)
            make.left.equalTo(directorLabel)
        }
        
        nameOfProducerLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(nameOfDirectorLabel)
            make.centerY.equalTo(producerLabel)
        }
        
        secondLineView.snp.makeConstraints { make in
            make.top.equalTo(producerLabel.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        seriesLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(secondLineView.snp.bottom).offset(24)
        }
        
        seasonButton.snp.makeConstraints { make in
            make.centerY.equalTo(seriesLabel)
            make.right.equalTo(arrowImage.snp.left)
            make.left.equalTo(seriesLabel)
        }
        
        arrowImage.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(24)
            make.size.equalTo(16)
            make.centerY.equalTo(seriesLabel)
            make.left.equalTo(seasonButton.snp.right)
        }
        
        screenshotLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.top.equalTo(seriesLabel.snp.bottom).offset(32)
        }
        
        screenshotsCollectView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.top.equalTo(screenshotLabel.snp.bottom).offset(16)
            make.height.equalTo(112)
        }
        
        similarLabel.snp.makeConstraints { make in
            make.top.equalTo(screenshotsCollectView.snp.bottom).offset(32)
            make.left.equalToSuperview().inset(24)
            make.right.equalTo(allButton.snp.left)
        }
        
        allButton.snp.makeConstraints { make in
            make.centerY.equalTo(similarLabel)
            make.right.equalToSuperview().inset(24)
        }
        
        similarCollectView.snp.makeConstraints { make in
            make.top.equalTo(similarLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview().inset(45)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(220)
        }
    }
    
    func setData(){
        posterImage.sd_setImage(with: URL(string: movie.poster_link))
        titleLabel.text = movie.name
        yearGenreLabel.text = "\(movie.year)"
        for item in movie.genres{
            yearGenreLabel.text = yearGenreLabel.text! + " • " + item.name
        }
        descriptionLabel.text = movie.description
        fullDescriptButton.setTitle("FULL".localized(), for: .normal)
        nameOfDirectorLabel.text = movie.director
        nameOfProducerLabel.text = movie.producer
        seasonButton.setTitle("\(movie.seasonCount) " + "SEASON".localized() + " \(movie.seriesCount) " + "EPISODE".localized(), for: .normal)

    }
    
    func configureViews(){
        
        if movie.favorite == true{
            favoriteButton.setImage(UIImage(named: "favButtonSelected"), for: .normal)
        }else{
            favoriteButton.setImage(UIImage(named: "favButton"), for: .normal)
        }
        
        if movie.movieType == "MOVIE"{
            seriesLabel.isHidden = true
            seasonButton.isHidden = true
            arrowImage.isHidden = true
            screenshotLabel.snp.makeConstraints { make in
                make.top.equalTo(secondLineView.snp.bottom).offset(24)
            }
        }else{
            seasonButton.setTitle("\(movie.seasonCount) " + "SEASON".localized() + " \(movie.seriesCount) " + "EPISODE".localized(), for: .normal)
        }
        
        if similarMovies.isEmpty{
            similarLabel.isHidden = true
            similarCollectView.isHidden = true
            allButton.isHidden = true
            screenshotsCollectView.snp.makeConstraints { make in
                make.bottom.equalToSuperview().inset(45)
            }
        }
        

            descriptionLabel.layoutIfNeeded()

        if descriptionLabel.maxNumberOfLines < 5  {
            descriptionLabel.numberOfLines = 4
            fullDescriptButton.isHidden = true
            descriptionGradient.isHidden = true
            directorLabel.snp.makeConstraints { make in
                make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
                make.left.equalToSuperview().inset(24)
            }
        }
            descriptionLabel.numberOfLines = 4
    }
    
    func downloadSimilar(){
        SVProgressHUD.show()
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request(Urls.GET_SIMILAR + String(movie.id), method: .get, headers: headers).responseData { response in
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
                    for item in array{
                        let movie = Movie(json: item)
                        self.similarMovies.append(movie)
                    }
                    
                    self.similarCollectView.reloadData()
                    
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
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func playButtonClicked(_ sender: Any) {
        if movie.movieType == "MOVIE"{
            let playerVC = MoviePlayerViewController()

            playerVC.video_link = movie.video_link
            playerVC.movieId = movie.id
            
            navigationController?.show(playerVC, sender: self)
        }else{
            let seasonVC = SeasonsSeriesViewController()
            seasonVC.movie = movie
        
            navigationController?.show(seasonVC, sender: self)
        }
    }
    
    @IBAction func addFavorite(_ sender: Any) {
        var method = HTTPMethod.post
        if movie.favorite{
            method = .delete
        }
        
        SVProgressHUD.show()
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        let parameters = ["movieId": movie.id] as [String: Any]
        
        AF.request(Urls.FAVORITE_URL, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
           
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
               
                self.movie.favorite.toggle()
                    
                self.configureViews()
                    
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
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        let text = "\(movie.name) \n\(movie.description)"
        let image = posterImage.image
        let shareAll = [text, image!] as [Any]
        let acttivityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        acttivityViewController.popoverPresentationController?.sourceView = self.view
        self.present(acttivityViewController, animated: true)
    }

    @IBAction func fullDescriptionClicked(_ sender: Any) {
        if descriptionLabel.numberOfLines > 4{
            descriptionLabel.numberOfLines = 4
            fullDescriptButton.setTitle("FULL".localized(), for: .normal)
            descriptionGradient.isHidden = false
        }else{
            descriptionLabel.numberOfLines = 30
            fullDescriptButton.setTitle("MINIMIZE".localized(), for: .normal)
            descriptionGradient.isHidden = true
        }
    }

}

extension MovieInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.similarCollectView{
            return similarMovies.count
        }
        return movie.screenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.similarCollectView{
            let similarMovieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "similarMovieCell", for: indexPath) as! SimilarMovieCollectionViewCell
            
            if let imageView = similarMovieCell.viewWithTag(1001) as? UIImageView{
                imageView.sd_setImage(with: URL(string: similarMovies[indexPath.row].poster_link))
            }
     
            if let movieName = similarMovieCell.viewWithTag(1002) as? UILabel{
                movieName.text = similarMovies[indexPath.row].name
            }

            if let movieGenreName = similarMovieCell.viewWithTag(1003) as? UILabel{
                if let genreName = similarMovies[indexPath.row].genres.first{
                    movieGenreName.text = genreName.name
                }else{
                    movieGenreName.text = ""
                }
            }
            
            return similarMovieCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "screenshotCell", for: indexPath) as! ScreenshotsCollectionViewCell
        
     
        if let imageView = cell.viewWithTag(1000) as? UIImageView{
            imageView.sd_setImage(with: URL(string: movie.screenshots[indexPath.row].link))
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.similarCollectView{
            let movieInfoVC = MovieInfoViewController()
            movieInfoVC.movie = similarMovies[indexPath.row]
            
            navigationController?.show(movieInfoVC, sender: self)
        } 
    }
    
}



