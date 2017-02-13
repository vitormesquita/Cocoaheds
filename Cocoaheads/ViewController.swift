//
//  ViewController.swift
//  Cocoaheads
//
//  Created by Vitor Mesquita on 13/02/17.
//  Copyright © 2017 Vitor Mesquita. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let dispose = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = UIView()
    }
    
    private func searchRepositories(query: String) {
        ApiClient.getRepositories(byName: query)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
