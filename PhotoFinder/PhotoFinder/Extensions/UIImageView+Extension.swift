//
//  UIImageView+Extension.swift
//  PhotoFinder
//
//  Created by Martin Balbas, Juan Santiago (Cognizant) on 11/29/17.
//  Copyright © 2017 Martin Balbas, Juan Santiago (Cognizant). All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUrl(_ urlString: String?, placeholder: UIImage?) {
        if let placeholder = placeholder {
            image = placeholder
        }
        
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        
        // Check if the image is already cached
        if let image = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = image
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse else { return }
            
            // Check status code
            if httpURLResponse.statusCode != 200 {
                print("Error downloading image: \(urlString).\nCode: \(httpURLResponse.statusCode)")
                return
            }
            
            // Check error
            if let error = error {
                print("Error downloading image: \(urlString).\nError: \(error.localizedDescription)")
                return
            }
            
            if let data = data,
                let image = UIImage(data: data) {
                
                // Save image in cache
                imageCache.setObject(image, forKey: urlString as AnyObject)
                
                DispatchQueue.main.async() { [weak self] in
                    // Update the UI
                    self?.image = image
                }
            }
        }.resume()
    }
    
}
