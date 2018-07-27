//
//  FIlterViewController.swift
//  PhotoApp
//
//  Created by Spence on 7/27/18.
//  Copyright © 2018 Maya and Delaney. All rights reserved.
//

import UIKit
import CoreImage

class FIlterViewController: UIViewController {

    @IBOutlet weak var filterImage: UIImageView!
    @IBAction func sepia(_ sender: Any) {
        let context = CIContext()
        let filter = CIFilter(name: "CISepiaTone")!
        filter.setValue(0.8, forKey: kCIInputIntensityKey)
        let image = CIImage(image: filterImage.image!)
        filter.setValue(image, forKey: kCIInputImageKey)
        let result = filter.outputImage!
        let cgImage = context.createCGImage(result, from: result.extent)
            
        let filteredImage = UIImage(cgImage: cgImage!)
        let newImage = UIImage(cgImage: (filteredImage.cgImage!), scale: (filteredImage.scale), orientation: .right)
        filterImage.image = newImage
    }
    
    @IBAction func halftone(_ sender: Any) {
        let context = CIContext()
        let image = CIImage(image: filterImage.image!)
        let filter = CIFilter(name: "CICMYKHalftone")!
        filter.setValue(image, forKey: kCIInputImageKey)
        filter.setValue(25, forKey: kCIInputWidthKey)
        filter.setValue(image, forKey: kCIInputImageKey)
        let result = filter.outputImage!
        let cgImage = context.createCGImage(result, from: result.extent)
        
        let filteredImage = UIImage(cgImage: cgImage!)
        let newImage = UIImage(cgImage: (filteredImage.cgImage!), scale: (filteredImage.scale), orientation: .right)
        filterImage.image = newImage
    }
    
    @IBAction func noir(_ sender: Any) {
        let context = CIContext()
        let filter = CIFilter(name: "CIPhotoEffectNoir")!
        //filter.setValue(0.8, forKey: kCIInputIntensityKey)
        let image = CIImage(image: filterImage.image!)
        filter.setValue(image, forKey: kCIInputImageKey)
        let result = filter.outputImage!
        let cgImage = context.createCGImage(result, from: result.extent)
        
        let filteredImage = UIImage(cgImage: cgImage!)
        let newImage = UIImage(cgImage: (filteredImage.cgImage!), scale: (filteredImage.scale), orientation: .right)
        filterImage.image = newImage
    }
    
    @IBAction func save(_ sender: Any) {
        saveImage(imageName: "test.png")
    }
    
    func saveImage(imageName: String) {
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        
        let image = filterImage.image!
        let imageData = UIImagePNGRepresentation(image)
        fileManager.createFile(atPath: imagePath as String, contents: imageData, attributes: nil)
    }
    
    func getImage(imageName: String) {
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: imagePath) {
            let image = UIImage(contentsOfFile: imagePath)
            let newImage = UIImage(cgImage: (image?.cgImage!)!, scale: (image?.scale)!, orientation: .right)
            filterImage.image = newImage
        }
        else {
            print("Oh no! No Image!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage(imageName: "test.png")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
