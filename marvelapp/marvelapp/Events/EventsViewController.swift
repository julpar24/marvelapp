//
//  EventsViewController.swift
//  marvelapp
//
//  Created by Juliana Pardal on 30/08/2021.
//

import UIKit
import ESPullToRefresh

class EventsViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var events: UICollectionView!
    
    // MARK: - Variables
    var model: EventsViewModel!
    var firstLoad = true
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    // MARK: - Functions
    private func configureCollectionView() {
        events.dataSource = self
        events.delegate = self
        registerCells()
        addInfiniteScroll()
        getEvents(resetList: true)
        events.es.addPullToRefresh { [weak self] in
            self?.getEvents(resetList: true)
        }
    }
    
    private func addInfiniteScroll() {
        events.es.addInfiniteScrolling { [weak self] in
            self?.getEvents()
        }
    }
    
    private func getEvents(resetList: Bool = false) {
        model.getElementsInfo(resetList: resetList)
    }
    
    private func registerCells() {
        let characterCell = UINib(nibName: "CharacterCell", bundle: nil)
        events.register(characterCell, forCellWithReuseIdentifier: "CharacterCell")
    }
    
    func presentEventDetail(for indexPath: IndexPath) {
        let event = model.event(for: indexPath)
        let viewController = ViewControllerFactory.eventDetail(event: event)
        viewController.modalPresentationStyle = .overCurrentContext
        present(viewController, animated: true, completion: nil)
    }
}

extension EventsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = model.objectForRow(atIndexPath: indexPath) as? CharacterCellConfiguration else { return UICollectionViewCell() }
        let cell = events.dequeueReusableCell(withReuseIdentifier: model.identifierForCell(atIndexPath: indexPath), for: indexPath)
        (cell as? CellConfiguration)?.configure(with: item)
        return cell
    }
}

extension EventsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return model.itemSize(forIndexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return model.minimumLineSpacing(forSectionAt: section)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return model.minimumInteritemSpacing(forSectionAt: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return model.inset(forSection: section)
    }
}

extension EventsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentEventDetail(for: indexPath)
    }
}

extension EventsViewController: EventsViewModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        if firstLoad {
            firstLoad = false
        }
        DispatchQueue.main.async { [weak self] in
            self?.events.es.stopPullToRefresh()
            self?.events.es.stopLoadingMore()
            self?.events.performBatchUpdates({ [weak self] in
                self?.events.reloadSections([0])
            }, completion: nil)
        }
    }
}
