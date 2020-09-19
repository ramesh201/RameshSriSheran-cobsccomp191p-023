//
//  LoginViewController.swift
//  NIBMCOVID19
//
//  Created by Ramesh Sheran on 8/22/20.
//  Copyright © 2020 Ramesh Sheran. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {

      // MARK: - Properties
      private let titleLabel: UILabel = {
          let label = UILabel()
          label.textColor = UIColor(white: 1, alpha: 0.8)
          label.font = UIFont(name: "Avenir-Light", size: 36)
          label.text = "NIBM Covid 19"
          
          return label
      }()
      
    @IBAction func btnBack(_ sender: UIButton) {

        //navigationController?.popToRootViewController(animated: true)
        
        self.dismiss(animated: true, completion: nil)
        
        let vc = FirstViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    let backScreenButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
        
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
      /*private lazy var emailContainerView: UIView = {
       guard let view = UIView().inputContainerView(image: UIImage(systemName: "first")!, textField: emailTextFiled)
            /*.inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextFiled)*/
          view.heightAnchor.constraint(equalToConstant: 50).isActive = true
          return view
      }()*/
      
      /*private lazy var passwordContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextFiled)
    
          view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //UIView().inpu
          return view
      }()*/
    
    //private lazy var passwordContainerView: UIView = {
    
        //UIView().inpu
          //return view
      //}()
    
    // guard let emailIcon = UIImage(systemName: "first") else { return UIImage() }
    
      /*private let emailTextFiled: UITextField = {
        
        

        return UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false,image:  UIImage(systemName: "first")!)
      }()
    
    
    
    
    private let passwordTextFiled: UITextField? = {
          return UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true,
image: UIImage(systemName: "first")!)
      }()*/
      
    private let emailField: UITextField = {
        
        let imageView = UIImageView(frame: CGRect(x: 8.0, y: 8.0, width: 24.0, height: 24.0))
        let image = UIImage(systemName: "pencil.circle")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        //imageView.backgroundColor = UIColor.red

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
        view.addSubview(imageView)
        
        let button = UITextField()
        button.placeholder = "Email"
        button.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = UIColor.systemGray
        button.leftViewMode = .always
        button.leftView = view
        //button.setupLeftImage(imageName:"first")
        /*button.setLeftView(image: UIImage.init(systemName: "first")!)*/
        //button.setLeftView(image: (UIImage(systemName: "first") ?? UIImage(systemName: "first"))!)
        return button
    }()
    
    private let passwordField: UITextField = {
        
        let imageView = UIImageView(frame: CGRect(x: 8.0, y: 8.0, width: 24, height: 24))
        let image = UIImage(systemName: "first")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        //imageView.backgroundColor = UIColor.red

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
        view.addSubview(imageView)
        
        let button = UITextField()
        button.placeholder = "Password"
        button.font = UIFont.boldSystemFont(ofSize: 20)
        button.isSecureTextEntry = true
        return button
    }()
    private let loginButton: AuthButtonUIButton = {
          let button = AuthButtonUIButton(type: .system)
          button.setTitle("Log In", for: .normal)
          button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
          button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
          return button
      }()
      
    func setupLeftImage(imageName:String){
      let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
      imageView.image = UIImage(systemName: imageName)
      let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
      imageContainerView.addSubview(imageView)
        emailField.leftView = imageContainerView
        emailField.leftViewMode = .always
        emailField.tintColor = .lightGray
    }
    
    
    let dontHaveAccountButton: UIButton = {
          let button = UIButton(type: .system)
          let attributedTitle = NSMutableAttributedString(string: "Want to use the app?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
          
          attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
          
          button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
          
          button.setAttributedTitle(attributedTitle, for: .normal)
          return button
      }()
      
      // MARK: - Lifecycale
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          configureUI()
      }
    
    // MARK: - Selectors
    
    @objc func handleSignIn() {
        guard let email = emailField.text else { return }
        
        guard let password = passwordField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Faild to log user with error \(error.localizedDescription)")
                return
            }
            
            let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
            
            //guard let controller = keyWindow?.rootViewController as? FirstViewController else { return }
            //controller.configure()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleShowSignUp() {
        let vc = SignupViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Helper Function
    
    func configureUI() {
        
        configureNavigationBar()
        
        view.backgroundColor = UIColor.darkGray
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        //emailField.setup
        //UIStackView(arrangedSubviews: <#T##[UIView]#>)
        let stack = UIStackView(arrangedSubviews: [/*emailContainerView,*/ /*passwordContainerView,*/ /*emailTextFiled,       passwordTextFiled,*/emailField,passwordField,loginButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 24
        
        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
        
        //view.addSubview(emailField)
        //view.addSubview(passwordTextFiled!)
        //view.addSubview(loginButton)
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FirstViewController {
            
            print(destination)
            /*destination.lblHeader = settingArray[(tblSettingList.indexPathForSelectedRow?.row)!].SettingSubtitle*/
            //destination.settingObj = settingArray[(tblSettingList.indexPathForSelectedRow?.row)!]
            
            //tblSettingList.deselectRow(at: tblSettingList.indexPathForSelectedRow!, animated: true)
            
        }
    }
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    
    /*override func viewWillAppear(_ animated: Bool) {
        Auth.auth().signIn(withEmail: "gametrainer2013@gmail.com", password: "iosapp") { [weak self] authResult, error in
            guard self != nil else { return }
          // ...
        }    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        Auth.auth().signIn(withEmail: "gametrainer2013@gmail.com", password: "iosapp") { [weak self] authResult, error in
            guard self != nil else { return }
          // ...
        } 
            //((user?.isAnonymous) != nil)
            //self.isLoggedin = (auth.currentUser != nil)
             _ = Auth.auth().addStateDidChangeListener { (auth, user) in
                 //((user?.isAnonymous) != nil)
                 //self.isLoggedin = (auth.currentUser != nil)
                  if (auth.currentUser?.isAnonymous != nil){
                      print("logged in")
                 }
                 else{
                  print("not logged in")
                     
                 }
             }
        }*/
    
      override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
      }
    
    }
    

