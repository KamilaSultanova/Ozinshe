//
//  PasswordViewController.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 22.11.2023.
//

import UIKit
import SnapKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class PasswordViewController: UIViewController {
    
    let passwordLabel = {
        
        let label = UILabel()
        label.text = "PASSWORD".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "FontColor")
        
        return label
    }()
    
    let textfield1 = {
        let tf = TextFieldWithPadding()
        let passwordIV = UIImageView()
        
        tf.placeholder = "ENTER_PASSWORD".localized()
        tf.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        tf.addTarget(self, action: #selector(textEditDidBegin), for: .editingDidBegin)
        tf.addTarget(self, action: #selector(textEditDidEnd), for: .editingDidEnd)
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
    
    let repeatLabel = {
        
        let label = UILabel()
        label.text = "REPEAT_PASSWORD".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "FontColor")
        
        return label
    }()
    
    let textfield2 = {
        let tf = TextFieldWithPadding()
        let passwordIV = UIImageView()
        
        tf.placeholder = "ENTER_PASSWORD".localized()
        tf.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        tf.addTarget(self, action: #selector(textEditDidBegin), for: .editingDidBegin)
        tf.addTarget(self, action: #selector(textEditDidEnd), for: .editingDidEnd)
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
    
    
    
    let saveButton = {
        let button = UIButton()
        
        button.setTitle("SAVE_BUTTON".localized(), for: .normal)
        button.backgroundColor = UIColor(red: 0.5, green: 0.18, blue: 0.99, alpha: 1)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BackgroundColor")
        navigationItem.title = "PASSWORD_PAGE".localized()
        let backButton = UIBarButtonItem(image: UIImage(named: "BackButton"), style: .plain, target: self, action: #selector(backButtonClicked))
        backButton.tintColor = UIColor(named: "arrowColor")
        navigationItem.leftBarButtonItem = backButton

        
        tabBarController?.tabBar.isHidden = true
        
        setupUI()
        
        hideKeyboardWhenTapped()
    }
    
    func setupUI(){
        
        view.addSubview(passwordLabel)
        view.addSubview(textfield1)
        view.addSubview(textfield2)
        view.addSubview(repeatLabel)
        view.addSubview(saveButton)
        view.addSubview(showButton1)
        view.addSubview(showButton2)
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(21)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        textfield1.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(passwordLabel)
            make.height.equalTo(56)
        }
        
        repeatLabel.snp.makeConstraints { make in
            make.top.equalTo(textfield1.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        textfield2.snp.makeConstraints { make in
            make.top.equalTo(repeatLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(repeatLabel)
            make.height.equalTo(56)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(56)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        showButton1.snp.makeConstraints { make in
            make.right.equalTo(textfield1.snp.right)
            make.centerY.equalTo(textfield1)
            make.height.equalTo(60)
            make.width.equalTo(50)
        }
        
        showButton2.snp.makeConstraints { make in
            make.right.equalTo(textfield2.snp.right)
            make.centerY.equalTo(textfield2)
            make.height.equalTo(60)
            make.width.equalTo(50)
        }
    }
    
    
    @objc func backButtonClicked(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    func hideKeyboardWhenTapped(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }

    @objc func textEditDidBegin(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
    }
    
    
    @objc func textEditDidEnd(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1.00).cgColor
    }
    
    
    @objc func showPassword(sender: UIButton) {
        if sender.isEqual(showButton1) {
            textfield1.isSecureTextEntry = !textfield1.isSecureTextEntry
        } else if sender.isEqual(showButton2) {
            textfield2.isSecureTextEntry = !textfield2.isSecureTextEntry
        }
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        
        
        if textfield1.text! == textfield2.text!{
            
            let password = textfield2.text!
            
            let parameters = [
                "password":password
            ]
            
            SVProgressHUD.show()
            
            let headers : HTTPHeaders = ["Authorization": "Bearer \(Storage.sharedInstance.accessToken)"]
            
            AF.request(Urls.CHANGE_PASSWORD, method: .put,parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData{
                response in
                
                SVProgressHUD.dismiss()
                var resultString = ""
                if let data = response.data{
                    resultString = String(data: data, encoding: .utf8)!
                    print(resultString)
                }
                
                if response.response?.statusCode == 200{
                    let json = JSON(response.data!)
                    print("JSON: \(json)")
                    
                    self.textfield2.text = password
                    self.navigationController?.popViewController(animated: true)
                    
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
        else{
            SVProgressHUD.showError(withStatus: "WRONG_PASSWORD".localized())
        }
    }
}


