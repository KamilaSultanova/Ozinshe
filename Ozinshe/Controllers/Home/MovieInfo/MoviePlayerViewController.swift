//
//  MoviePlayerViewController.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 07.12.2023.
//

import UIKit
import SnapKit

class MoviePlayerViewController: UIViewController {
    
    lazy var descriptionLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 24)
        label.textColor = .white
        
  
        label.numberOfLines = 20
        

        return label
    }()
    
    lazy var fullDescriptButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        button.setTitle("FULL".localized(), for: .normal)
        button.contentHorizontalAlignment = .left
     
    
        return button
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        setdata()
        configure()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(fullDescriptButton)
        view.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        
        
        fullDescriptButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
        }
        
//        setdata()
//        configure()
    }
    
    var movie = Movie()
    
    func setdata(){
        
        descriptionLabel.text = movie.description
        fullDescriptButton.setTitle("FULL".localized(), for: .normal)
    }
    
    func configure(){
        if descriptionLabel.numberOfLines < 5  {
            fullDescriptButton.isHidden = true
            

        }
            fullDescriptButton.isHidden = false
            descriptionLabel.numberOfLines = 4
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
