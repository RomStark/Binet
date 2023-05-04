//
//  CollectionViewController.swift
//  Binet
//
//  Created by Al Stark on 29.04.2023.
//

import UIKit

/// Протокол управления View - слоем в модуле Start
protocol CollectionViewable: AnyObject {
    
}

final class CollectionViewController: UIViewController {
    
    var presenter: CollectionPresentation?
    private let myRefreshontrol: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
        return refresh
    }()
    
    private var drugsList: [Drug] = [] {
            didSet {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        setupUI()
        fetchDrugs()
    }
}


private extension CollectionViewController {
    
    @objc private func refreshData(sender: UIRefreshControl) {
        drugsList = []
        fetchDrugs()
        sender.endRefreshing()
    }
    
    private func fetchDrugs() {
        getDrugs(offset: 0)
    }
    
    private func getDrugs(offset: Int) {
        presenter?.getDrugs(offset:offset, completion: { [weak self] result in
            switch result {
            case .success(let drugs):
                DispatchQueue.main.async{
                    self?.drugsList.append(contentsOf: drugs)
                }
            case .failure(let failure):
                print("oshibka")
            }
        })
    }
    
    private func setupUI() {
        setupCollectionView()
        setupNavController()
    }
    
    private func setupNavController() {
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(seachButtonTapped))
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc
    private func seachButtonTapped() {
        let alert = UIAlertController(title: "Поиск", message: "Введите строку", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        let okAction = UIAlertAction(title: "Найти", style: .default){ [weak self] (action) in
            let searchStr = alert.textFields?.first?.text
            self?.presenter?.getDrugsBySearh(string: searchStr ?? "", completion: { [weak self] result in
                switch result {
                case .success(let drugs):
                    DispatchQueue.main.async{
                        self?.drugsList = drugs
                    }
                case .failure(let failure):
                    print("oshibka")
                }
            })
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        alert.addTextField { loginTF in
            loginTF.placeholder = "Введите почту"
        }
        
        present(alert, animated: true)
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        view.addSubview(collectionView)
        collectionView.refreshControl = myRefreshontrol
        collectionView.backgroundColor = UIColor(red: (229.0/255), green: (229.0/255), blue: (229.0/255), alpha: 1.0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(DrugCollectionViewCell.self, forCellWithReuseIdentifier: DrugCollectionViewCell.reuseIdentifier)
    }
    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = .init(width: 164, height: 296)
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        
        layout.sectionInset = .init(top: 10, left: 15, bottom: 15, right: 15)
        
        return layout
    }
}


//MARK: UICollectionViewDataSource
extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drugsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrugCollectionViewCell.reuseIdentifier, for: indexPath) as? DrugCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(drug: drugsList[indexPath.row])
        return cell
    }

    
}

extension CollectionViewController: UICollectionViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let vc = DrugsInfoViewController()
        vc.configure(drug: self.drugsList[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func collectionView(_: UICollectionView, willDisplay: UICollectionViewCell, forItemAt: IndexPath) {
        if forItemAt.row == drugsList.endIndex - 1 {
            if drugsList.endIndex % 10 == 0 {
                getDrugs(offset: drugsList.endIndex)
            }
        }
    }
}


// MARK: - CollectionViewable
extension CollectionViewController: CollectionViewable {
    
}

