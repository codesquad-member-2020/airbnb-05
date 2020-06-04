//
//  LoginViewController.swift
//  AirbnbProject
//
//  Created by Keunna Lee on 2020/06/01.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
     
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let authURL = URL(string: EndPoints.oauthLogin) else { return }
        let scheme = "airbnbfive"
        let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: scheme)
        { callbackURL, error in
            guard error == nil, let callbackURL = callbackURL else { return }

            let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
            let token = queryItems?.filter({ $0.name == "token" }).first?.value
            UserDefaults.standard.set(token, forKey: "JWTToken")
            UserDefaults.standard.object(forKey: "JWTToken")

            if token != nil {
                self.loginButton.setTitle("Login Success 🎉", for: .normal)
                let vc = self.storyboard?.instantiateViewController(identifier: "CityPickerViewController") as! CityPickerViewController
                self.present(vc, animated: true, completion: nil)
            }
        }
        session.presentationContextProvider = self
        session.start()
    }
}
extension LoginViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window!
    }
}
