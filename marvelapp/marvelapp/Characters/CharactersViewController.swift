//
//  CharactersViewController.swift
//  marvelapp
//
//  Created by Juliana Pardal on 30/08/2021.
//

import UIKit

class CharactersViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var charactersTableView: UITableView!
    
    // MARK: - Variables
    var model = CharactersViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    // MARK: - Functions
    private func configureTableView() {
        charactersTableView.dataSource = self
        registerTableViewCells()
    }
    
    private func registerTableViewCells() {
        let characterCell = UINib(nibName: "CharacterCell", bundle: nil)
        charactersTableView.register(characterCell, forCellReuseIdentifier: "CharacterCell")
    }
}

extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = model.objectForCell(atIndexPath: indexPath) as? CharacterCellConfiguration else { return UITableViewCell() }
        let cell = charactersTableView.dequeueReusableCell(withIdentifier: model.identifierForCell(atIndexPath: indexPath), for: indexPath)
        (cell as? CellConfiguration)?.configure(with: item)
        return cell
    }
}
