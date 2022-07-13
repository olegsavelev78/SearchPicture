//
//  ImageCell.swift
//  SearchImage
//
//  Created by Олег Савельев on 13.07.2022.
//

import UIKit
import PinLayout

final class ImageCell: LoadableCollectionViewCell {
    
    // MARK: - UI
    private lazy var imageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .red
    }
    
    // MARK: - Setup
    override func setup() {
        contentView.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    // MARK: - Layout
    private func layout() {
        imageView.pin.all()
    }
}
