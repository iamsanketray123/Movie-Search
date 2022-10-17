//
//  MovieCell.swift
//  Loco
//
//  Created by Sanket  Ray on 16/10/22.
//

import UIKit

final class MovieCell: UITableViewCell {
    
    
    // MARK: - Outlets
    @IBOutlet private var posterImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    
    
    // MARK: - Lifecycle Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Reset Values Before Reuse
        posterImageView.image = UIImage()
        titleLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        posterImageView.layer.cornerRadius = 4
        posterImageView.layer.cornerCurve = .continuous
    }
    
    
    // MARK: - Helper Methods
    public func setMovieData(movie: Movie) {
        
        // Set Details
        posterImageView.loadImage(urlSting: movie.posterImageUrlString)
        titleLabel.text = movie.title
    }
    
    public static func nib() -> UINib {
        UINib(nibName: identifier(), bundle: nil)
    }
    
    public static func identifier() -> String {
        return String(describing: self)
    }
}
