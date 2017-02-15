//
//  Presenter.swift
//  Cocoaheads
//
//  Created by Vitor Mesquita on 14/02/17.
//  Copyright © 2017 Vitor Mesquita. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol PresenterProtocol {
    var numberOfRows: Int {get}
    var repositoriesChanged: Observable<Void> {get}
    
    func viewDidLoad()
    func getItem(indexPath: IndexPath) -> Repository?
}

class Presenter {
    
    weak var viewProtocol: ViewProtocol?
    var interactorProtocol: RepositoryInput!
    //wireFrame
    
    let dispose = DisposeBag()
    
    var repositories = Variable<[Repository]>([])
    
    func bind() {
        if let viewProtocol = viewProtocol {
            viewProtocol.searchBarTextObservable
                .filter({ (text) -> Bool in
                    return text!.characters.count >= 3
                })
                .debounce(0.8, scheduler: MainScheduler.instance)
                .bindNext({[weak self] (query) in
                    guard let strongSelf = self, let query = query else { return }
                    
                    strongSelf.viewProtocol?.setVisibilityActivityIndicator(isVisible: true)
                    strongSelf.interactorProtocol.searchRepositories(query: query)
                })
                .addDisposableTo(dispose)
        }
    }
}

extension Presenter: PresenterProtocol {
    
    var numberOfRows: Int {
        return self.repositories.value.count
    }
    
    var repositoriesChanged: Observable<Void> {
        return repositories.asObservable().map({ (_) -> Void in
            
        })
    }
    
    func viewDidLoad() {
        bind()
    }
    
    func getItem(indexPath: IndexPath) -> Repository? {
        return repositories.value[indexPath.row]
    }
    
    //clicou na table c indexpath
}

extension Presenter: RepositoryOutput {
    
    func foundRepositories(repositories: [Repository]?) {
        guard let repositories = repositories else {return}
        viewProtocol?.setVisibilityActivityIndicator(isVisible: false)
        self.repositories.value = repositories
    }
}
