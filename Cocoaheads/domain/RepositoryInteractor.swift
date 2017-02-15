//
//  RepositoryInteractor.swift
//  Cocoaheads
//
//  Created by Vitor Mesquita on 14/02/17.
//  Copyright © 2017 Vitor Mesquita. All rights reserved.
//

import UIKit
import RxSwift

protocol RepositoryInput {
    func searchRepositories(query: String)
}

protocol RepositoryOutput: class {
    func foundRepositories(repositories:[Repository]?)
}

class RepositoryInteractor {

    weak var output: RepositoryOutput?
    let dispose = DisposeBag()
}


extension RepositoryInteractor: RepositoryInput {
    
    func searchRepositories(query: String) {
        APIClient
            .getRepositories(byName: query)
            .bindNext {[weak self] (repositories) in
                guard let strongSelf = self else { return }
                strongSelf.output?.foundRepositories(repositories: repositories)
//                strongSelf.repositories = repositories
            }
            .addDisposableTo(dispose)
    }

}
