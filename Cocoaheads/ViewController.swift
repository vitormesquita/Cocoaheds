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

protocol ViewProtocol: class {
    var searchBarTextObservable: Observable<String?> {get}
    func setVisibilityActivityIndicator(isVisible: Bool)
}

class ViewController: UIViewController {
    
    var presenterProtocol: PresenterProtocol!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let dispose = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenterProtocol.viewDidLoad()
        configureTableView()
        bind()
    }
    
    private func bind() {
        presenterProtocol.repositoriesChanged.bindNext {[weak self] (_) in
            guard let strongSelf = self else {return}
            strongSelf.tableView.reloadData()
        }
        .addDisposableTo(dispose)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 96
        tableView.separatorColor = .clear
        tableView.register(UINib(nibName: "RepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: "RepositoryTableViewCell")
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenterProtocol.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell", for: indexPath) as! RepositoryTableViewCell
        if let repository = presenterProtocol.getItem(indexPath: indexPath) {
            cell.populate(with: repository)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //presenter clicou nesse indexpath
    }
}

extension ViewController: ViewProtocol {
    
    var searchBarTextObservable: Observable<String?> {
        return searchBar.rx.text.asObservable()
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
