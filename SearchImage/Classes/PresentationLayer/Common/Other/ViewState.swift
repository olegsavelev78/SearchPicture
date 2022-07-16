//
//  ViewState.swift
//  SearchImage
//
//  Created by Олег Савельев on 14.07.2022.
//

import Foundation

public enum ViewState: Equatable {
    case initial
    case loading
    case refresh
    case loaded
    case error(message: String)
}
