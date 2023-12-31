//
//  BusinessViewController.swift
//  NewsAppNew
//
//  Created by Artem Yershov on 03.09.2023.
//

import Foundation
import UIKit

class BusinessViewController: UIViewController {
    
    //MARK: - GUI variables

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = (view.frame.width - 15) / 2
        
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        //прописываем расстояние между секциями
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    //MARK: - Properties
    private var viewModel: BusinessViewModelProtocol

    //MARK: - LigeCycle
    init(viewModel: BusinessViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.setUpViewModel()
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
    private func setUpUI() {
        view.backgroundColor = .white
        view.addSubViews(views: [collectionView])
        
        collectionView.register(GeneralCollectionViewCell.self, forCellWithReuseIdentifier: "GeneralCollectionViewCell")
        collectionView.register(DetaileCollectionViewCell.self, forCellWithReuseIdentifier: "DetaileCollectionViewCell")
        
        
        
        setUpConstraints()
    }
    private func setUpConstraints() {

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
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
}
//MARK: - UICollectionViewDataSource
extension BusinessViewController: UICollectionViewDataSource {
    //кол-во секций
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfCells > 1 ? 2 : 1
    }
    //кол-во едениц в секции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.numberOfCells > 1 {
            return section == 0 ? 1 : viewModel.numberOfCells - 1
        }
        return viewModel.numberOfCells
    }
    //метод который возвращает нужную нам ячейку
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //тут мы определяем в какой секции какую ячейку инициализировать
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCollectionViewCell", for: indexPath) as? GeneralCollectionViewCell
            
            let article = viewModel.getArticle(for: 0)
            cell?.set(article: article)
            
            return cell ?? UICollectionViewCell()
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetaileCollectionViewCell", for: indexPath) as? DetaileCollectionViewCell
            
            let article = viewModel.getArticle(for: indexPath.row + 1)
            cell?.set(article: article)
            
            return cell ?? UICollectionViewCell()
        }
    }
}
//MARK: - UICollectionViewDelegate
extension BusinessViewController: UICollectionViewDelegate {
    //функция делает переход на навый вью контроллер при нажатии
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let article = viewModel.getArticle(for: indexPath.row == 0 ? 0 : indexPath.row + 1)
        navigationController?.pushViewController(NewsViewController(viewModel: NewsViewModel(article: article)), animated: true)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}
//Задаем размер ячеек для каждой из секций

//MARK: - UICollectionViewDelegateFlowLayout
extension BusinessViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //задаем фиксированную ширину и высоту ячейки что бы не повторяться
        let width = view.frame.width
        
        let firstSectionItemSize = CGSize(width: width, height: width)
        let secondSectionItemSize = CGSize(width: width, height: 100)
        
        return indexPath.section == 0 ? firstSectionItemSize : secondSectionItemSize
    }
}
