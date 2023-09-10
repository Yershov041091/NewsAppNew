//
//  NewsViewController.swift
//  NewsAppNew
//
//  Created by Artem Yershov on 03.09.2023.
//

import UIKit
import SnapKit

final class NewsViewController: UIViewController {
    
    //MARK: - GUI Variables
    
    private lazy var scrolView: UIScrollView = {
       let view = UIScrollView()
        
        return view
    }()
    private lazy var contentView: UIView = {
       let view = UIView()
        
        return view
    }()
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        
        label.numberOfLines = 3
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .left
        
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        
        label.numberOfLines = 0
        label.font = .italicSystemFont(ofSize: 15)
        label.textColor = .gray
        label.textAlignment = .left
        
        return label
    }()
    private lazy var dateLabel: UILabel = {
       let label = UILabel()
        label.text = "\(Date.now.formatted(date: .abbreviated, time: .omitted))"
        label.textColor = .red
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    //MARK: - Properties
    private let viewModel: NewsViewModelProtocol
    
    //MARK: - LifeCycle
    init(viewModel: NewsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    //MARK: - Private methods
    private func setUpUI(){
        
        contentView.addSubViews(views: [imageView, titleLabel, descriptionLabel,dateLabel])
        scrolView.addSubview(contentView)
        view.addSubview(scrolView)
        view.backgroundColor = .white
        
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        dateLabel.text = viewModel.date
        
        if let data = viewModel.imageData,
           let image = UIImage(data: data) {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "image")
        }
        
        setUpConstraints()
    }
    private func setUpConstraints() {
        scrolView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.width.edges.equalToSuperview()
            make.height.equalToSuperview().inset(5)
        }
        imageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(view.frame.height / 3)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.trailing.leading.equalToSuperview().inset(5)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.trailing.leading.equalToSuperview().inset(5)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(5)
        }
    }
}
