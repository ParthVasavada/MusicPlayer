//
//  SongsListViewModel.swift
//  EncoraMusicPlayer
//
//  Created by Parth Vasavada on 09/04/21.
//

import Foundation
import UIKit

class SongsListViewModel: NSObject {
    
    /// Data binding object to update UI from viewmodel.
    var updateUI: (() -> Void)?
    
    /// An array of top songs.
    var topSongsList: [Song] = [Song]() {
        didSet {
            DispatchQueue.main.async {
                self.updateUI?()
            }
        }
    }
    
    override init() {
        super.init()
        self.fetchSongsList()
    }
    
    private func fetchSongsList() {
        
        let allSongs = CoreDataManager.fetchAllData()
        if !allSongs.isEmpty {
            self.topSongsList = allSongs
        }
        else {
            let  songsManager = SongsDataManager()
            songsManager.fetchTopSongs { response in
                switch response {
                case .success(let songs):
                    CoreDataManager.insertDataToCoreData(songs) { isSaved in
                        self.topSongsList = CoreDataManager.fetchAllData()
                    }
                    
                case .failure(let status):
                    print(status)
                }
            }
        }
    }
    
    
    func getImage(for url: URL, completion: @escaping ( (UIImage) -> Void )) {
        
        NetworkCallManager().downloadImage(for: url) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(_):
                guard let placeholderImage = UIImage(named: Constants.placeholderImageName) else { return }
                completion(placeholderImage)
                
            }
            
        }
        
    }
}
