//
//  SongsListDataSource.swift
//  EncoraMusicPlayer
//
//  Created by Parth Vasavada on 09/04/21.
//

import Foundation
import UIKit

extension SongsListViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.topSongsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let songCell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.identifier, for: indexPath) as? SongTableViewCell,
              let songTitle = self.topSongsList[indexPath.row].title,
              let imageURLString = self.topSongsList[indexPath.row].imageURL,
              let imageURL = URL(string: imageURLString) else {
            fatalError("Unable to deque Song cell.")
        }
        
        songCell.setSongTitle(title: songTitle)
        
        if let image = self.topSongsList[indexPath.row].image {
            songCell.setSongImage(image:image)
        } else {
            
            self.getImage(for: imageURL) { songImage in
                songCell.setSongImage(image: songImage)
                
                self.topSongsList[indexPath.row].imageData = songImage.jpegData(compressionQuality: 1.0)
                try? self.topSongsList[indexPath.row].managedObjectContext?.save()
            }
        }
        
        return songCell
    }
    
}
