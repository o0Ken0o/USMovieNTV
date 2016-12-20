//
//  Utilities.swift
//  MovieNTV
//
//  Created by Ken Siu on 20/12/2016.
//  Copyright © 2016 Ken Siu. All rights reserved.
//

import Foundation

class Utilities {
    func checkImageExistence(imagePath: String) -> String? {
        if let docPath = getDocumentDirectory() {
            let imageFullPath = "\(docPath)/\(imagePath)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            if FileManager.default.fileExists(atPath: imageFullPath!) {
                return imageFullPath
            }
        }
        
        return nil
    }
    
    func getDocumentDirectory() -> String? {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    }
}
