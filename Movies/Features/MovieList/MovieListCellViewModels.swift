//
//  MovieListCellViewModels.swift
//  Movies
//
//  Created by Sindhu on 01/06/22.
//

import Foundation

protocol MovieCellVMRepresentable {
    var rowType: MovieRowType { get }
}

enum MovieRowType {
    case movie
}

struct MovieCellViewModel: MovieCellVMRepresentable {
    let rowType: MovieRowType
    let imdbId: String
    let title: String
    let type: String?
    let year: String
    let poster: String?
}
