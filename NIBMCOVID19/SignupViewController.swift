

import UIKit
import Firebase
import GeoFire
import FirebaseAuth

class SignupViewController: UIViewController {
    // MARK: - Properties
    
    private var location = LocationHandler.shared.locationManager.location
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "NIBM Covid 19"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        
        return label
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextFiled )
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var fullNameContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: fullNameTextFiled )
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextFiled)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var accountTypeContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_account_box_white_2x"), segentedControl: accountTypeSegmentedControl)
        view.heightAnchor.constraint(equalToConstant: 80).isActive = true
        return view
    }()
    
    
    
    private let fullNameTextFiled: UITextField = {
        /*return UITextField().textField(withPlaceholder: "Full Name", isSecureTextEntry: false,image: (UIImage(systemName: "first") ?? UIImage(systemName: "first"))!)*/
        
        let imageView = UIImageView(frame: CGRect(x: 8.0, y: 8.0, width: 24.0, height: 24.0))
        let image = UIImage(systemName: "pencil.circle")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        //imageView.backgroundColor = UIColor.red
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
        view.addSubview(imageView)
        
        let button = UITextField()
        button.placeholder = "Full Name"
        button.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = UIColor.systemGray
        button.leftViewMode = .always
        button.leftView = view
        //button.setupLeftImage(imageName:"first")
        /*button.setLeftView(image: UIImage.init(systemName: "first")!)*/
        //button.setLeftView(image: (UIImage(systemName: "first") ?? UIImage(systemName: "first"))!)
        return button
    }()
    private let addressTextFiled: UITextField = {
        /*return UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false,image: (UIImage(systemName: "first") ?? UIImage(systemName: "first"))!)*/
        
        let imageView = UIImageView(frame: CGRect(x: 8.0, y: 8.0, width: 24.0, height: 24.0))
        let image = UIImage(systemName: "pencil.circle")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        //imageView.backgroundColor = UIColor.red
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
        view.addSubview(imageView)
        
        let button = UITextField()
        button.placeholder = "Address"
        button.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = UIColor.systemGray
        button.leftViewMode = .always
        button.leftView = view
        //button.setupLeftImage(imageName:"first")
        /*button.setLeftView(image: UIImage.init(systemName: "first")!)*/
        //button.setLeftView(image: (UIImage(systemName: "first") ?? UIImage(systemName: "first"))!)
        return button
    }()
    
    private let emailTextFiled: UITextField = {
        /*return UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false,image: (UIImage(systemName: "first") ?? UIImage(systemName: "first"))!)*/
        
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
    
    private let passwordTextFiled: UITextField = {
        /*return UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true,image: (UIImage(systemName: "first") ?? UIImage(systemName: "first"))!)*/
        
        let imageView = UIImageView(frame: CGRect(x: 8.0, y: 8.0, width: 24.0, height: 24.0))
        let image = UIImage(systemName: "pencil.circle")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        //imageView.backgroundColor = UIColor.red
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
        view.addSubview(imageView)
        
        let button = UITextField()
        button.isSecureTextEntry = true
        button.placeholder = "Password"
        button.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = UIColor.systemGray
        button.leftViewMode = .always
        button.leftView = view
        //button.setupLeftImage(imageName:"first")
        /*button.setLeftView(image: UIImage.init(systemName: "first")!)*/
        //button.setLeftView(image: (UIImage(systemName: "first") ?? UIImage(systemName: "first"))!)
        return button
    }()
    
    private let studentEmpCodeTextFiled: UITextField = {
        
        let imageView = UIImageView(frame: CGRect(x: 8.0, y: 8.0, width: 24.0, height: 24.0))
        let image = UIImage(systemName: "pencil.circle")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        //imageView.backgroundColor = UIColor.red
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
        view.addSubview(imageView)
        
        let button = UITextField()
        button.placeholder = "Student Index / Emp Code"
        button.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = UIColor.systemGray
        button.leftViewMode = .always
        button.leftView = view
       
        return button
    }()
    
    private let accountTypeSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Student", "Academic","Non-Academic"])
        sc.backgroundColor = .backgroundColor
        sc.tintColor = UIColor(white: 1, alpha: 0.87)
        sc.selectedSegmentIndex = 0
        
        return sc
    }()
    
    private let signUpButton: AuthButtonUIButton = {
        let button = AuthButtonUIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(performSignUp), for: .touchUpInside)
        return button
    }()
    
    let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already registered?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "Log In", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
        
        button.addTarget(self, action: #selector(handleVisibleLogIn), for: .touchUpInside)
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    // MARK: - Lifecycale
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSignupUI()
        
    }
    
    // MARK: - Helper Function
    
    func uploadUserDataAndShowHomeController(userId: String, userObj: [String: Any]) {
        REF_USERS.child(userId).updateChildValues(userObj) { (error, ref) in
            
            //handle error
            
            /*let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
            
            guard let controller = keyWindow?.rootViewController as? FirstViewController else { return }
            //controller.configure()
             */
            /*self.navigationController?.popViewController(animated: true)*/
            self.dismiss(animated: true, completion: nil)
            
            
                   let vc = FirstViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func configureSignupUI() {
        view.backgroundColor = UIColor.darkGray
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [/*emailContainerView, fullNameContainerView, passwordContainerView, accountTypeContainerView, signUpButton*/ fullNameTextFiled,addressTextFiled,emailTextFiled,passwordTextFiled,studentEmpCodeTextFiled,
        accountTypeSegmentedControl,signUpButton])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 24
        
        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
        
    }
    
    // MARK: - Selectors
    
    @objc func performSignUp() {
        guard let email = emailTextFiled.text else { return }
        guard let password = passwordTextFiled.text else { return }
        guard let fullName = fullNameTextFiled.text else { return }
        let roleType = accountTypeSegmentedControl.selectedSegmentIndex
        
        let address = addressTextFiled.text
        let userIndexCode = studentEmpCodeTextFiled.text
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Faild to register user with error \(error)")
                return
            }
            
            guard let userId = result?.user.uid else { return }
            
            let formatter = DateFormatter()
                      // initially set the format based on your datepicker date / server String
                      formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

                      let myString = formatter.string(from: Date()) // string purpose I add here
                      // convert your string to date
                      let yourDate = formatter.date(from: myString)
                      //then again set the date format whhich type of output you need
                      formatter.dateFormat = "dd-MMM-yyyy"
                      // again convert your date to string
                      let myStringafd = formatter.string(from: yourDate!)
            
            let userObj = [
            "uid": userId,
            "userEmail": email.lowercased(),
            "userFullName": fullName,
            "roleType": roleType,
            "address": address,
            "userIndexCode": userIndexCode,
            "keyValue": fullName + myStringafd,
            "createdDate": myStringafd,
            "userImage": Constants().userImage
                ] as [String : Any]
            
            
            /*REF_USERS.child(userIndexCode!).updateChildValues(userObj) { (error, ref) in
               
               
            }*/
            
            /* if roleType == 1 {
                let geoFire = GeoFire(firebaseRef: REF_DRIVER_LOCATIONS)
                
                guard let location = self.location else { return }
                
                geoFire.setLocation(location, forKey: userId, withCompletionBlock: { (error) in
                    self.uploadUserDataAndShowHomeController(userId: userId, userObj: userObj)
                })
            }*/
            
          

            self.uploadUserDataAndShowHomeController(userId: String(email.lowercased().split(separator: "@")[0]), userObj: userObj)
        }
    }
    
    
    @objc func handleVisibleLogIn() {
        navigationController?.popViewController(animated: true)
    }
    
      override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
      }
}

