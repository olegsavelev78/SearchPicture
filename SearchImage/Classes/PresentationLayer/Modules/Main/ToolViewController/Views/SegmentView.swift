//
//  SegmentView.swift
//  SearchImage
//
//  Created by Олег Савельев on 15.07.2022.
//

import UIKit

enum SegmentType {
    case country(Int), language(Int), size(Int)
    
    var labelText: String {
        switch self {
        case .country:
            return "Сhoose a country:"
        case .language:
            return "Choose language:"
        case .size:
            return "Size:"
        }
    }
    
    var itemsSegment: [String] {
        switch self {
        case .country:
            return ["defualt", "China","USA", "Russia"]
        case .language:
            return ["defualt", "Russian", "Armenian", "English"]
        case .size:
            return ["defualt", "large","medium", "smale"]
        }
    }
}

final class SegmentView: UIView {
    // MARK: - UI
    private lazy var label = UILabel().apply {
        $0.font = UIFont.font(ofSize: 15, weight: .light)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.text = "Сhoose a country:"
    }
    
    private lazy var segment = UISegmentedControl().apply {
        $0.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
    }
    
    public var changeValue = PublishedAction<Int>()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    func configure(type: SegmentType) {
        type.itemsSegment.enumerated().forEach {
            segment.insertSegment(withTitle: $0.element,
                                  at: $0.offset,
                                  animated: false)
        }
        label.text = type.labelText
        
        switch type {
        case let .country(index):
            segment.selectedSegmentIndex = index
        case let .language(index):
            segment.selectedSegmentIndex = index
        case let .size(index):
            segment.selectedSegmentIndex = index
        }
    }
    
    @discardableResult
    func layout() -> CGFloat {
        label.pin
            .top()
            .left(30)
            .sizeToFit()
        
        segment.pin
            .below(of: label)
            .marginTop(20)
            .horizontally()
            .height(35)
        
        return segment.frame.maxY
    }
    
    // MARK: - Private
    @objc
    private func segmentedControlChanged(sender: UISegmentedControl) {
        changeValue.send(sender.selectedSegmentIndex)
    }
    
    private func addSubviews() {
        [label, segment].forEach {
            addSubview($0)
        }
    }
}
