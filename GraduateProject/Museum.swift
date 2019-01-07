//
//  Museum.swift
//  GraduateProject
//
//  Created by 유주원 on 06/11/2018.
//  Copyright © 2018 유주원. All rights reserved.
//

import Foundation
import UIKit

struct Museum{
    var name: String
    var photo: UIImage
    var place: String
    
    init?(name: String, photo: UIImage, place: String){
        guard !name.isEmpty else {return nil}
        self.name = name
        self.photo = photo
        self.place = place
    }
}
