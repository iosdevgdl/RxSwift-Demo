//
//  HandlerCustomAlert.swift
//  SampleRxSwift
//
//  Created by Adrian Cervantes on 4/29/19.
//  Copyright © 2019 Yan Cervantes. All rights reserved.
//

import Foundation

extension CustomAlert {
    func setupConstraints() {
        dialogView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dialogView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        dialogView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75).isActive = true
        dialogView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        titleLabel.textAlignment = .center
        titleLabel.topAnchor.constraint(equalTo: dialogView.topAnchor, constant: 25).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: dialogView.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 0.70).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: okButton.topAnchor, constant: -5).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor).isActive = true
        
        cancelButton.leadingAnchor.constraint(equalTo: dialogView.leadingAnchor, constant: 15).isActive = true
        cancelButton.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 1/2.5).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: dialogView.bottomAnchor, constant: -15).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        okButton.trailingAnchor.constraint(equalTo: dialogView.trailingAnchor, constant: -15).isActive = true
        okButton.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 1/2.5).isActive = true
        okButton.bottomAnchor.constraint(equalTo: dialogView.bottomAnchor, constant: -15).isActive = true
        okButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
}
