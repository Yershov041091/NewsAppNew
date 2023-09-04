//
//  GeneralCollectionViewCell.swift
//  NewsAppNew
//
//  Created by Artem Yershov on 03.09.2023.
//

import Foundation
import UIKit
import SnapKit

final class GeneralCollectionViewCell: UICollectionViewCell {
    
    //MARK: - GUIVariables
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "image") ?? UIImage.add
        
        return view
    }()
    private lazy var blackView: UIView = {
       let view = UIView()
        
        view.backgroundColor = .black
        view.alpha = 0.5
        
        return view
    }()
    private lazy var titleLabel: UILabel = {
       let title = UILabel()
        
        title.textColor = .white
        title.text = "Text"
        
        return title
    }()
    
    //MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    private func setUpUI() {
        addSubViews(views: [imageView, blackView, titleLabel])
        setUpConstraints()
    }
    private func setUpConstraints() {
        imageView.snp.makeConstraints { make in
            make.size.edges.equalToSuperview()
        }
        blackView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.bottom.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(blackView)
            make.leading.trailing.equalTo(blackView).offset(5)
        }
    }
}
