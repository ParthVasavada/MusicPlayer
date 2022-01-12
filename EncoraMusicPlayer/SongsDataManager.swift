//
//  SongsDataManager.swift
//  EncoraMusicPlayer
//
//  Created by Parth Vasavada on 10/04/21.
//

import Foundation

class SongsDataManager {
    
    //MARK: - private methods
    private lazy var networkRequestManager = NetworkCallManager()
    private var items = [SongModel]()
    private var currentSong: SongModel? = nil
    
    /* Return the list of iTuneItems parsed from the XML retrieve from the server
     
     - Parameters completionHandler: A Closure with is called once the list of song items are loaded
     */
    func fetchTopSongs(_ completionHandler: @escaping (Result<[SongModel], AppConnectionStatus>) -> Void ) {
        guard let url = URL(string: Constants.songsURL) else {
            completionHandler(.failure(.badURL))
            return }
        networkRequestManager.getSongsList(for: url) { responseResult in
            switch responseResult {
            case .success(let xmlString):
                let xmlParser = EncoraXMLParser(xmlString: xmlString, xmlDelegate: self)
                
                xmlParser.addPaths(paths: Constants.XMLPaths)
                xmlParser.parse()
                completionHandler(.success(self.items))
            case .failure(let status):
                completionHandler(.failure(status))
                
            }
        }
    }
}

//MARK: - XMLDelegate
extension SongsDataManager: XMLDelegate  {
    
    /* Here is where the iTuneItems are populated and stored in the internal array
     
     - Parameters:
        -   parser: The EncoraXMLParser object doing the work
        -   path: The path in the XML where this data was read
        -   id: The path id which should be mapped to a member in the iTuneItems calss
        -   string: The actual data
     */
    func didEncounterPath(parser: EncoraXMLParser, path: String, id: Any, string: String) {
        
        if let song = self.currentSong {
            
            switch id as! Constants.XMLItem {
            case .entryName:
                song.title = string
            default:
                break
            }
        }
    }
    
    /* Here is where the iTuneItems are populated and stored in the internal array
     
     - Parameters:
        -   parser: The EncoraXMLParser object doing the work
        -   path: The path in the XML where this data was read
        -   id: The path id which should be mapped to a member in the iTuneItems calss
        -   string: - The actual data
        -   attributes: - The attributes for this element
     */
    func didEncounterPath(parser: EncoraXMLParser, path: String, id: Any, string: String, attributes: [String : String]) {
        
        if let song = self.currentSong {
            switch id as! Constants.XMLItem {
                case .entryArt:
                    song.songInfoURL = string
                case .entryPreview:
                    song.songURL = attributes[Constants.hrefKey]
                case .entryImage:
                    if attributes[Constants.heightKey] == Constants.imageHeight {
                        song.imageURL = string
                    }
                case .entryArtist:
                    song.artist = string
                default:
                    break
            }
        }
    }
    
    // called at the start of a new element
    func didStartElement( parser: EncoraXMLParser, element: String ) {
        if element == Constants.entryElement {
            self.currentSong = SongModel()
        }
    }
    
    // called at the end of a new element
    func didEndElement( parser: EncoraXMLParser, element: String ) {
        if element == Constants.entryElement, let currentItem = self.currentSong {
            self.items.append(currentItem)
            self.currentSong = nil
        }
    }
    
    // Error processing, should have this happen
    func parse(_ parser: EncoraXMLParser, _ error: Error) {
        print( "\(#function)" )
    }
    
    // Error processing, should have this happen
    func validation(_ parser: EncoraXMLParser, _ error: Error) {
        print( "\(#function)" )
    }
}
