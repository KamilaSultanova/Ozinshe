//
//  MainBannerTableViewCell.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 02.12.2023.
//

import UIKit
import SnapKit


class MainBannerTableViewCell: UITableViewCell {
    
    var mainMovie = MainMovie()
    
    var delegate: MovieProtocol?
    
    lazy var collectionView = {
        
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 22, left: 24.0, bottom: 10.0, right: 24.0)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.estimatedItemSize.width = 300
        layout.estimatedItemSize.height = 240
        layout.scrollDirection = .horizontal
        
        var collView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collView.backgroundColor = UIColor(named: "BackgroundColor")
        collView.showsHorizontalScrollIndicator = false
        collView.delegate = self
        collView.dataSource = self
        collView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "MainBannerCell")
        
        return collView
    }()
    
    
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
    
    func setData(mainMovie: MainMovie){
        
        self.mainMovie = mainMovie
        collectionView.reloadData()
    }
    
    func setupCell(){
        contentView.addSubview(collectionView)
    }
    
    func setupConstraints(){
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension MainBannerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainMovie.bannerMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainBannerCell", for: indexPath) as! BannerCollectionViewCell
        
        cell.setData(bannerMovie: mainMovie.bannerMovie[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.movieDidSelect(movie: mainMovie.bannerMovie[indexPath.row].movie)
    }
}
