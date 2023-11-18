//
//  FavoritesViewController.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 18.11.2023.
//

import UIKit
import SnapKit

class FavoritesViewController: UIViewController {
    
    
    lazy var tableview: UITableView = {
        
        let tv = UITableView()
        
        tv.dataSource = self
        tv.delegate = self
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BackgroundColor")
        setupUI()
        
//        for family in UIFont.familyNames{
//            print("Family: \(family)")
//            for name in UIFont.fontNames(forFamilyName: family){
//                print("   - \(name)")
//            }
//        }
}
    
    func setupUI(){
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

 //MARK: UITableViewDelegate, UITableViewDataSource

extension FavoritesViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MovieTableViewCell()
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
    
    
}
