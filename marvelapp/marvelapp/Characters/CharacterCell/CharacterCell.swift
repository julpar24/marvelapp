//
//  CharacterCell.swift
//  marvelapp
//
//  Created by Juliana Pardal on 31/08/2021.
//

import UIKit
import SDWebImage

class CharacterCell: UITableViewCell, CellConfiguration {
    // MARK: - Outlets
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var characterDescription: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with object: Any?) {
        guard let configuration = object as? CharacterCellConfiguration else { return }
        guard let url = configuration.imageURL else {
            characterImage.image = nil
            return
        }
        characterImage.sd_setImage(with: url) { [weak self] image, _, _, _ in
            self?.characterImage.image = image
        }
        name.text = configuration.characterName
        characterDescription.text = configuration.characterDescription
    }
}
