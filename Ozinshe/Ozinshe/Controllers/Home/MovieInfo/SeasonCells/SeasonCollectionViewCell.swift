//
//  SeasonCollectionViewCell.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 12.12.2023.
//

import UIKit

class SeasonCollectionViewCell: UICollectionViewCell {
    let cell = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1)
        view.layer.cornerRadius = 8
        view.tag = 1000
        
        return view
    }()
    
    let label = {
        let seasonLabel = UILabel()
        seasonLabel.textColor = .white
        seasonLabel.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        seasonLabel.tag = 1001
        
        return seasonLabel
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
        contentView.addSubview(cell)
        contentView.addSubview(label)
    }
    
    func setupConstraints(){
        cell.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(34)
        }
        
        label.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(cell.snp.horizontalEdges).inset(16)
            make.centerY.equalTo(cell)
        }
    }
}
