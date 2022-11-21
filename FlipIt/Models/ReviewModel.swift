//
//  ReviewModel.swift
//  FlipItApp
//
//  Created by ashutosh on 14/09/22.
//
import SwiftUI

struct ReviewModel : Identifiable{
    var id = UUID()
    var user : String
    var rating : Int
    var date : String
    var reviewMessage : String
    var profileImage : Image
}
