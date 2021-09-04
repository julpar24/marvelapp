//
//  CharacterDetailViewController.swift
//  marvelapp
//
//  Created by Juliana Pardal on 02/09/2021.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var characterInfo: UILabel!
    @IBOutlet weak var comicsTableView: UITableView!
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var model: CharacterDetailViewModel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
    }
    
    // MARK: - Functions
    private func configureUI() {
        guard let url = model.image else {
            imageView.image = nil
            return
        }
        imageView.sd_setImage(with: url) { [weak self] image, _, _, _ in
            self?.imageView.image = image
        }
        characterInfo.text = model.characterInfo
        characterName.text = model.name
    }
    
    private func configureTableView() {
        comicsTableView.dataSource = self
        registerCells()
        model.getComicsInfo()
    }

    private func registerCells() {
        let comicCell = UINib(nibName: "ComicAppearanceCell", bundle: nil)
        comicsTableView.register(comicCell, forCellReuseIdentifier: "ComicAppearanceCell")
    }
}

extension CharacterDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = model.objectForCell(atIndexPath: indexPath) as? ComicAppearanceCellConfiguration else { return UITableViewCell() }
        let cell = comicsTableView.dequeueReusableCell(withIdentifier: model.identifierForCell(atIndexPath: indexPath), for: indexPath)
        (cell as? CellConfiguration)?.configure(with: item)
        return cell
    }
}

extension CharacterDetailViewController: CharacterDetailViewModelDelegate {
    func dataSourceWasUpdated() {
        DispatchQueue.main.async { [weak self] in
            self?.comicsTableView.reloadData()
        }
    }
}

