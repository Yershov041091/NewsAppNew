//
//  DetaileCollectionViewCell.swift
//  NewsAppNew
//
//  Created by Artem Yershov on 04.09.2023.
//

import UIKit
import SnapKit

final class DetaileCollectionViewCell: UICollectionViewCell {
    
    //MARK: - GUI Variables
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "image") ?? UIImage.add
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        
        return view
    }()
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Title text"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "It's mainly a convenience endpoint that you can use to keep track of the publishers available on the API, and you can pipe it straight through to your users."
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 2
        
        return label
    }()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    private func setUpUI() {
        addSubViews(views: [imageView, titleLabel, descriptionLabel])
        
        setUpConstraints()
    }
    private func setUpConstraints() {
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(self.frame.height)
            make.leading.top.bottom.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(5)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(imageView.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
        }
    }
}
