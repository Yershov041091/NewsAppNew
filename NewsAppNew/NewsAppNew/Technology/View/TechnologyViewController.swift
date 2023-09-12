//
//  TechnologyViewController.swift
//  NewsAppNew
//
//  Created by Artem Yershov on 03.09.2023.
//

import Foundation
import UIKit

final class TechnologyViewController: UIViewController {
    
    //MARK: - GUIVariables
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let width = (view.frame.width - 15) / 2
        
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        layout.itemSize = CGSize(width: width, height: width)
        
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)
        
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    //MARK: - Properties
    private var viewModel: NewsListViewModelProtocol

    //MARK: - LigeCycle
    init(viewModel: NewsListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.setUpViewModel()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        viewModel.loadData()
    }
    
    //MARK: - private Methods
    
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
    private func setUpConstraints() {

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func setUpUI() {
        view.backgroundColor = .white
        view.addSubViews(views: [collectionView])
        
        collectionView.register(GeneralCollectionViewCell.self, forCellWithReuseIdentifier: "GeneralCollectionViewCell")
        collectionView.register(DetaileCollectionViewCell.self, forCellWithReuseIdentifier: "DetaileCollectionViewCell")
        
        
        
        setUpConstraints()
    }
}
//MARK: - UICollectionViewDataSource
extension TechnologyViewController: UICollectionViewDataSource {
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
        
        guard let article = viewModel.sections[indexPath.section].items[indexPath.row] as? ArticleCellViewModel else { return UICollectionViewCell() }
        
        //тут мы определяем в какой секции какую ячейку инициализировать
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCollectionViewCell", for: indexPath) as? GeneralCollectionViewCell
            
            cell?.set(article: article)
            
            return cell ?? UICollectionViewCell()
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetaileCollectionViewCell", for: indexPath) as? DetaileCollectionViewCell
            
            cell?.set(article: article)
            
            return cell ?? UICollectionViewCell()
        }
    }
}

//MARK: - UICollectionViewDelegate
extension TechnologyViewController: UICollectionViewDelegate {
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
//Задаем размер ячеек для каждой из секций

//MARK: - UICollectionViewDelegateFlowLayout
extension TechnologyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //задаем фиксированную ширину и высоту ячейки что бы не повторяться
        let width = view.frame.width
        
        let firstSectionItemSize = CGSize(width: width, height: width)
        let secondSectionItemSize = CGSize(width: width, height: 100)
        
        return indexPath.section == 0 ? firstSectionItemSize : secondSectionItemSize
    }
}
