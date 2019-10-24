//
//  ViewController.swift
//  DemoRx
//
//  Created by Yan Cervantes on 9/30/19.
//  Copyright © 2019 Yan Cervantes. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var myJournies = [Journies]()
    
    private lazy var myJourneyTable: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(JournyCell.self, forCellReuseIdentifier: JournyCell.id)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
        setupViews()
        fetchJournies()
    }
    
    private func setupNavigation() {
        navigationItem.title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupViews() {
        view.addSubview(myJourneyTable)
        myJourneyTable.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    private func fetchJournies() {
        Api.getModel { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let journeys):
                self?.myJournies = journeys ?? []
                DispatchQueue.main.async {
                    self?.myJourneyTable.reloadData()
                }
            }
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myJournies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: JournyCell.id, for: indexPath) as? JournyCell else { return UITableViewCell() }
        cell.myJournies = myJournies[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
