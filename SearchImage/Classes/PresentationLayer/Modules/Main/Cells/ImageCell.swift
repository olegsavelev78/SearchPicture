//
//  ImageCell.swift
//  SearchImage
//
//  Created by Олег Савельев on 13.07.2022.
//

import UIKit
import PinLayout
import Kingfisher

final class ImageCell: LoadableCollectionViewCell {
    
    // MARK: - UI
    private lazy var imageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFill
    }
    
    // MARK: - Setup
    override func setup() {
        contentView.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
        layout()
    }
    
    func configure(model: PictureModel) {
        guard let url = URL(string: model.thumbnail) else { return }
        imageView.kf.setImage(with: url)
    }
    
    // MARK: - Layout
    private func layout() {
        imageView.pin.all()
    }
}
