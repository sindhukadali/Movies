//
//  MovingListingViewModel.swift
//  Movie
//
//  Created by Sindhu on 01/06/22.
//


import UIKit

final class MovieDetailsTVC: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLbl: UILabel!
    @IBOutlet private weak var moviewTypeLbl: UILabel!
    @IBOutlet private weak var movieYearLbl: UILabel!

    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func configure(from model: MovieCellViewModel) {
        self.movieTitleLbl.text = model.title
        self.moviewTypeLbl.text = model.type
        self.movieYearLbl.text = model.year

        if let poster = model.poster,
           let posterUrl = URL(string: poster) {
           
        }
    }
}
