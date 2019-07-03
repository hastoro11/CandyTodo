//
//  NewTaskVC.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 30..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class EditProfileVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addPhotoButton: UIButton! {
        didSet {
            addPhotoButton.layer.borderWidth = 3
            addPhotoButton.layer.borderColor = kBASEBLUE_COLOR.cgColor
            addPhotoButton.layer.cornerRadius = 90
            addPhotoButton.layer.masksToBounds = true
        }
    }
    
    //MARK: - vars
    var addButton: MiddleButton = {
        let btn = MiddleButton()
        btn.setImage(UIImage(named: "check"), for: .normal)
        return btn
    }()
    var user: User?

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addButton.frame = CGRect(x: (view.bounds.width - 80) / 2, y: view.bounds.height - 40 - 72, width: 80, height: 72)
    }
    
    func configure() {
        view.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        nameTextField.text = user?.username
        emailTextField.text = user?.email
        guard let profileImageURL = user?.profileImageURL else {return}
        addPhotoButton.sd_setBackgroundImage(with: URL(string: profileImageURL), for: .normal, placeholderImage: UIImage(named: "add_photo"), options: [SDWebImageOptions.continueInBackground, .progressiveLoad], context: nil)
    }
    
    //MARK: - Actions
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPhotoButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func addButtonTapped() {
        guard let user = user else {return}
        guard let username = nameTextField.text else {return}
        user.username = username.isEmpty ? "(no username)" : username
        guard let imageData = addPhotoButton.backgroundImage(for: .normal)?.jpegData(compressionQuality: 0.3) else {return}
        Storage.saveProfileImage(data: imageData) { urlString in
            user.profileImageURL = urlString
            Firestore.saveUser(user: user, completion: {[unowned self] (success) in
                if !success {
                    let error = NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey : "Internal server error, please try later."])
                    error.alert(with: self)
                    return
                }
                NotificationCenter.default.post(name: NSNotification.Name(kUSER_SAVED_NOTIFICATION), object: nil)
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
}

extension EditProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            addPhotoButton.setBackgroundImage(image, for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
