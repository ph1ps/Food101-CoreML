//
//  ViewController.swift
//  Food101Prediction
//
//  Created by Philipp Gabriel on 21.06.17.
//  Copyright © 2017 Philipp Gabriel. All rights reserved.
//

import UIKit
import CoreML

extension UIImage {
    
    func resize(to newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newSize.width, height: newSize.height), true, 1.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
    
    func pixelData() -> [UInt8]? {
        let dataSize = size.width * size.height * 4
        var pixelData = [UInt8](repeating: 0, count: Int(dataSize))
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: &pixelData, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: 4 * Int(size.width), space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
        
        guard let cgImage = self.cgImage else { return nil }
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        return pixelData
    }
}

extension Food101 {
    
    func preprocess(image: UIImage) -> MLMultiArray? {
        let size = CGSize(width: 299, height: 299)
        
        
        guard let pixels = image.resize(to: size).pixelData()?.map({ (Double($0) / 255.0 - 0.5) * 2 }) else {
            return nil
        }
        
        guard let array = try? MLMultiArray(shape: [3, 299, 299], dataType: .double) else {
            return nil
        }
        
        let r = pixels.enumerated().filter { $0.offset % 4 == 0 }.map { $0.element }
        let g = pixels.enumerated().filter { $0.offset % 4 == 1 }.map { $0.element }
        let b = pixels.enumerated().filter { $0.offset % 4 == 2 }.map { $0.element }
        
        let combination = r + g + b
        for (index, element) in combination.enumerated() {
            array[index] = NSNumber(value: element)
        }
        
        return array
    }
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let model = Food101()
        
        guard let input = model.preprocess(image: #imageLiteral(resourceName: "ribs")) else {
            print("preprocessing failed")
            return
        }
        
        guard let result = try? model.prediction(image: input) else {
            print("prediction failed")
            return
        }
        
        print(result.classLabel)
        print(result.foodConfidence)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
