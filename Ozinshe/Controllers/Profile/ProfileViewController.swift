//
//  ProfileViewController.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 18.11.2023.
//

import UIKit
import SnapKit
import Localize_Swift

class ProfileViewController: UIViewController, LanguageProtocol {
    
    
    let avatar: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Avatar")
        
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MY_PROFILE"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "FontColor")
        
        return label
    }()
    
    let emailLabel: UILabel = {
        
        let label = UILabel()
        label.text = "email"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        
        return label
    }()
    
    lazy var settingsView: UIView = {
        
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "ProfileTVColor")
        
        view.addSubview(personalDataButton)
        view.addSubview(passwordButton)
        view.addSubview(languageButton)
        view.addSubview(termsButton)
        view.addSubview(notificationButton)
        view.addSubview(DarkModeButton)
        
        personalDataButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(65)
        }
        
        passwordButton.snp.makeConstraints { make in
            make.top.equalTo(personalDataButton.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(65)
        }
        
        languageButton.snp.makeConstraints { make in
            make.top.equalTo(passwordButton.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(65)
        }
        
        termsButton.snp.makeConstraints { make in
            make.top.equalTo(languageButton.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(65)
        }
        
        notificationButton.snp.makeConstraints { make in
            make.top.equalTo(termsButton.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(65)
        }
        
        DarkModeButton.snp.makeConstraints { make in
            make.top.equalTo(notificationButton.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(65)
        }
        
        return view
    }()
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(named: "BackgroundColor")
        navigationItem.title = "PROFILE".localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "logout"), style: .plain, target:self, action: #selector(logoutBtn))

        setupUI()

    }
    
    @objc func logoutBtn(){
        print("Do you want to log out?")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        languageDidChange()
    }
    
    func languageDidChange() {
        if let label = personalDataButton.viewWithTag(1002) as? UILabel {
                label.text = "EDIT".localized()
            }
        if let label = languageButton.viewWithTag(1003) as? UILabel {
            if Localize.currentLanguage() == "en"{
                label.text = "English"
            }
            if Localize.currentLanguage() == "kk"{
                label.text = "Қазақша"
            }
            if Localize.currentLanguage() == "ru"{
                label.text = "Русский"
            }
        }
        if let button = personalDataButton.viewWithTag(1004) as? UIButton {
                button.setTitle("PERSONAL_DATA".localized(), for: .normal)
            }
        if let button = passwordButton.viewWithTag(1005) as? UIButton {
                button.setTitle("CHANGE_PASSWORD".localized(), for: .normal)
            }
        if let button = languageButton.viewWithTag(1006) as? UIButton {
                button.setTitle("LANGUAGE".localized(), for: .normal)
            }
        if let button = termsButton.viewWithTag(1007) as? UIButton {
                button.setTitle("TERM_&_CONDITIONS".localized(), for: .normal)
            }
        if let button = notificationButton.viewWithTag(1008) as? UIButton {
                button.setTitle("NOTIFICATIONS".localized(), for: .normal)
            }
        if let button = DarkModeButton.viewWithTag(1008) as? UIButton {
                button.setTitle("DARK_MODE".localized(), for: .normal)
            }
        titleLabel.text = "MY_PROFILE".localized()
        navigationItem.title = "PROFILE".localized()

        
    }
    
    func setupUI(){
        
        view.addSubview(avatar)
        view.addSubview(titleLabel)
        view.addSubview(emailLabel)
        view.addSubview(settingsView)
        
        avatar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(avatar.snp.bottom).offset(24)
            make.centerX.equalTo(avatar)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalTo(avatar)
        }
        
        settingsView.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    //MARK: buttonsUI
    
    lazy var personalDataButton = {
        
        let view = UIView()
        let button = UIButton()
        let lineView = UIView()
        let iv = UIImageView()
        let label = UILabel()
        
        
        button.setTitle("PERSONAL_DATA".localized(), for: .normal)
        button.setTitleColor(UIColor(named: "ProfileColorSet"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.contentHorizontalAlignment = .left
        button.tag = 1004
        
        lineView.backgroundColor = UIColor(named: "ViewLineColor")
        
        iv.image = UIImage(named: "arrow")
        
        label.tag = 1002
        label.text = "EDIT".localized()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        
        view.addSubview(lineView)
        view.addSubview(button)
        view.addSubview(iv)
        view.addSubview(label)
        
        button.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.centerY.equalToSuperview()
        }
                
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        iv.snp.makeConstraints { make in
            make.size.equalTo(16)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(iv.snp.left).offset(-8)
        }
    
        return view
    }()
    
    lazy var passwordButton = {
        
        let view = UIView()
        let button = UIButton()
        let lineView = UIView()
        let iv = UIImageView()
        
        button.setTitle("CHANGE_PASSWORD".localized(), for: .normal)
        button.setTitleColor(UIColor(named: "ProfileColorSet"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.contentHorizontalAlignment = .left
        button.tag = 1005
        
        lineView.backgroundColor = UIColor(named: "ViewLineColor")
        
        iv.image = UIImage(named: "arrow")
        
        view.addSubview(lineView)
        view.addSubview(button)
        view.addSubview(iv)

        
        button.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.centerY.equalToSuperview()
        }
                
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        iv.snp.makeConstraints { make in
            make.size.equalTo(16)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    
        return view
    }()
    
    lazy var languageButton = {
        
        let view = UIView()
        let button = UIButton()
        let lineView = UIView()
        let iv = UIImageView()
        let label = UILabel()
        
        button.setTitle("LANGUAGE".localized(), for: .normal)
        button.setTitleColor(UIColor(named: "ProfileColorSet"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(languageShow), for: .touchUpInside)
        button.tag = 1006
        
        lineView.backgroundColor = UIColor(named: "ViewLineColor")
        
        iv.image = UIImage(named: "arrow")
        
        
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        label.tag = 1003
        label.text = "Select"
        
        view.addSubview(lineView)
        view.addSubview(button)
        view.addSubview(iv)
        view.addSubview(label)
        
        button.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.centerY.equalToSuperview()
        }
                
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        iv.snp.makeConstraints { make in
            make.size.equalTo(16)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(iv.snp.left).offset(-8)
        }
    
        return view
    }()
    
    lazy var termsButton = {
        
        let view = UIView()
        let button = UIButton()
        let lineView = UIView()
        let iv = UIImageView()
        
        button.setTitle("TERM_&_CONDITIONS".localized(), for: .normal)
        button.setTitleColor(UIColor(named: "ProfileColorSet"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(termsClicked), for: .touchUpInside)
        button.tag = 1007
        
        
        lineView.backgroundColor = UIColor(named: "ViewLineColor")
        
        iv.image = UIImage(named: "arrow")
        
        view.addSubview(lineView)
        view.addSubview(button)
        view.addSubview(iv)

        
        button.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.centerY.equalToSuperview()
        }
                
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        iv.snp.makeConstraints { make in
            make.size.equalTo(16)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    
        return view
    }()
    
    lazy var notificationButton = {
        
        let view = UIView()
        let button = UIButton()
        let lineView = UIView()
        let notificationSwitch = UISwitch()
        
        button.setTitle("NOTIFICATIONS".localized(), for: .normal)
        button.setTitleColor(UIColor(named: "ProfileColorSet"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.contentHorizontalAlignment = .left
        button.tag = 1008
        
        lineView.backgroundColor = UIColor(named: "ViewLineColor")
        notificationSwitch.onTintColor = UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1)
                
        view.addSubview(lineView)
        view.addSubview(button)
        view.addSubview(notificationSwitch)
 
        
        button.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.centerY.equalToSuperview()
        }
                
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        notificationSwitch.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        return view
    }()
    
    lazy var DarkModeButton = {
        
        let view = UIView()
        let button = UIButton()
        let lineView = UIView()
        let modeSwitch = UISwitch()
        
        button.setTitle("DARK_MODE".localized(), for: .normal)
        button.setTitleColor(UIColor(named: "ProfileColorSet"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.contentHorizontalAlignment = .left
        button.tag = 1009
        
        modeSwitch.onTintColor = UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1)
                
        view.addSubview(button)
        view.addSubview(modeSwitch)
 
        
        button.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        modeSwitch.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        return view
    }()

//MARK: Buttons actions
    @objc func languageShow(){
        let languageVC = LanguageViewController()
        languageVC.modalPresentationStyle = .overFullScreen
        
        languageVC.delegate = self
        
        present(languageVC, animated: true)
    }
    
    @objc func termsClicked() {
        let termsVC = TermsViewController()
        
        navigationController?.show(termsVC, sender: self)
    }
    

}
