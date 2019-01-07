//
//  SharedInfo.swift
//  
//
//  Created by Tutoring SDP on 1/1/19.
//

import Foundation
import  Parse

public class SharedInfo
{
    var currentUser = PFUser()
    init(user : PFUser)
    {
        currentUser = user
    }
    
}
