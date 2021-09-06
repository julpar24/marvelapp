//
//  EventDetailViewController.swift
//  marvelapp
//
//  Created by Juliana Pardal on 04/09/2021.
//

import UIKit
import ESPullToRefresh

class EventDetailViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var comicsTableView: UITableView!
    
    // MARK: - IBActions
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Variables
    var model: EventDetailViewModel!
    var firstLoad = true
    
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
        addInfiniteScroll()
        getComics()
    }
    
    private func addInfiniteScroll() {
        comicsTableView.es.addInfiniteScrolling { [weak self] in
            self?.getComics()
        }
    }
    
    private func getComics() {
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
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        if firstLoad {
            firstLoad = false
        }
        DispatchQueue.main.async { [weak self] in
            self?.comicsTableView.es.stopLoadingMore()
            self?.comicsTableView.performBatchUpdates({ [weak self] in
                let sectionToReload = 0
                let indexSet: IndexSet = [sectionToReload]
                self?.comicsTableView.reloadSections(indexSet, with: .automatic)
            }, completion: nil)
        }
    }
}
