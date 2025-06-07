//
//  ColorExtension.swift
//  Netflix
//
//  Created by Sameer Nikhil on 05/06/25.
//

import SwiftUI
//import UIKit

extension UIImage {
    // Extract dominant color from image
    func dominantColor() -> UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
        
        guard let filter = CIFilter(name: "CIAreaAverageColor",  parameters: [kCIInputImageKey: inputImage,kCIInputExtentKey: extentVector]) else { return nil }
        
        guard let outputImage = filter.outputImage else { return nil }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull as Any])
        
        context.render(outputImage,
                             toBitmap: &bitmap,
                             rowBytes: 4,
                             bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                             format: .RGBA8,
                             colorSpace: nil)
        
        return UIColor(red: CGFloat(bitmap[0]) / 255,
                              green: CGFloat(bitmap[1]) / 255,
                              blue: CGFloat(bitmap[2]) / 255,
                              alpha: CGFloat(bitmap[3]) / 255)
    }
}
