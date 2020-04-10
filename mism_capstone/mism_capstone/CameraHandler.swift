//
//  CameraHandler.swift
//  mism_capstone
//
//  Created by Tanner Morse on 3/24/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import UIKit

class CameraHandler: NSObject {
    
    static let shared = CameraHandler()
    
    fileprivate var currentVC: UIViewController!
    
    //MARK: Internal Properties
    var imagePickedBlock: ((UIImage) -> Void)?

    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .camera
            myPickerController.allowsEditing = true
            currentVC.present(myPickerController, animated: true, completion: nil)
        }
        
    }
    
    func openPhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            myPickerController.allowsEditing = true
            currentVC.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func presentPhotoSelectorActionSheet(vc: UIViewController) {
        currentVC = vc
        let actionSheet = UIAlertController(title: "Choose Photo", message: nil, preferredStyle: .actionSheet)
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        
        let takePhotoAction = UIAlertAction(title: "Take picture", style: .default, handler: { void in
            self.openCamera()
        })
        let pickPhotoAction = UIAlertAction(title: "Choose picture from library", style: .default, handler: { void in
            self.openPhotoLibrary()
        })
        
        if #available(iOS 13.0, *) {
            let cameraImage = UIImage(systemName: "camera")
            takePhotoAction.setValue(cameraImage, forKey: "image")
            let photoImage = UIImage(systemName: "photo")
            pickPhotoAction.setValue(photoImage, forKey: "image")
            
        } else {
            // Fallback on earlier versions
        }
        
        actionSheet.addAction(takePhotoAction)
        actionSheet.addAction(pickPhotoAction)
        actionSheet.addAction(dismissAction)
        
        currentVC.present(actionSheet, animated: true, completion: nil)
    }
    
    func imageTobase64(image: UIImage) -> String {
        var base64String = ""
        let  cim = CIImage(image: image)
        if (cim != nil) {
            let imageData = image.highQualityJPEGNSData
            base64String = imageData.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
        }
        return base64String
    }
    
    func base64ToImage(base64: String) -> UIImage {
        var img: UIImage = UIImage()
        if (!base64.isEmpty) {
            if let decodedData = Data(base64Encoded: base64 , options: NSData.Base64DecodingOptions.ignoreUnknownCharacters) {
                let decodedimage = UIImage(data: decodedData)
                img = (decodedimage as UIImage?)!
            }
            
        }
        return img
    }
    
    func uploadImageToS3(image: UIImage, controllerId: String, valveId: Int) {
        
        if let token = UserDefaults.standard.string(forKey: "authToken"){
            if let url = URL(string: "https://0z02zemtz2.execute-api.us-east-2.amazonaws.com/Development/images") {
                
                var request = URLRequest(url: url, timeoutInterval: 10)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue(token, forHTTPHeaderField: "Authorizer")
                let path = "\(controllerId)/\(valveId)/image.jpg"
                //let path = "/2/2/image.jpg"

                request.httpBody = ImageData(image:"\(imageTobase64(image: image))", imagePath: path).encodedJsonBody()
                //request.httpBody = ImageData(image:"imageData", imagePath: path).encodedJsonBody()

        
                let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                    if let r = response as? HTTPURLResponse {
                        // do something like a fading pop up that says you schedule was adding
                        print(r.statusCode)
                    }
                })
                task.resume()
                
            }
        }
    }

}

extension CameraHandler: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC.dismiss(animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController,
                                        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.imagePickedBlock?(image)
        }else{
            print("Something went wrong")
        }
        currentVC.dismiss(animated: true, completion: nil)
    }
}

extension UIImage {
    var highestQualityJPEGNSData:NSData { return self.jpegData(compressionQuality: 1.0)! as NSData }
    var highQualityJPEGNSData:NSData    { return self.jpegData(compressionQuality: 0.75)! as NSData}
    var mediumQualityJPEGNSData:NSData  { return self.jpegData(compressionQuality: 0.5)! as NSData }
    var lowQualityJPEGNSData:NSData     { return self.jpegData(compressionQuality: 0.25)! as NSData}
    var lowestQualityJPEGNSData:NSData  { return self.jpegData(compressionQuality: 0.0)! as NSData }
      }
