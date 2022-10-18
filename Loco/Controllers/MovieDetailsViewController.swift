//
//  MovieDetailsViewController.swift
//  Loco
//
//  Created by Sanket  Ray on 16/10/22.
//

import UIKit

class MovieDetailsViewController: BaseViewController {
    
    
    // MARK: - Outlets
    @IBOutlet private var posterImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var releaseDateLabel: UILabel!
    @IBOutlet private var directorLabel: UILabel!
    @IBOutlet private var plotLabel: UILabel!
    
    
    // MARK: - Variables
    private var movie: Movie? {
        didSet {
            
            // Update UI
            updateUI()
        }
    }
    
    
    // MARK: - Lifecycle Methods
    public convenience init(movie: Movie) {
        self.init()
        
        // Set Movie
        self.movie = movie
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        posterImageView.layer.cornerRadius = 8
        posterImageView.layer.cornerCurve = .continuous
        
        // Fetch Movie Details
        fetchMovieDetails()
    }
    
    
    // MARK: - Helper Methods
    /// This method fetches the details of the movie object passed to us during initialization
    private func fetchMovieDetails() {
        
        // Validation & Create URL
        guard let movie = movie,
              let url = URL(string: "https://www.omdbapi.com/?i=\(movie.imdbId)&apikey=17c5b420") else { return }
        
        // Show Loader
        showLoader()
        
        // Get Movie Details
        APIService.getData(requestUrl: url, resultType: Movie.Details.self) { [weak self] (result) in
            
            switch result {
            case .success(let response):
                
                // Set Movie Details
                self?.movie?.details = response
                
                // Hide Loader
                self?.hideLoader()
                
            case .failure(let error):
                
                // Hide Loader
                self?.hideLoader()
                
                // Handle Erorr Message
                self?.handleError(error)
            }
        }
    }
    
    /// This method takes care of updating the UI, once the movie object is updated
    private func updateUI() {
        
        DispatchQueue.main.async { [weak self] in
            
            // Validation
            guard let self = self,
                  let movie = self.movie else { return }
            
            // Load Image
            self.posterImageView.loadImage(urlString: movie.posterImageUrlString)
            
            // Set Title
            self.titleLabel.text = movie.title
            
            // Set Movie Details
            if let releaseDate = movie.details?.released {
                
                // Set Released Date
                self.releaseDateLabel.text = "Released on: " + releaseDate
            }
            
            if let director = movie.details?.director {
                
                // Set Director
                self.directorLabel.text = "Directed by: " + director
            }
            
            if let plot = movie.details?.plot {
                
                // Set Plot
                self.plotLabel.text = "Plot: " + plot
            }
        }
    }
}
