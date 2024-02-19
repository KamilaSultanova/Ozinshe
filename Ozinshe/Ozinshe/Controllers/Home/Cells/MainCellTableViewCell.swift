//
//  MainCellTableViewCell.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 02.12.2023.
//

import UIKit
import SnapKit
import SDWebImage

protocol MovieProtocol {
    func movieDidSelect(movie: Movie)
}

class TopAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)?
            .map { $0.copy() } as? [UICollectionViewLayoutAttributes]
        
        attributes?
            .reduce([CGFloat: (CGFloat, [UICollectionViewLayoutAttributes])]()) {
                guard $1.representedElementCategory == .cell else { return $0 }
                return $0.merging([ceil($1.center.y): ($1.frame.origin.y, [$1])]) {
                    ($0.0 < $1.0 ? $0.0 : $1.0, $0.1 + $1.1)
                }
            }
            .values.forEach { minY, line in
                line.forEach {
                    $0.frame = $0.frame.offsetBy(
                        dx: 0,
                        dy: minY - $0.frame.origin.y
                    )
                }
            }
        
        return attributes
    }
}

class MainCollectionViewCell: UICollectionViewCell{
    
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
        label.numberOfLines = 2
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
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptLabel)
    }
    
    private func setupConstraints(){
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.horizontalEdges.equalToSuperview()
            make.width.equalTo(112)
            make.height.equalTo(164)
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

class MainCellTableViewCell: UITableViewCell {

    var delegate: MovieProtocol?
    
    var mainMovie = MainMovie()
    
    let categoryLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "FontColor")
        label.textAlignment = .left
        
        return label
    }()
    
    let allLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1)
        label.tag = 1004
        label.textAlignment = .right
        
        return label
    }()
    
    lazy var collectionView = {
        
        let layout = TopAlignedCollectionViewFlowLayout()
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
        collView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "MainCell")
        
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
    
    private func setupCell(){
        contentView.addSubview(collectionView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(allLabel)
    }
    
    private func setupConstraints(){
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.left.equalToSuperview().inset(24)
            make.bottom.equalTo(collectionView.snp.top).offset(16)
        }
        
        allLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(24)
            make.left.equalTo(categoryLabel.snp.right).offset(10)
            make.centerY.equalTo(categoryLabel)
        }
        
        collectionView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(categoryLabel.snp.bottom).offset(16)
        }
    }
    
    func setData(mainMovie: MainMovie){
        categoryLabel.text = mainMovie.categoryName
        self.mainMovie = mainMovie
        allLabel.text = "ALL".localized()
        collectionView.reloadData()
    }
}

extension MainCellTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainMovie.movies.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! MainCollectionViewCell
        
        if let imageView = cell.viewWithTag(1001) as? UIImageView {
            imageView.sd_setImage(with: URL(string: mainMovie.movies[indexPath.row].poster_link), placeholderImage: nil, context: nil)
        }

        
        //Name of movie
        if let movieName = cell.viewWithTag(1002) as? UILabel{
            movieName.text = mainMovie.movies[indexPath.row].name
        }
        
        
        //Name of genre(first from genre array)
        if let movieGenre = cell.viewWithTag(1003) as? UILabel{
            if let genreItem =  mainMovie.movies[indexPath.row].genres.first{
                movieGenre.text = genreItem.name
            }else{
                movieGenre.text = ""
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.movieDidSelect(movie: mainMovie.movies[indexPath.row])
    }
}
