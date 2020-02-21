//
//  BaseViewController.swift
//  CoreDataDemo
//
//  Created by webwerks on 31/07/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

/// This class is base class for application
class BaseViewController: UIViewController {

    //MARK:- Variables
    private var hud: MBProgressHUD?

    //MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK:- Navigationbar Method

    /// This method setup custom navigation bar
    ///
    /// - Parameter prefersLargeTitles: Bool
    func setupNavigationBar(_ prefersLargeTitles:Bool) {
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
            self.navigationController?.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.black,
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 22)
            ]
        }
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }


    /// This method adds rightbar button
    ///
    /// - Parameter title: String
    func setupAddBarButton(_ title:String) {
        let btnadd = UIButton(type: .custom)
        btnadd.setTitle(title, for: .normal)
        btnadd.setTitleColor(UIColor.black, for: .normal)
        //set button
        let barButton = UIBarButtonItem(customView: btnadd)
        self.navigationItem.rightBarButtonItem = barButton

        btnadd.addTarget(self, action: #selector(self.saveNote), for: .touchUpInside)
    }

    /// This method is associated with  rightbar button
    @objc func saveNote() {

    }

    /// This method display loader
    ///
    /// - Parameter view: UIView
    func showLoader(view:UIView) {
        hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud?.mode = MBProgressHUDMode.indeterminate
        hud?.label.text = "Loading"
    }

    /// This method hides loader
    func hideLoader() {
        hud?.hide(animated: true)
    }

}
