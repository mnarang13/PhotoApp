//
//  ViewController.swift
//  PhotoApp
//
//  Created by Spence on 7/27/18.
//  Copyright © 2018 Maya and Delaney. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var imagePickerController: UIImagePickerController!
    @IBOutlet weak var image1: UIImageView!
    
    
    @IBAction func camera(_ sender: UIButton) {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        saveImage(imageName: "test.png")
    }
    
    func saveImage(imageName: String) {
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask,
            true)[0] as NSString).appendingPathComponent(imageName)
        
        let image = image1.image!
        let imageData = UIImagePNGRepresentation(image)
        fileManager.createFile(atPath: imagePath as String, contents: imageData, attributes: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePickerController.dismiss(animated: true, completion: nil)
        image1.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

