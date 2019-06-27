//
//  Firebase+Ext.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 06. 27..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit
import Firebase

extension Storage {
    
    // Add profileimage
    static func saveProfileImage(data: Data, completion: @escaping (String) -> Void) {
        let imageRef = Storage.storage().reference(withPath: "profile_images").child(UUID().uuidString)
        imageRef.putData(data, metadata: nil) { (metadata, error) in
            if let error = error {
                print("Error in saving file:", error)
                return
            }
            imageRef.downloadURL(completion: { (url, error) in
                if let error = error {
                    print("Error in saving file:", error)
                    return
                }
                guard let url = url else{return}
                completion(url.absoluteString)
            })
        }
    }
}
