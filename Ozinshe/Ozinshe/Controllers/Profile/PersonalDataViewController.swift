//
//  PersonalDataViewController.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 23.11.2023.
//

import UIKit
import SnapKit
import SVProgressHUD
import SwiftyJSON
import Alamofire

class PersonalDataViewController: UIViewController {
    
    lazy var infoView = {
        
        let view = UIView()
        
        
        view.addSubview(nameView)
        view.addSubview(emailView)
        view.addSubview(phoneView)
        view.addSubview(birthdayView)
        
        
        nameView.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.width.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        emailView.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.width.equalToSuperview()
            make.top.equalTo(nameView.snp.bottom)
        }
        
        phoneView.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.width.equalToSuperview()
            make.top.equalTo(emailView.snp.bottom)
        }
        
        birthdayView.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.width.equalToSuperview()
            make.top.equalTo(phoneView.snp.bottom)
        }
        
        
        return view
        
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
    
    lazy var nameView = {
        
        let view = UIView()
        let label = UILabel()
        let tf = UITextField()
        let lineView = UIView()
        
        label.text = "NAME".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        
        tf.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        tf.textColor = UIColor(named: "FontColor")
        tf.tag = 1001
        
        lineView.backgroundColor = UIColor(named: "ViewLineColor")
        
        view.addSubview(label)
        view.addSubview(tf)
        view.addSubview(lineView)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.horizontalEdges.equalToSuperview()
        }
        
        tf.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(8)
            make.height.equalTo(30)
            make.width.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.width.equalToSuperview()
        }
        
        return view
        
    }()
    
    lazy var emailView = {
        
        let view = UIView()
        let label = UILabel()
        let tf = UITextField()
        let lineView = UIView()
        
        label.text = "Email"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        
        tf.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        tf.textColor = UIColor(named: "FontColor")
        tf.tag = 1002
        
        lineView.backgroundColor = UIColor(named: "ViewLineColor")
        
        view.addSubview(label)
        view.addSubview(tf)
        view.addSubview(lineView)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.horizontalEdges.equalToSuperview()
        }
        
        tf.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(8)
            make.height.equalTo(30)
            make.width.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.width.equalToSuperview()
        }
        
        return view
        
    }()
    
    lazy var phoneView = {
        
        let view = UIView()
        let label = UILabel()
        let tf = UITextField()
        let lineView = UIView()
        
        label.text = "PHONE".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        
        tf.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        tf.textColor = UIColor(named: "FontColor")
        tf.tag = 1003
        
        lineView.backgroundColor = UIColor(named: "ViewLineColor")
        
        view.addSubview(label)
        view.addSubview(tf)
        view.addSubview(lineView)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.horizontalEdges.equalToSuperview()
        }
        
        tf.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(8)
            make.height.equalTo(30)
            make.width.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.width.equalToSuperview()
        }
        
        return view
        
    }()
    
    lazy var birthdayView = {
        
        let view = UIView()
        let label = UILabel()
        let tf = UITextField()
        let lineView = UIView()
        
        label.text = "BIRTHDAY".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        
        tf.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        tf.textColor = UIColor(named: "FontColor")
        tf.tag = 1004
        
        lineView.backgroundColor = UIColor(named: "ViewLineColor")
        
        view.addSubview(label)
        view.addSubview(tf)
        view.addSubview(lineView)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.horizontalEdges.equalToSuperview()
        }
        
        tf.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(8)
            make.height.equalTo(30)
            make.width.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.width.equalToSuperview()
        }
        
        return view
        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BackgroundColor")
        navigationItem.title = "PERSONAL_DATA".localized()
        let backButton = UIBarButtonItem(image: UIImage(named: "BackButton"), style: .plain, target: self, action: #selector(backButtonClicked))
        backButton.tintColor = UIColor(named: "arrowColor")
        navigationItem.leftBarButtonItem = backButton
        
        tabBarController?.tabBar.isHidden = true
        
        setupUI()
        hideKeyboardWhenTapped()
        loadUserData()
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
    func setupUI(){
        
        view.addSubview(infoView)
        view.addSubview(saveButton)
        
        infoView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalTo(saveButton.snp.top)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(56)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
    }
    
    func loadUserData() {
        SVProgressHUD.show()

        let headers: HTTPHeaders = ["Authorization": "Bearer \(Storage.sharedInstance.accessToken)"]

        AF.request(Urls.GET_PROFILE, method: .get, headers: headers).responseData { response in
            SVProgressHUD.dismiss()

            var resultString = ""
            if let data = response.data{
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }

            if response.response?.statusCode == 200{
                let json = JSON(response.data!)
                print("JSON: \(json)")


                if let email = json["user"]["email"].string {
                    if let emailTF = self.emailView.viewWithTag(1002) as? UITextField{
                        emailTF.text = email
                    }
                }
                if let name = json["name"].string {
                    if let nameTF = self.nameView.viewWithTag(1001) as? UITextField{
                        nameTF.text = name
                    }
                }
                if let phone = json["phoneNumber"].string {
                    if let phoneTF = self.phoneView.viewWithTag(1003) as? UITextField{
                        phoneTF.text = phone
                    }
                }
                if let birthDate = json["birthDate"].string {
                    if let birthTF = self.birthdayView.viewWithTag(1004) as? UITextField{
                        birthTF.text = birthDate
                    }
                }
            } else {
                SVProgressHUD.showError(withStatus: "Failed")

            }
        }
    }
    
    @objc func saveButtonClicked(_ sender: Any) {
        var name = ""
        var email = ""
        var phone = ""
        var birthDate = ""
        
        if let nameTF = self.nameView.viewWithTag(1001) as? UITextField{
            name = nameTF.text!
        }
        if let emailTF = self.emailView.viewWithTag(1002) as? UITextField{
            email = emailTF.text!
        }
        if let phoneTF = self.phoneView.viewWithTag(1003) as? UITextField{
            phone = phoneTF.text!
        }

        let language = ""
        let id: Int = 0

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let birthTF = self.birthdayView.viewWithTag(1004) as? UITextField{
            let date = dateFormatter.date(from: birthTF.text ?? "") ?? Date()
           birthDate = dateFormatter.string(from: date)
        }
       
        SVProgressHUD.show()

        let parameters: [String: Any] = [
            "birthDate": birthDate,
            "id": id,
            "language": language,
            "name": name,
            "phoneNumber": phone,
            //              "user": [
            //                    "email": email
            //                ]
        ]

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]

        AF.request(Urls.UPDATE_PROFILE, method: .put,parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData{
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

                if let email = json["user"]["email"].string {
                    if let emailTF = self.emailView.viewWithTag(1002) as? UITextField{
                        emailTF.text = email
                    }
                }
                if let name = json["name"].string {
                    if let nameTF = self.nameView.viewWithTag(1001) as? UITextField{
                        nameTF.text = name
                    }
                }
                if let phone = json["phoneNumber"].string {
                    if let phoneTF = self.phoneView.viewWithTag(1003) as? UITextField{
                        phoneTF.text = phone
                    }
                }
                if let birthDate = json["birthDate"].string {
                    if let birthTF = self.birthdayView.viewWithTag(1004) as? UITextField{
                        birthTF.text = birthDate
                    }
                }

                self.navigationController?.popViewController(animated: true)

            }else {
                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = response.response?.statusCode {
                    ErrorString = ErrorString + " \(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
        }
    }

}
