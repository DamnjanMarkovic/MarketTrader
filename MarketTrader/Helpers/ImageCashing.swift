//
//  ImageCashing.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 12.6.21..
//
import UIKit

class ImageCashing {

    private init() {}
    
    static var imageCache = [String: UIImage]()
}

extension UIImageView {
    
    
    func loadImage(with urlString: String) {

        if let cachedImage = ImageCashing.imageCache[urlString] {
            self.image = cachedImage
            return
            
        }

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let error = error {
                print("Failed to load image with error", error.localizedDescription)
                return
            }

            guard let imageData = data else { return }

            let photoImage = UIImage(data: imageData)

            ImageCashing.imageCache[url.absoluteString] = photoImage

            DispatchQueue.main.async {
                self.image = photoImage
            }

        }.resume()

    }
    
    
}

extension UIView {

    func copyObject<T: UIView> () -> T? {
        let archivedData = NSKeyedArchiver.archivedData(withRootObject: self)
        return NSKeyedUnarchiver.unarchiveObject(with: archivedData) as? T
    }
}

extension UIImage {

    typealias EditSubviewClosure<T: UIView> = (_ parentSize: CGSize, _ viewToAdd: T)->()

    func with<T: UIView>(view: T, editSubviewClosure: EditSubviewClosure<T>) -> UIImage {

        if let copiedView = view.copyObject() as? T {
            UIGraphicsBeginImageContext(size)

            let basicSize = CGRect(origin: .zero, size: size)
            draw(in: basicSize)
            editSubviewClosure(size, copiedView)
            copiedView.draw(basicSize)

            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage!
        }
        return self

    }
}

extension UIImageView {

    enum ImageAddingMode {
        case changeOriginalImage
        case addSubview
        case addCopiedSubview
    }

    func drawOnCurrentImage<T: UIView>(view: T, mode: ImageAddingMode, editSubviewClosure: @escaping UIImage.EditSubviewClosure<T>) {

        guard let image = image else {
            return
        }

        let addSubView: (T) -> () = { view in
            editSubviewClosure(self.frame.size, view)
            self.addSubview(view)
        }

        switch mode {
            case .changeOriginalImage:
                self.image = image.with(view: view, editSubviewClosure: editSubviewClosure)

            case .addSubview:
                addSubView(view)

            case .addCopiedSubview:
                if let copiedView = view.copyObject() as? T {
                    addSubView(copiedView)
                }
        }
    }
}
