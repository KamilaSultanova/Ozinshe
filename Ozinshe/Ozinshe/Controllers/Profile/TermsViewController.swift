//
//  TermsViewController.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 21.11.2023.
//

import UIKit

class TermsViewController: UIViewController {
    
    let text = {
        let textV = UITextView()
        
        textV.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        
        return textV
        
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BackgroundColor")
        navigationItem.title = "TERM_&_CONDITIONS".localized()
        let backButton = UIBarButtonItem(image: UIImage(named: "BackButton"), style: .plain, target: self, action: #selector(backButtonClicked))
        backButton.tintColor = UIColor(named: "arrowColor")
        navigationItem.leftBarButtonItem = backButton
        
        view.addSubview(text)
        
        text.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        

    }
    
    @objc func backButtonClicked(){
        navigationController?.popToRootViewController(animated: true)
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
