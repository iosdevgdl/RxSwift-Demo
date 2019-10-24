//
//  MyJournyController.swift
//  DemoRx
//
//  Created by Yan Cervantes on 9/30/19.
//  Copyright © 2019 Yan Cervantes. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MyJournyController: UIViewController {
    let disposeBag = DisposeBag()
    var myJournies = BehaviorRelay(value: [Journies]())
        
    lazy var myJournyTable: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.register(JournyCell.self, forCellReuseIdentifier: JournyCell.id)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
        setupViews()
        bindableTable()
        fetchJournies()
    }
    
    private func setupNavigation() {
        navigationItem.title = "My Journies"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupViews() {
        view.addSubview(myJournyTable)
        myJournyTable.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    private func fetchJournies() {
        Api.getModel { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let journies):
                self?.myJournies.accept(journies ?? [])
                
            }
        }
    }
}

extension MyJournyController: UITableViewDelegate {
    func bindableTable() {
        //SETUP CELL
        myJournies.bind(to: myJournyTable.rx
            .items(cellIdentifier: JournyCell.id,
                   cellType: JournyCell.self)) { (index, element, cell) in
        cell.myJournies = element
        }
        .disposed(by: disposeBag)
        // SELECT CELL
        myJournyTable.rx
            .modelSelected(Journies.self)
            .subscribe(onNext: { (journie) in
                print(journie)
            })
            .disposed(by: disposeBag)
        
//        myJournyTable.rx.itemSelected
//            .subscribe(onNext: { [weak self] (indexPath) in
//            print(self?.myJournies.value[indexPath.row] ?? "")
//            })
//            .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}


