//
//  CategoryCollectionViewCell.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 28.11.2023.
//

import UIKit
import SnapKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    let categoryLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(named: "categoryFontColor")
        label.tag = 1001
        
        return label
    }()
    
    let backView = {
        let view  = UIView()
        
        view.backgroundColor = UIColor(named: "CategoryColor")
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(){
        contentView.addSubview(backView)
        contentView.addSubview(categoryLabel)
    }
    
    func setupConstraints(){
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(34)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
}
