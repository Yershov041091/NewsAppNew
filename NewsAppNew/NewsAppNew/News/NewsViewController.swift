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
        view.image = UIImage(named: "image") ?? UIImage.add
        
        return view
    }()
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Example Text"
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "However this is part of a system that autogenerates documention, so I can't change the source code. I can put style things in the header of each documention, so I need some sort of LaTeX command that will make all definition list (in LaTeX speak, a) go onto a new line. However this is part of a system that autogenerates documention, so I can't change the source code. I can put style things in the header of each documention, so I need some sort of LaTeX command that will make all definition list (in LaTeX speak, a) go onto a new line. "
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
    
    //MARK: - LifeCycle
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
