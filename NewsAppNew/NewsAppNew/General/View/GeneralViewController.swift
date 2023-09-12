//
//  GeneralViewController.swift
//  NewsAppNew
//
//  Created by Artem Yershov on 03.09.2023.
//

import UIKit
import SnapKit

class GeneralViewController: UIViewController {
    
    //MARK: - GUI variables
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
        return searchBar
    }()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = (view.frame.width - 15) / 2
        
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - searchBar.frame.height), collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    //MARK: - Properties
    var viewModel: NewsListViewModelProtocol

    //MARK: - LigeCycle
    //инициализируем нашу viewModel с помощью протокола
    init(viewModel: NewsListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setUpViewModel()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        viewModel.loadData()
    }
    
    //MARK: - Methods

    
    //MARK: - Private Methods
    private func setUpViewModel() {
        viewModel.reloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
        viewModel.reloadCell = { [weak self] row in
            self?.collectionView.reloadItems(at: [IndexPath(row: row, section: 0)])
        }
        viewModel.showError = { error in
            //TODO: show allert with error
            print(error)
        }
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
        view.addSubViews(views: [searchBar, collectionView])
        
        collectionView.register(GeneralCollectionViewCell.self, forCellWithReuseIdentifier: "GeneralCollectionViewCell")
        
        setUpConstraints()
    }
    private func setUpConstraints() {
        searchBar.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
//MARK: - UICollectionViewDataSource
extension GeneralViewController: UICollectionViewDataSource {
    //кол-во секций
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    //кол-во едениц в секции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.sections[section].items.count
    }
    //метод который возвращает нужную нам ячейку
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let article = viewModel.sections[indexPath.section].items[indexPath.row] as? ArticleCellViewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCollectionViewCell", for: indexPath) as? GeneralCollectionViewCell else { return UICollectionViewCell() }
        
        cell.set(article: article)
        
        return cell
    }
}
//MARK: - UICollectionViewDelegate
extension GeneralViewController: UICollectionViewDelegate {
    //функция делает переход на навый вью контроллер при нажатии
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let article = viewModel.sections[indexPath.section].items[indexPath.row] as? ArticleCellViewModel else { return }
        
        navigationController?.pushViewController(NewsViewController(viewModel: NewsViewModel(article: article)), animated: true)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.sections[indexPath.section].items.count - 15 {
            viewModel.loadData()
        }
    }
}

