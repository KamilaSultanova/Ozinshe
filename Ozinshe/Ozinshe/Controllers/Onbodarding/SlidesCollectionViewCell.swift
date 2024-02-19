//
//  SlidesCollectionViewCell.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 04.12.2023.
//

import UIKit
import SnapKit

class SlidesCollectionViewCell: UICollectionViewCell {
    
    let image = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let imageGradient = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "Overlay")
        
        return iv
    }()

    
    let skipButton = {
        let button = UIButton()
        button.setTitle("CONTINUE_BUTTON".localized(), for: .normal)
        button.setTitleColor(UIColor(named: "FontColor"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        button.backgroundColor = UIColor(named: "onboardingColor")
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        
        return button
    }()
    
    let nextButton = {
        
        let button = UIButton()
        button.setTitle("NEXT_BUTTON".localized(), for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(red: 0.5, green: 0.18, blue: 0.99, alpha: 1)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        
        return button
    }()
    
    let titlelabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 24)
        label.textColor = UIColor(named: "FontColor")
        label.textAlignment = .center

        return label
    }()
    
    let descriptionlabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.numberOfLines = 6
        label.textColor = UIColor(red: 0.42, green: 0.45, blue: 0.5, alpha: 1)
        label.textAlignment = .center
        
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
        contentView.addSubview(image)
        contentView.addSubview(imageGradient)
        contentView.addSubview(skipButton)
        contentView.addSubview(nextButton)
        contentView.addSubview(titlelabel)
        contentView.addSubview(descriptionlabel)
     
    }
    func setupConstraints(){
        image.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2).offset(100)
        }
        
        imageGradient.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2).offset(100)
        }
        
        skipButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(24)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(45)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        titlelabel.snp.makeConstraints { make in
            make.bottom.equalTo(image.snp.bottom).inset(2)
            make.horizontalEdges.equalToSuperview()
        }
        
        descriptionlabel.snp.makeConstraints { make in
            make.top.equalTo(titlelabel.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(32)
        }
    }
    
    func setData(slide: [String] ) {
        image.image = UIImage(named: slide[0])
        titlelabel.text = slide[1].localized()
        descriptionlabel.text = slide[2].localized()

    }
    
}
