//
//  CustomAlert.swift
//  SampleRxSwift
//
//  Created by Adrian Cervantes on 4/26/19.
//  Copyright © 2019 Yan Cervantes. All rights reserved.
//

import UIKit

class CustomAlert: UIView {
    
    var dialogView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var okButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .purple
        button.setTitle("Ok", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.addTarget(self, action: #selector(handleOkButton), for: .touchUpInside)
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .purple
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var completionAlert: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleOkButton() {
        completionAlert?()
        dismiss(animated: true)
    }
    
    @objc func handleCancelButton() {
        dismiss(animated: true)
    }
    
    private func setupViews() {
        addSubview(dialogView)
        self.frame = self.bounds
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dialogView.addSubviews(views: titleLabel, descriptionLabel, cancelButton, okButton)
        setupConstraints()
    }
    
    func show(animated: Bool, title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dialogView.center = CGPoint(x: self.center.x, y: self.frame.height + self.dialogView.frame.height / 2)
        guard let window = UIApplication.shared.keyWindow else { return }
        let view: UIView = window
        view.addSubview(self)
        if animated {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: UIView.AnimationOptions(rawValue: 0), animations: {
                self.dialogView.center = self.center
            }, completion: nil)
        } else {
            self.dialogView.center = self.center
        }
    }
    
    func dismiss(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.20, animations: { [weak self] in
                self?.backgroundColor = UIColor.black.withAlphaComponent(0)
            }, completion: nil)
            UIView.animate(withDuration: 0.50, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: UIView.AnimationOptions(rawValue: 0), animations: { [weak self] in
                guard let height = self?.dialogView.frame.height,
                    let xPoint = self?.center.x,
                    let frame = self?.frame.height else { return }
                self?.center = CGPoint(x: xPoint, y: height + frame)
            }) { (completed) in
                self.removeFromSuperview()
            }
        } else {
            removeFromSuperview()
        }
    }
}
