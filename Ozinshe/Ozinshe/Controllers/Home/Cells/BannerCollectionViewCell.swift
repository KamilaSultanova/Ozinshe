//
//  BannerCollectionViewCell.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 02.12.2023.
//

import UIKit
import SnapKit
import SDWebImage

class BannerCollectionViewCell: UICollectionViewCell {
    
    let bannerImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let categoryView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.5, green: 0.18, blue: 0.99, alpha: 1)
        view.layer.cornerRadius = 8
    
        return view
    }()
    
    let categoryLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = .white
        
        return label
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "FontColor")
        
        return label
    }()
    
    let descriptLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        label.numberOfLines = 2
        
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
   
    
    func setupUI(){
        contentView.addSubview(bannerImageView)
        contentView.addSubview(categoryView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(descriptLabel)
        contentView.addSubview(titleLabel)
    }
    
    func setupConstraints(){
        bannerImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(164)
            make.width.equalTo(300)
        }
        
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(bannerImageView.snp.top).inset(8)
            make.left.equalTo(bannerImageView.snp.left).inset(8)
            make.height.equalTo(24)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.centerY.equalTo(categoryView)
            make.horizontalEdges.equalTo(categoryView.snp.horizontalEdges).inset(8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(bannerImageView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
        }
        
        descriptLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    func setData(bannerMovie: BannerMovie){
        
        bannerImageView.sd_setImage(with: URL(string: bannerMovie.link), placeholderImage: nil, context: nil)
        
        if let categoryName = bannerMovie.movie.categories.first?.name{
            categoryLabel.text = categoryName
        }
        titleLabel.text = bannerMovie.movie.name
        descriptLabel.text = bannerMovie.movie.description
    }
}
