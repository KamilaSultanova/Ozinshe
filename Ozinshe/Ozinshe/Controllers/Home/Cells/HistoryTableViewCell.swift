//
//  HistoryTableViewCell.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 02.12.2023.
//

import UIKit
import SnapKit
import SDWebImage

class HistoryCollectionViewCell: UICollectionViewCell{
    
    let imageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.tag = 1001
        
        return iv
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(named: "FontColor")
        label.tag = 1002
        
        return label
    }()
        
    let descriptLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        label.tag = 1003
        
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell(){
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptLabel)
    }
    
    private func setupConstraints(){
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.width.equalTo(184)
            make.height.equalTo(112)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(8)
        }
        
        descriptLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
    }
}

class HistoryTableViewCell: UITableViewCell {
    
    var mainMovie = MainMovie()
    
    var delegate: MovieProtocol?
    
    lazy var collectionView = {
        
        let layout = TopAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24.0, bottom: 0, right: 24.0)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.estimatedItemSize.width = 156
        layout.estimatedItemSize.height = 184
        layout.scrollDirection = .horizontal
        
        var collView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collView.backgroundColor = UIColor(named: "BackgroundColor")
        collView.showsHorizontalScrollIndicator = false
        collView.delegate = self
        collView.dataSource = self
        collView.register(HistoryCollectionViewCell.self, forCellWithReuseIdentifier: "historyCell")

        return collView
    }()
    
    let historyLabel = {
        let label =  UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "FontColor")
        
        return label
    }()
    
    func setData(mainMovie: MainMovie){
        self.mainMovie = mainMovie
        historyLabel.text = "CONTINUE_TO_WATCH".localized()
        collectionView.reloadData()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(named: "BackgroundColor")
        setupCell()
        setupConstraints()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(){
        contentView.addSubview(collectionView)
        contentView.addSubview(historyLabel)
    }
    
    private func setupConstraints(){
        historyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(24)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(historyLabel.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension HistoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainMovie.movies.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "historyCell", for: indexPath) as! HistoryCollectionViewCell
        
        if let imageView = cell.viewWithTag(1001) as? UIImageView {
            imageView.sd_setImage(with: URL(string: mainMovie.movies[indexPath.row].poster_link), placeholderImage: nil, context: nil)
        }


        //Name of movie
        if let movieName = cell.viewWithTag(1002) as? UILabel{
            movieName.text = mainMovie.movies[indexPath.row].name
        }

        //Name of genre(first from genre array)
        let movieGenre = cell.viewWithTag(1003) as! UILabel
        if let genreItem =  mainMovie.movies[indexPath.row].genres.first{
            movieGenre.text = genreItem.name
        }else{
            movieGenre.text = ""
        }
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.movieDidSelect(movie: mainMovie.movies[indexPath.row])
    }
}
    
    
    
    

