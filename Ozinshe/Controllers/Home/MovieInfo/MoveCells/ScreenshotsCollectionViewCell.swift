//
//  ScreenshotsCollectionViewCell.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 12.12.2023.
//

import UIKit

class ScreenshotsCollectionViewCell: UICollectionViewCell {
    let imageView = {
        let iv = UIImageView()

        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.tag = 1000
      
        return iv
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(184)
            make.height.equalTo(112)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
