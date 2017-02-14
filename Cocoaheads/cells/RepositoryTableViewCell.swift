//
//  RepositoryTableViewCell.swift
//  Cocoaheads
//
//  Created by Vitor Mesquita on 13/02/17.
//  Copyright © 2017 Vitor Mesquita. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var forkCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populate(with repository: Repository) {
        if let name = repository.name {
            repositoryNameLabel.text = name
        }
        
        if let starsCount = repository.starsCount {
            starsCountLabel.text = "\(starsCount)"
        }
        
        if let language = repository.language {
            languageLabel.text = language
        }
        
        if let forkCount = repository.forksCount {
            forkCountLabel.text = "\(forkCount)"
        }
    }
}
