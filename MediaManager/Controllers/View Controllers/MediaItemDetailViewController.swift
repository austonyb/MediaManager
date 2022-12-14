//
//  MediaItemDetailViewController.swift
//  MediaManager
//
//  Created by Auston Youngblood on 12/14/22.
//

import UIKit

// MARK: - Protocols
protocol DeleteItemDelegate: AnyObject {
    func deleteItem(mediaItem: MediaItem)
}

class MediaItemDetailViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addToFavoritesButton: UIButton!
    @IBOutlet weak var addWatchReminderButton: UIButton!
    @IBOutlet weak var markAsWatchedButton: UIButton!
    @IBOutlet weak var deleteMediaItemButton: UIButton!
    
    
    //MARK: - Properties
    var mediaItem: MediaItem?
    weak var delegate: DeleteItemDelegate?
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Functions
    func setupViews() {
        guard let mediaItem = mediaItem else {
            return
        }
        
        self.titleLabel.text = mediaItem.title
        self.ratingLabel.text = String(mediaItem.rating)
        self.releaseYearLabel.text = "Released in \(mediaItem.year)"
        self.descriptionTextView.text = mediaItem.itemDescription
        descriptionTextView.isEditable = false
        
        if mediaItem.mediaType == "Movie" {
            self.deleteMediaItemButton.setTitle("Delete Movie", for: .normal)
        } else {
            self.deleteMediaItemButton.setTitle("Delete TV Show", for: .normal)
        }
        
        if mediaItem.isFavorite {
            self.addToFavoritesButton.setTitle("Remove From Favorites", for: .normal)
        } else {
            self.addToFavoritesButton.setTitle("Add To Favorites", for: .normal)
        }
        
        if mediaItem.wasWatched {
            self.markAsWatchedButton.setTitle("Mark As Unwatched", for: .normal)
        } else {
            self.markAsWatchedButton.setTitle("Mark As Watched", for: .normal)
        }
    }
    
    //MARK: - Actions
    
    @IBAction func addToFavoritesButtonTapped(_ sender: Any) {
        guard let mediaItem = mediaItem else {
            return
        }
        
        mediaItem.isFavorite = !mediaItem.isFavorite
        MediaItemController.shared.updateMediaItem()
        if mediaItem.isFavorite {
            DispatchQueue.main.async {
                self.addToFavoritesButton.setTitle("Remove From Favorites", for: .normal)
            }
        } else {
            DispatchQueue.main.async {
                self.addToFavoritesButton.setTitle("Add To Favorites", for: .normal)
            }
        }
    }
    
    @IBAction func markAsWatchedButtonTapped(_ sender: Any) {
        guard let mediaItem = mediaItem else {
            return
        }
        
        mediaItem.wasWatched = !mediaItem.wasWatched
        MediaItemController.shared.updateMediaItem()
        if mediaItem.wasWatched {
            self.markAsWatchedButton.setTitle("Mark As Unwatched", for: .normal)
        } else {
            self.markAsWatchedButton.setTitle("Mark As Watched", for: .normal)
        }
    }
    
    
    @IBAction func deleteMediaItemButtonTapped(_ sender: Any) {
        guard let mediaItem = mediaItem else {
            return
        }
        MediaItemController.shared.deleteMediaItem(mediaItem)
        delegate?.deleteItem(mediaItem: mediaItem)
        navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
