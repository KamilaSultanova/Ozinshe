//
//  SignUpViewController.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 26.11.2023.
//

import UIKit
import SnapKit
import SVProgressHUD
import SwiftyJSON
import Alamofire

class SignUpViewController: UIViewController {
    
    let signUpLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "FontColor")
        label.text = "REGISTER".localized()
        
        return label
    }()
    
    let infoLabel = {
        
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        label.textColor = UIColor(red: 0.42, green: 0.45, blue: 0.5, alpha: 1)
        label.text = "FILL_IN".localized()
        
        return label
    }()
    
    lazy var textfield1 = {
        let tf = TextFieldWithPadding()
        let emailIV = UIImageView()
        
        tf.placeholder = "ENTER_EMAIL".localized()
        tf.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        tf.backgroundColor = UIColor(named: "TabBarColor")
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        tf.addTarget(self, action: #selector(textEditDidBegin), for: .editingDidBegin)
        tf.addTarget(self, action: #selector(textEditDidEnd), for: .editingDidEnd)
        tf.keyboardType = .emailAddress
        
        emailIV.image = UIImage(named: "Message")
        
        tf.addSubview(emailIV)
        
        emailIV.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.size.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        return tf
    }()
    
    lazy var textfield2 = {
        let tf = TextFieldWithPadding()
        let passwordIV = UIImageView()
        
        tf.placeholder = "ENTER_PASSWORD".localized()
        tf.backgroundColor = UIColor(named: "TabBarColor")
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        tf.addTarget(self, action: #selector(textEditDidBegin), for: .editingDidBegin)
        tf.addTarget(self, action: #selector(textEditDidEnd), for: .editingDidEnd)
        tf.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        tf.isSecureTextEntry = true
        
        passwordIV.image = UIImage(named: "Password")
        
        tf.addSubview(passwordIV)
        
        passwordIV.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.size.equalTo(20)
            make.centerY.equalToSuperview()
        }
      
        return tf
    }()
    
    lazy var textfield3 = {
        let tf = TextFieldWithPadding()
        let passwordIV = UIImageView()
        
        tf.placeholder = "ENTER_PASSWORD".localized()
        tf.backgroundColor = UIColor(named: "TabBarColor")
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        tf.addTarget(self, action: #selector(textEditDidBegin), for: .editingDidBegin)
        tf.addTarget(self, action: #selector(textEditDidEnd), for: .editingDidEnd)
        tf.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        tf.isSecureTextEntry = true
        
        passwordIV.image = UIImage(named: "Password")
        
        tf.addSubview(passwordIV)
        
        passwordIV.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.size.equalTo(20)
            make.centerY.equalToSuperview()
        }
      
        return tf
    }()
    
    let showButton1 = {
        let showBtn = UIButton()
        showBtn.setImage(UIImage(named: "Show"), for: .normal)
        showBtn.addTarget(self, action: #selector(showPassword), for: .touchDown)
 
        return showBtn
    }()
    
    let showButton2 = {
        let showBtn = UIButton()
        showBtn.setImage(UIImage(named: "Show"), for: .normal)
        showBtn.addTarget(self, action: #selector(showPassword), for: .touchDown)
        
        return showBtn
    }()
    
    
    lazy var tfView = {
        
        let view = UIView()
        let emailLabel = UILabel()
        let pwdLabel = UILabel()
        let repeatPwdLabel = UILabel()
        
        emailLabel.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        emailLabel.textColor = UIColor(named: "FontColor")
        emailLabel.text = "Email"
        
        pwdLabel.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        pwdLabel.textColor = UIColor(named: "FontColor")
        pwdLabel.text = "ENTER_PASSWORD".localized()
        
        repeatPwdLabel.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        repeatPwdLabel.textColor = UIColor(named: "FontColor")
        repeatPwdLabel.text = "REPEAT_PASSWORD".localized()
        
        
        view.addSubview(emailLabel)
        view.addSubview(textfield1)
        view.addSubview(pwdLabel)
        view.addSubview(repeatPwdLabel)
        view.addSubview(textfield2)
        view.addSubview(textfield3)
        
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        textfield1.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(56)
        }
        
        pwdLabel.snp.makeConstraints { make in
            make.top.equalTo(textfield1.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
        }
        
        textfield2.snp.makeConstraints { make in
            make.top.equalTo(pwdLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(56)
        }
        
        repeatPwdLabel.snp.makeConstraints { make in
            make.top.equalTo(textfield2.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
        }
        
        textfield3.snp.makeConstraints { make in
            make.top.equalTo(repeatPwdLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(56)
        }
        
        return view
        
    }()
    
    let saveButton = {
        let button = UIButton()
        button.setTitle("REGISTER".localized(), for: .normal)
        button.backgroundColor = UIColor(red: 0.5, green: 0.18, blue: 0.99, alpha: 1)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        
        return button
    }()
    
    let questionLabel = {
        
        let label = UILabel()
        label.textColor = UIColor(red: 0.42, green: 0.45, blue: 0.5, alpha: 1)
        label.text = "HAVE_ACCOUNT".localized()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textAlignment = .right

        
        return label
    }()
    
    let logInBtn = {
        let button = UIButton()
        button.setTitleColor(UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1), for: .normal)
        button.setTitle("LOG_IN".localized(), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        button.addTarget(self, action: #selector(logIn), for: .touchDown)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BackgroundColor")

        setupUI()
        setupConstraints()
        hideKeyboardWhenTapped()
    }
    
    
    func setupUI(){
        view.addSubview(signUpLabel)
        view.addSubview(infoLabel)
        view.addSubview(tfView)
        view.addSubview(saveButton)
        view.addSubview(questionLabel)
        view.addSubview(logInBtn)
        view.addSubview(showButton1)
        view.addSubview(showButton2)
    }
    
    func setupConstraints(){
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel.snp.bottom)
            make.horizontalEdges.equalTo(signUpLabel)
        }
        
        tfView.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(263)
        }
        
        showButton1.snp.makeConstraints { make in
            make.right.equalTo(textfield2.snp.right)
            make.centerY.equalTo(textfield2)
            make.height.equalTo(60)
            make.width.equalTo(50)
        }
        
        showButton2.snp.makeConstraints { make in
            make.right.equalTo(textfield3.snp.right)
            make.centerY.equalTo(textfield3)
            make.height.equalTo(60)
            make.width.equalTo(50)
        }

        saveButton.snp.makeConstraints { make in
            make.top.equalTo(tfView.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }

        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.bottom).offset(24)
            make.right.equalTo(logInBtn.snp.left).offset(-4)

        }

        logInBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(24)
            make.centerY.equalTo(questionLabel)

        }
    }
        
        @objc func textEditDidBegin(_ sender: TextFieldWithPadding) {
            sender.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
          
        }
        
        
        @objc func textEditDidEnd(_ sender: TextFieldWithPadding) {
            sender.layer.borderColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1.00).cgColor
            
        }
        
    @objc func showPassword(sender: UIButton) {
        if sender.isEqual(showButton1) {
            textfield2.isSecureTextEntry = !textfield2.isSecureTextEntry
        } else if sender.isEqual(showButton2) {
            textfield3.isSecureTextEntry = !textfield3.isSecureTextEntry
        }
    }
    
    @objc func logIn(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func signUp(_ sender: Any) {
        let email = textfield1.text!
        let password = textfield2.text!
        
        SVProgressHUD.show()
        
        let parameters = [
            "email": email,
            "password":password
        ]
        
        AF.request(Urls.SIGN_UP_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { [self] response in
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                if let token = json["accessToken"].string {
                    Storage.sharedInstance.accessToken = token
                    UserDefaults.standard.set(token, forKey: "accessToken")
                    self.startApp()
                } else {
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                }
            } else {
                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = response.response?.statusCode {
                    ErrorString = ErrorString + " \(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
        }
    }
    
    
    func startApp(){
        let tabBarVC = TabBarController()
        
        tabBarVC.modalPresentationStyle = .fullScreen
        self.present(tabBarVC, animated: true )
        
    }

    func hideKeyboardWhenTapped(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
}
