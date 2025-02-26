//
//  ViewController.swift
//  ProfileScreen
//
//  Created by KAMA . on 26.02.2025.
//

import UIKit

class ViewController: UIViewController, SettingsViewControllerDelegate {
    
    private lazy var profileImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "profileImage")
        $0.layer.cornerRadius = 50
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private lazy var nameAndSurnameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Имя Фамилия"
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 20)
        return $0
    }(UILabel())
    
    private lazy var settingsButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Настройки", for: .normal)
        $0.setTitleColor(.blue, for: .normal)
        $0.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var leftSomeView: UIView = createStatsView(count: "10", label: "Друзей")
    private lazy var centerSomeView: UIView = createStatsView(count: "20", label: "Подписок")
    private lazy var rightSomeView: UIView = createStatsView(count: "30", label: "Избранных")

    private lazy var statsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftSomeView, centerSomeView, rightSomeView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var mainImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "Image")
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        return $0
    }(UIImageView())

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Профиль"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setViews()
        setConstraints()
    }
    
    private func setViews() {
        view.backgroundColor = .white
        view.addSubview(profileImageView)
        view.addSubview(nameAndSurnameLabel)
        view.addSubview(settingsButton)
        view.addSubview(statsStackView)
        view.addSubview(mainImageView)
    }
    
    func updateProfileData(name: String, surname: String) {
        nameAndSurnameLabel.text = "\(name) \(surname)"
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameAndSurnameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            nameAndSurnameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            nameAndSurnameLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 60),
            nameAndSurnameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            settingsButton.topAnchor.constraint(equalTo: nameAndSurnameLabel.bottomAnchor, constant: 5),
            settingsButton.centerXAnchor.constraint(equalTo: nameAndSurnameLabel.centerXAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: view.frame.width - 60),
            
            statsStackView.topAnchor.constraint(equalTo: settingsButton.bottomAnchor, constant: 20),
            statsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            statsStackView.heightAnchor.constraint(equalToConstant: 80),
            
            mainImageView.topAnchor.constraint(equalTo: statsStackView.bottomAnchor, constant: 20),
            mainImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    private func createStatsView(count: String, label: String) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        
        let countLabel = UILabel()
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.text = count
        countLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        countLabel.textAlignment = .left
        
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = label
        textLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        textLabel.textAlignment = .left
        
        let stackView = UIStackView(arrangedSubviews: [countLabel, textLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
        ])
        
        return view
    }
    
    @objc func settingsButtonTapped() {
        print("settings label tapped")
        let settingsVC = SettingsViewController()
        settingsVC.delegate = self
        show(settingsVC, sender: nil)
    }
}

import SwiftUI

struct ViewControllerWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
}

struct ContentView: View {
    var body: some View {
        ViewControllerWrapper().edgesIgnoringSafeArea(.all)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

