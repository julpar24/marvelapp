//
//  CharactersViewController.swift
//  marvelapp
//
//  Created by Juliana Pardal on 30/08/2021.
//

import UIKit
import ESPullToRefresh

class CharactersViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var characters: UICollectionView!
    
    // MARK: - Variables
    var model: CharactersViewModel!
    var firstLoad = true
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        //configureActivityIndicator()
    }
    
    // MARK: - Functions
    private func configureCollectionView() {
        characters.dataSource = self
        characters.delegate = self
        registerCells()
        addInfiniteScroll()
        getCharacters(resetList: true)
        characters.es.addPullToRefresh { [weak self] in
            self?.getCharacters(resetList: true)
        }
    }
    
    private func addInfiniteScroll() {
        characters.es.addInfiniteScrolling { [weak self] in
            self?.getCharacters()
        }
    }
    
    private func registerCells() {
        let characterCell = UINib(nibName: "CharacterCell", bundle: nil)
        characters.register(characterCell, forCellWithReuseIdentifier: "CharacterCell")
    }
    
    func presentCharacterDetail(for indexPath: IndexPath) {
        let character = model.element(for: indexPath)
        let viewController = ViewControllerFactory.characterDetail(character: character)
        viewController.modalPresentationStyle = .overCurrentContext
        present(viewController, animated: true, completion: nil)
    }
    
    private func getCharacters(resetList: Bool = false) {
        model.getElementsInfo(resetList: resetList)
    }
}

extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = model.objectForRow(atIndexPath: indexPath) as? CharacterCellConfiguration else { return UICollectionViewCell() }
        let cell = characters.dequeueReusableCell(withReuseIdentifier: model.identifierForCell(atIndexPath: indexPath), for: indexPath)
        (cell as? CellConfiguration)?.configure(with: item)
        return cell        
    }
}

extension CharactersViewController: UICollectionViewDelegateFlowLayout {
    
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

extension CharactersViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentCharacterDetail(for: indexPath)
    }
}

extension CharactersViewController: CharactersViewModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        if firstLoad {
            firstLoad = false
        }
        DispatchQueue.main.async { [weak self] in
            self?.characters.es.stopPullToRefresh()
            self?.characters.es.stopLoadingMore()
            self?.characters.performBatchUpdates({ [weak self] in
                self?.characters.reloadSections([0])
            }, completion: nil)
        }
    }
}
