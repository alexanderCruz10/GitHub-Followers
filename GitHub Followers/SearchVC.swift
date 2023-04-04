//
//  SearchVC.swift
//  GitHub Followers
//
//  Created by Alex Cruz on 2023-04-03.
//

import UIKit

class SearchVC: UIViewController {
    
    //MARK: Variables
    let logoImageView = UIImageView()
    let usernameTF = GFTextField()
    let callToActionButton = GFButton(backgroundColour: .systemGreen, title: "Get Followers")
    
    var isUsernameEntered: Bool{ return !usernameTF.text!.isEmpty}
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGensture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: To dismiss keyboard 
    func createDismissKeyboardTapGensture(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: Configuration
    func configureLogoImageView(){
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(imageLiteralResourceName: "gh-logo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField(){
        view.addSubview(usernameTF)
        
        usernameTF.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTF.topAnchor.constraint(equalTo:logoImageView.bottomAnchor, constant: 48),
            usernameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTF.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configureCallToActionButton(){
        view.addSubview(callToActionButton)
        
        callToActionButton.addTarget(self, action: #selector(pushFollowersVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    //MARK: Selectors
    @objc func pushFollowersVC(){
        guard isUsernameEntered else{
            presentGFAlertOnMainThread(title: "Empty username", message: "Please enter a username. We need to know who to look for 😃", buttonTitle: "Ok")
            return
        }
        let followerListVC = FollowerListVC()
        followerListVC.username = usernameTF.text
        followerListVC.title = usernameTF.text
        navigationController?.pushViewController(followerListVC, animated: true)
    }
}

//MARK: Extension
extension SearchVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersVC()
        return true
    }
}
