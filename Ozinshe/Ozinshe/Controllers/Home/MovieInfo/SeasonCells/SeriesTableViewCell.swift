//
//  SeriesTableViewCell.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 12.12.2023.
//

import UIKit

class SeriesTableViewCell: UITableViewCell{
    
    let image = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        iv.tag = 2000
        
        return iv
    }()
    
    let label = {
        let seriesLabel = UILabel()
        
        seriesLabel.textColor = UIColor(named: "FontColor")
        seriesLabel.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        seriesLabel.tag = 2001
        
        return seriesLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(named: "BackgroundColor")

        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        contentView.addSubview(image)
        contentView.addSubview(label)
    }
    
    func setupConstraints(){
        image.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(179)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
    }
}
