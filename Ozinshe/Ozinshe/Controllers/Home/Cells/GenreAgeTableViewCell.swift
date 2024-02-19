//
//  GenreAgeTableViewCell.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 02.12.2023.
//


import UIKit
import SnapKit
import SDWebImage

class GenreCollectionViewCell: UICollectionViewCell{
    
    let imageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.tag = 1001
        
        return iv
    }()
    
    let genreAgeLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.tag = 1002
        
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
        contentView.addSubview(genreAgeLabel)
    }
    
    private func setupConstraints(){
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(184)
            make.height.equalTo(112)
        }
        
        genreAgeLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(imageView)
            make.centerY.equalTo(imageView)
            
        }
    }
}

class GenreAgeTableViewCell: UITableViewCell {
    
    var mainMovie = MainMovie()
    
    lazy var collectionView = {
        
        let layout = TopAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24.0, bottom: 0, right: 24.0)
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
        collView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: "genreCell")
        
        return collView
    }()
    
    let titleLabel = {
        let label =  UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "FontColor")
        
        return label
    }()
    
    func setData(mainMovie: MainMovie){
        self.mainMovie = mainMovie
        if mainMovie.cellType == .ageCategory{
            titleLabel.text = "AGE_APPROPRIATE".localized()
        }else{
            titleLabel.text = "CHOOSE_GENRE".localized()
        }
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
    
    private func setupCell(){
        contentView.addSubview(collectionView)
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints(){
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
    }
}

extension GenreAgeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mainMovie.cellType == .ageCategory{
            return mainMovie.categoryAges.count
        }
        else{
            return mainMovie.genres.count
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genreCell", for: indexPath) as! GenreCollectionViewCell
        //Image
        if mainMovie.cellType == .ageCategory{
            if let imageView = cell.viewWithTag(1001) as? UIImageView {
                imageView.sd_setImage(with: URL(string: mainMovie.categoryAges[indexPath.row].link), placeholderImage: nil, context: nil)
                }
            }else{
                if let imageView = cell.viewWithTag(1001) as? UIImageView {
                    imageView.sd_setImage(with: URL(string: mainMovie.genres[indexPath.row].link), placeholderImage: nil, context: nil)
                }
            }
        
        //age or genre label
        if mainMovie.cellType == .ageCategory{
            if let label = cell.viewWithTag(1002) as? UILabel{
                //Name of movie
                label.text = mainMovie.categoryAges[indexPath.row].name
            }
        }else{
            if let label = cell.viewWithTag(1002) as? UILabel{
            //Name of genre(first from genre array)
            label.text = mainMovie.genres[indexPath.row].name
        }
    }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
