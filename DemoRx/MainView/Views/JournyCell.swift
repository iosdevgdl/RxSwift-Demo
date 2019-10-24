//
//  JournyCell.swift
//  DemoRx
//
//  Created by Yan Cervantes on 9/30/19.
//  Copyright © 2019 Yan Cervantes. All rights reserved.
//

import UIKit

class JournyCell: UITableViewCell {
    let imageService = ImageService()
    var myJournies: Journies? {
        didSet {
            guard let myJournies = myJournies else { return }
            stateLabel.text = myJournies.state
            placeLabel.text = myJournies.name
            
            let url = myJournies.url
            imageService.downloadImage(withBucketURL: url, completion: { [weak self] (result) in
                switch result {
                case .failure(let error):
                    print("Error getting Image:", error.localizedDescription)
                case .success(let image):
                    self?.imagePlace.image = image
                }
            })
        }
    }
    
    let stateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    let placeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    let imagePlace: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    static var id: String {
        return String(describing: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubviews(views: stateLabel, placeLabel, imagePlace)
        
        stateLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: imagePlace.leadingAnchor,
                          padding: .init(top: 10, left: 15, bottom: 0, right: 15))
        
        placeLabel.anchor(top: stateLabel.bottomAnchor, leading: stateLabel.leadingAnchor, bottom: nil, trailing: imagePlace.leadingAnchor,
                          padding: .init(top: 10, left: 0, bottom: 0, right: 15))
        
        imagePlace.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor,
                          padding: .init(top: 0, left: 0, bottom: 0, right: 15), size: .init(width: 150, height: 150))
        imagePlace.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("Error init")
    }
}
