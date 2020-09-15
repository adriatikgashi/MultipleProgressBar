//
//  ViewController.swift
//  MultipleProgressBar
//
//  Created by adriatikgashi on 09/15/2020.
//  Copyright (c) 2020 adriatikgashi. All rights reserved.
//

import UIKit
import MultipleProgressBar

class ViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Multiple Progress Bar"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 30)
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var multipleProgressView: MultiProgressView = {
        let view = MultiProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.addTarget(self, action: #selector(handleStart(_:)), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var kUsageModels = [
        UsagesModel(color: .red, value: 110.58),
        UsagesModel(color: .green, value: 5.23),
        UsagesModel(color: .blue, value: 1.25),
        UsagesModel(color: .yellow, value: 0.58),
        UsagesModel(color: .purple, value: 0.31),
        UsagesModel(color: .lightGray, value: 32.51),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func showProgressBar() {
        view.addSubview(multipleProgressView)
        
        NSLayoutConstraint.activate([
            multipleProgressView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            multipleProgressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            multipleProgressView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30),
            multipleProgressView.heightAnchor.constraint(equalToConstant: 20)
        ])
        multipleProgressView.updateViews(usageModels: kUsageModels)
    }
    
    // MARK: - Handlers
    @objc
    private func handleStart(_ sender: UIButton) {
        showProgressBar()
    }
}
