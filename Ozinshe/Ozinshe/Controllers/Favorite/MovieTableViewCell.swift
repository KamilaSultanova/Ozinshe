//
//  MovieTableViewCell.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 18.11.2023.
//

import UIKit
import SnapKit

class MovieTableViewCell: UITableViewCell {
    let posterImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let titlelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "FontColor")
        
        return label
    }()
    
    let genrelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        
        return label
    }()
    
    let playView:UIView = {
        
        let view = UIView()
        let iv = UIImageView()
        let label = UILabel()
        
        view.addSubview(iv)
        view.addSubview(label)
        view.backgroundColor = UIColor(named: "WatchButtonColor")
        view.layer.cornerRadius = 8
        
        iv.image = UIImage(named: "Play")
        label.text = "WATCH".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 12)
        label.textColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1)
        
        iv.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(16)
        }
        
        label.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(4)
            make.left.equalTo(iv.snp.right).offset(4)
            make.right.equalToSuperview().inset(12)
            
        }
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(named: "BackgroundColor")
        setupCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupCell(){
        contentView.addSubview(posterImage)
        contentView.addSubview(titlelabel)
        contentView.addSubview(genrelabel)
        contentView.addSubview(playView)
    }
    
    func setupConstraints(){
        posterImage.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(24)
            make.left.equalToSuperview().inset(24)
            make.height.equalTo(104)
            make.width.equalTo(71)
        }
        
        titlelabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(24)
            make.left.equalTo(posterImage.snp.right).offset(17)
            make.right.equalToSuperview().inset(24)
        }
        
        genrelabel.snp.makeConstraints { make in
            make.top.equalTo(titlelabel.snp.bottom).offset(8)
            make.left.equalTo(posterImage.snp.right).offset(17)
            make.right.equalTo(titlelabel)
        }
        
        playView.snp.makeConstraints { make in
            make.top.equalTo(genrelabel.snp.bottom).offset(24)
            make.left.equalTo(titlelabel)
        }
    }
    
    func setData(movie: Movie) {
        titlelabel.text = movie.name
        genrelabel.text = "\(movie.year) • \(movie.genres.first!.name) • \(movie.categories.first!.name)"
        posterImage.sd_setImage(with: URL(string: movie.poster_link))

    }
}
