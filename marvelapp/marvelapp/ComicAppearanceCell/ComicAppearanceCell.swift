//
//  ComicAppearanceCell.swift
//  marvelapp
//
//  Created by Juliana Pardal on 02/09/2021.
//

import UIKit

class ComicAppearanceCell: UITableViewCell, CellConfiguration {
    @IBOutlet weak var comic: UILabel!
    @IBOutlet weak var year: UILabel!
    
    func configure(with object: Any?) {
        guard let configuration = object as? ComicAppearanceCellConfiguration else { return }
        comic.text = configuration.comic
        year.text = configuration.year
    }
}
