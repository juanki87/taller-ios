//
//  Extensions.swift
//  TheMovieApp
//
//  Created by juanki on 2/17/22.
//

import Foundation
import UIKit

extension UIImageView {
    
    func uploadFromServer(urlString: String, placeHolderImage: UIImage) {
        if self.image == nil  {
            self.image = placeHolderImage
        }
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            if (error != nil) {
                return
            }
            DispatchQueue.main.async {
                guard let data = data else {return}
                let image = UIImage(data: data)
                self.image = image
            }
        }.resume()
    }
    
}
