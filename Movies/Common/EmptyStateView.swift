//
//  EmptyStateView.swift
//  Movies
//
//  Created by Sindhu on 01/06/22.
//

import UIKit

final class EmptyStateView: UIView {
    private let contentStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentStackView.addArrangedSubviews(imageView, titleLabel, subTitleLabel)
        addSubview(contentStackView)

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            contentStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func configureView(state: EmptyStateType) {
        imageView.image = state.image
        titleLabel.text = state.title
        subTitleLabel.text = state.subTitle
    }
}

extension EmptyStateView {
    enum EmptyStateType {
        case emptyList

        var image: UIImage? {
            switch self {
            case .emptyList:
                return UIImage(systemName: "magnifyingglass")
            }
        }

        var title: String {
            switch self {
            case .emptyList:
                return "No Movies found for searched criteria"
            }
        }

        var subTitle: String {
            switch self {
            case .emptyList:
                return "Please search again."
            }
        }
    }
}
