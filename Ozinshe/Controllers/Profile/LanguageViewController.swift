//
//  LanguageViewController.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 21.11.2023.
//

import UIKit
import SnapKit
import Localize_Swift

protocol LanguageProtocol{
    func languageDidChange()
}

class LanguageViewController: UIViewController , UIGestureRecognizerDelegate{
    
   
    
    var languageArray = [["English", "en"], ["Қазақша", "kk"], ["Русский", "ru"]]
    
    var delegate: LanguageProtocol?
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "TabBarColor")
        view.layer.cornerRadius = 32
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return view
    }()
    
    let lineView: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1)
        
        return line
    }()
    let languageLabel = {
        
        let label = UILabel()
        label.text = "LANGUAGE".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "FontColor")
        
        return label
    }()
    
    
    lazy var tableview = {

        let tv = UITableView()

        tv.dataSource = self
        tv.delegate = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        

        return tv
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black.withAlphaComponent(0.3)
        
        setupUI()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    func setupUI(){
        view.addSubview(backgroundView)
        view.addSubview(lineView)
        view.addSubview(tableview)
        view.addSubview(languageLabel)
        

        
        backgroundView.snp.makeConstraints { make in
            make.height.equalTo(303)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()

        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(5)
            make.width.equalTo(65)
            make.top.equalTo(backgroundView.snp.top).inset(21)
            make.centerX.equalToSuperview()
        }
        
        tableview.snp.makeConstraints { make in
            make.top.equalTo(languageLabel.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        
        languageLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(32)
            make.horizontalEdges.equalTo(24)
        }
    }
    
    @objc func dismissView(){
        self.dismiss(animated: true)
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool{
        if (touch.view?.isDescendant(of: tableview))!{
            return false
        }
            return true
        
    }

}

extension LanguageViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let label = UILabel()
        label.text = languageArray[indexPath.row][0]
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        label.textColor = UIColor(named: "FontColor")
        
        let line = UIView()
        line.backgroundColor = UIColor(named: "viewLineColor")
        
        let checkImageView = UIImageView()
        if Localize.currentLanguage() == languageArray[indexPath.row][1]{
            checkImageView.image = UIImage(named: "Check")
        }else{
            checkImageView.image = nil
        }

        cell.addSubview(label)
        cell.addSubview(line)
        cell.addSubview(checkImageView)
       
        
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(24)
        }
        
        line.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
        
        checkImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.centerY.equalTo(label)
            make.right.equalToSuperview().inset(24)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Localize.setCurrentLanguage(languageArray[indexPath.row][1])
        delegate?.languageDidChange()
        
        print("Selected language: \(Localize.currentLanguage())")
        dismiss(animated: true)
        
    }
    
}
