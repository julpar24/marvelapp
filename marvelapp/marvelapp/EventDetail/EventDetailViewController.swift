//
//  EventDetailViewController.swift
//  marvelapp
//
//  Created by Juliana Pardal on 04/09/2021.
//

import UIKit

class EventDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var comicsTableView: UITableView!
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    var model: EventDetailViewModel!
    
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
        eventName.text = model.title
        eventDate.text = model.eventInfo
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

extension EventDetailViewController: UITableViewDataSource {
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

extension EventDetailViewController: EventDetailViewModelDelegate {
    func dataSourceWasUpdated() {
        DispatchQueue.main.async { [weak self] in
            self?.comicsTableView.reloadData()
        }
    }
}
