//
//  ViewController.swift
//  PhotoMatic
//
//  Created by Thomas Vandegriff on 2/14/19.
//  Copyright © 2019 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    //TODO: Insert your API Key here
    private let APIKey = "1cb34e6cefb9e60677d9d0df41d0891e"
    private let baseURLString = "https://api.flickr.com/services/rest"
    private let flickrMethod = "flickr.interestingness.getList"
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    var photos: [Photo] = []
    
    enum PhotoFetchResult {
        case success([Photo])
        case failure(Error)
    }
    
    enum ImageFetchResult {
        case success(UIImage)
        case failure(Error)
    }
    
    enum FlickrAPIError: Error {
        case invalidJSONData
    }
    
    enum ImageRequestError: Error {
        case imageCreationError
    }
    
    
    
    //MARK: View lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        collectionView.dataSource = self
        collectionView.delegate = self
        
         reloadDataSource()
    }
    
    
    //MARK: UICollectionViewDataSource delegate functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = "PhotoCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                               for: indexPath) as! PhotoCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        let photo = photos[indexPath.row]
        
        // Download the image data...
        activityIndicator.startAnimating()
        self.fetchImage(for: photo, completion: { (result) -> Void in
            
            
            guard let photoIndex = self.photos.index(where: { $0 === photo }),
                case let .success(image) = result else {
                    return
            }
            
            self.activityIndicator.stopAnimating()
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            
            // Update  cell when the request finishes
            if let cell = self.collectionView.cellForItem(at: photoIndexPath)
                as? PhotoCell {
                cell.updateCell(with: image)
            }
        })
    }


     //MARK: Network calls and JSON processing functions
    
    private func reloadDataSource() {
        
        self.fetchPhotos {
            (photoFetchResult) -> Void in
            
            switch photoFetchResult {
            case let .success(photos):
                self.photos = photos
            case let .failure(error):
                self.photos.removeAll()
                print("Error fetching recent Photos: \(error)")
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    func processImageRequest(data: Data?, error: Error?) -> ImageFetchResult {
        
        guard
            let imageData = data,
            let image = UIImage(data: imageData) else {
                
                // Could not create an image from data
                if data == nil {
                    return .failure(error!)
                } else {
                    return .failure(ImageRequestError.imageCreationError)
                }
        }
        
        return .success(image)
    }
    
    func fetchImage(for photo: Photo, completion: @escaping (ImageFetchResult) -> Void) {
        
        guard let photoURL = photo.remoteURL else {
            preconditionFailure("Photo expected to have a remote URL.")
        }
        
        let request = URLRequest(url: photoURL)
        
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            let result = self.processImageRequest(data: data, error: error)
            
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    private func urlBuilder(parameters: [String:String]?) -> URL {
        var components = URLComponents(string: baseURLString)!
        
        var queryItems = [URLQueryItem]()
        
        let baseParams = [
            "method": flickrMethod,
            "format": "json",
            "nojsoncallback": "1",
            "api_key": APIKey
        ]
        
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems
        
        return components.url!
    }
    
    func fetchPhotos(completion: @escaping (PhotoFetchResult) -> Void) {
        
        let url = urlBuilder(parameters: ["extras": "url_h,date_taken"])

        let request = URLRequest(url: url)
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            
            let result = self.processPhotoFetchRequest(data: data, error: error)
            
            OperationQueue.main.addOperation {
                completion(result)
            }
        })
        task.resume()
    }
  
    private func processPhotoFetchRequest(data: Data?, error: Error?) -> PhotoFetchResult {
        
        guard let jsonData = data else {
            return .failure(error!)
        }
        return self.photoItems(fromJSON: jsonData)
    }
    
    func photoItems(fromJSON data: Data) -> PhotoFetchResult {
        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard
                let jsonDict = jsonObject as? [AnyHashable:Any],
                let photos = jsonDict["photos"] as? [String:Any],
                let photosArray = photos["photo"] as? [[String:Any]] else {
                    
                    // The JSON structure is not correct
                    return .failure(FlickrAPIError.invalidJSONData)
            }
            
            var processedPhotos = [Photo]()
            
            for jsonPhoto in photosArray {
                if let photo = createPhotoItem(fromJSON: jsonPhoto ) {
                    processedPhotos.append(photo)
                }
            }
            
            if processedPhotos.isEmpty && !photosArray.isEmpty {
                // unable to parse Photo items. Maybe the JSON formatting has changed
                return .failure(FlickrAPIError.invalidJSONData)
            }
            return .success(processedPhotos)
        } catch let error {
            return .failure(error)
        }
    }
    
    private func createPhotoItem(fromJSON json: [String : Any]) -> Photo? {
        
        guard
            let title = json["title"] as? String,
            let dateAsString = json["datetaken"] as? String,
            let photoID  = json["id"] as? String,
            let photoUrlAsString = json["url_h"] as? String,
            let url = URL(string: photoUrlAsString),
            let dateTaken = dateFormatter.date(from: dateAsString) else {
                // Not enough info to construct a PhotoItem
                return nil
        }
        return Photo(title: title, dateTaken: dateTaken as NSDate, photoID: photoID, remoteURL: url)
    }
}

