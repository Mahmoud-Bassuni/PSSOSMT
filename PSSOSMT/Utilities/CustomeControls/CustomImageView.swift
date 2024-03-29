
import UIKit

let imageCache = NSCache<NSString, UIImage>()
class  CustomImageView: UIImageView {
    var imageUrlString: String?
    func loadImageUsingUrlString(urlString: String) {
        imageUrlString = urlString
        guard let urlwithPercentEscapes = urlString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: urlwithPercentEscapes) else { return }
        image = nil
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, respones, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                guard (imageToCache != nil) else { return}
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
            }
        }).resume()
    }

}



