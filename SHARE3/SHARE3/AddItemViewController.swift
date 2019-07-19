//
//  AddItemViewController.swift
//  SHARE3
//
//  Created by Apple on 7/17/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var imagePicker = UIImagePickerController()
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var insertItem: UITextField!
    @IBAction func takePicture(_ sender: Any) {
        imagePicker.sourceType = .camera
    present(imagePicker, animated : true, completion : nil)
        }
    @IBAction func uploadImage(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated : true, completion : nil)
        
    }

  
    @IBAction func saveButton(_ sender: UIButton) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let saveThings = SaveItem(entity : SaveItem.entity(), insertInto:context)
            
            saveThings.caption = insertItem.text
            
            if let userImage = newImageView.image {
                if let userImageData = userImage.pngData(){
                    saveThings.addPhoto = userImageData
                }
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            navigationController?.popViewController(animated : true)
    }
    }
        internal func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                newImageView.image = selectedImage
            }
            imagePicker.dismiss(animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
                
            }

