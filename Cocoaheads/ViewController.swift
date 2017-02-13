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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let dispose = DisposeBag()
    var repositories: [Repository]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        bind()
    }
    
    private func bind() {
        searchBar.rx.text
            .filter({ (text) -> Bool in
                return text!.characters.count >= 3
            })
            .debounce(0.5, scheduler: MainScheduler.instance)
            .bindNext({[weak self] (query) in
                guard let strongSelf = self, let query = query else { return }
                strongSelf.searchRepositories(query: query)
            })
            .addDisposableTo(dispose)
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    private func searchRepositories(query: String) {
        setVisibilityActivityIndicator(isVisible: true)
        APIClient
            .getRepositories(byName: query)
            .bindNext {[weak self] (repositories) in
                guard let strongSelf = self else { return }
                strongSelf.setVisibilityActivityIndicator(isVisible: false)
                strongSelf.repositories = repositories
            }
            .addDisposableTo(dispose)
    }
    
    func setVisibilityActivityIndicator(isVisible: Bool) {
        activityIndicator.isHidden = !isVisible
        if isVisible {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let repositories = repositories {
            return repositories.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
