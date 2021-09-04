//
//  CharacterCell.swift
//  marvelapp
//
//  Created by Juliana Pardal on 31/08/2021.
//

import UIKit
import SDWebImage

class CharacterCell: UICollectionViewCell, CellConfiguration {
    // MARK: - Outlets
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var characterDescription: UILabel!
    
    func configure(with object: Any?) {
        contentView.layer.cornerRadius = 4
        guard let configuration = object as? CharacterCellConfiguration else { return }
        guard let url = configuration.image?.url else {
            characterImage.image = nil
            return
        }
        characterImage.sd_setImage(with: url) { [weak self] image, _, _, _ in
            self?.characterImage.image = image
        }
        name.text = configuration.elementName
        characterDescription.text = configuration.elementInfo
    }
}
