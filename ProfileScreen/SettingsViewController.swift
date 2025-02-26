//
//  SettingsViewController.swift
//  ProfileScreen
//
//  Created by KAMA . on 26.02.2025.
//

import Foundation
import UIKit


protocol SettingsViewControllerDelegate: AnyObject {
    func updateProfileData(name: String, surname: String)
}

class SettingsViewController: UIViewController {
    
    weak var delegate: SettingsViewControllerDelegate?
    
    var nameTF: UITextField!
    var surnameTF: UITextField!
    
    private lazy var dataLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Введите новые данные"
        return $0
    }(UILabel())
    
    private lazy var someView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        return $0
    }(UIView())
    
    private lazy var saveButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.setTitle("Сохранить", for: .normal)
        $0.layer.cornerRadius = 25
        $0.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private func createTextField(placeholder: String, offsetY: CGFloat = 0) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.textAlignment = .left
        textField.layer.cornerRadius = 30
        textField.placeholder = placeholder
        textField.textColor = .black
        textField.clearButtonMode = .always
        textField.addLeftPadding(padding: 20)
        
        return textField
    }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        let name = nameTF.text?.isEmpty == false ? nameTF.text! : "Имя"
        let surname = surnameTF.text?.isEmpty == false ? surnameTF.text! : "Фамилия"
        
        delegate?.updateProfileData(name: name, surname: surname)
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Настройки"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesBackButton = true
        
        setViews()
        setConstraints()
        
    }
    
    private func setViews() {
        view.backgroundColor = .white
        view.addSubview(dataLabel)
        view.addSubview(someView)
        nameTF = createTextField(placeholder: "Имя", offsetY: 60)
        surnameTF = createTextField(placeholder: "Фамилия", offsetY: 120)
        view.addSubview(nameTF)
        view.addSubview(surnameTF)
        view.addSubview(saveButton)
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dataLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            dataLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dataLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            someView.topAnchor.constraint(equalTo: dataLabel.bottomAnchor, constant: 40),
            someView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            someView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            someView.heightAnchor.constraint(equalToConstant: 265),
            
            nameTF.topAnchor.constraint(equalTo: someView.topAnchor, constant: 30),
            nameTF.leadingAnchor.constraint(equalTo: someView.leadingAnchor, constant: 15),
            nameTF.centerXAnchor.constraint(equalTo: someView.centerXAnchor),
            nameTF.heightAnchor.constraint(equalToConstant: 55),
            
            surnameTF.topAnchor.constraint(equalTo: nameTF.bottomAnchor, constant: 10),
            surnameTF.leadingAnchor.constraint(equalTo: someView.leadingAnchor, constant: 15),
            surnameTF.centerXAnchor.constraint(equalTo: someView.centerXAnchor),
            surnameTF.heightAnchor.constraint(equalToConstant: 55),
            
            saveButton.topAnchor.constraint(equalTo: surnameTF.bottomAnchor, constant: 40),
            saveButton.leadingAnchor.constraint(equalTo: someView.leadingAnchor, constant: 15),
            saveButton.centerXAnchor.constraint(equalTo: someView.centerXAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 55),
            
            
        ])
    }
    
}

extension UITextField {
    func addLeftPadding(padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}


extension UITextField {
    func addRightPadding(padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

import SwiftUI

struct SettingsViewControllerWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> SettingsViewController {
        return SettingsViewController()
    }
    
    func updateUIViewController(_ uiViewController: SettingsViewController, context: Context) {
        
    }
}

struct SettingsContentView: View {
    var body: some View {
        SettingsViewControllerWrapper().edgesIgnoringSafeArea(.all)
    }
}


struct SettingsContentView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsContentView()
    }
}





