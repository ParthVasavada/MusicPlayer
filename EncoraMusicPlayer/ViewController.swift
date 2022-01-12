//
//  ViewController.swift
//  EncoraMusicPlayer
//
//  Created by Parth Vasavada on 09/04/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var songTableView: UITableView! {
        didSet {
            self.songTableView.register(UINib.init(nibName: SongTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: SongTableViewCell.identifier)
        }
    }
    
    private let viewModel = SongsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.appTitle
        self.songTableView.dataSource = self.viewModel
        self.songTableView.delegate = self
        
        self.viewModel.updateUI = {
            self.songTableView.reloadData()
        }
        
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let songDetailVC = self.storyboard?.instantiateViewController(identifier: SongDetailsViewController.storyboardID) as? SongDetailsViewController else {
            return
        }
        
        songDetailVC.selectedSong = self.viewModel.topSongsList[indexPath.row]
        self.navigationController?.pushViewController(songDetailVC, animated: true)
    }
}

