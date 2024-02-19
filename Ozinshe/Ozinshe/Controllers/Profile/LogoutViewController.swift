//
//  LogoutViewController.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 22.11.2023.
//

import UIKit

class LogoutViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var viewTranslation = CGPoint(x: 0, y: 0)
    
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
    let logoutLabel = {
        let label = UILabel()
        label.text = "EXIT".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "FontColor")
            
        return label
    }()
    
    let questionLabel = {
        let label = UILabel()
        label.text = "CONFIRMATION".localized()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)

        
        return label
    }()
    
    let yesButton = {
        let button = UIButton()
        button.setTitle("YES_BUTTON".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.5, green: 0.18, blue: 0.99, alpha: 1)
        button.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        
        return button
    }()
        
    let noButton = {
        let button = UIButton()
        button.setTitle("NO_BUTTON".localized(), for: .normal)
        if button.isSelected {
            button.setTitleColor(.white, for: .selected)
            button.backgroundColor = UIColor(red: 0.5, green: 0.18, blue: 0.99, alpha: 1)
        }
            button.setTitleColor(UIColor(red: 0.33, green: 0.08, blue: 0.78, alpha: 1), for: .normal)
        button.backgroundColor = UIColor(named: "TabBarColor")
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        
        return button
    }()
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.backgroundColor = .black.withAlphaComponent(0.3)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
        setupUI()
        setupConstraints()
    }
    
    func setupUI(){
        view.addSubview(backgroundView)
        view.addSubview(lineView)
        view.addSubview(logoutLabel)
        view.addSubview(questionLabel)
        view.addSubview(yesButton)
        view.addSubview(noButton)
    }
    
    func setupConstraints(){
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
            
        
        logoutLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(32)
            make.horizontalEdges.equalTo(24)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(logoutLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(logoutLabel)
        }
        
        yesButton.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        noButton.snp.makeConstraints { make in
            make.top.equalTo(yesButton.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
    }
    
    @objc func dismissView(){
        self.dismiss(animated: true)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool{
        if (touch.view?.isDescendant(of: self.backgroundView))!{
            return false
        }
            return true

    }
    
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
        switch sender.state {
            case .changed:
                viewTranslation = sender.translation(in: view)
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.backgroundView.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
                })
            case .ended:
                if viewTranslation.y < 100 {
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        self.backgroundView.transform = .identity
                    })
                } else {
                    dismiss(animated: true, completion: nil)
                }
            default:
                break
        }
    }
     
   @objc func logOut(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "accessToken")
    
        let rootVC = UINavigationController(rootViewController: SignInViewController())

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
        appDelegate.window?.makeKeyAndVisible()
    }
    
}


