//
//  AppUtils.swift
//  AlamofireDemo
//
//  Created by Dmitry on 10/26/18.
//  Copyright © 2018 Dmitry. All rights reserved.
//

import Foundation
import UIKit

protocol ErrorDialogCallBack {
    func onErrorClick(status : Int32)
}



func showError(errorMessage: String, parentView: UIViewController, errCallback: ErrorDialogCallBack?) {
    let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        switch action.style{
        case .default:
            print("default")
            errCallback?.onErrorClick(status: 0)
        case .cancel:
            print("cancel")
            errCallback?.onErrorClick(status: 1)
        case .destructive:
            print("destructive")
            errCallback?.onErrorClick(status: -1)
        }}))
    parentView.present(alert, animated: true, completion: nil)
}
