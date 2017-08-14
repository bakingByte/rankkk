//
//  Login.swift
//  RankAppSwift
//
//  Created by Santosh Maurya on 27/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import Foundation

class Login: NSObject, NSCoding {
    
    /*
     "created_at" = "2017-07-14 16:47:50";
     "date_of_birth" = "<null>";
     "deleted_at" = "<null>";
     email = "pintu@gmail.com";
     "facebook_id" = "<null>";
     follow = "<null>";
     followers = "<null>";
     following = "<null>";
     id = 43;
     identity = "<null>";
     name = sharma;
     password = "$2y$10$kHhxHJL78kg58xau7GjuMenInzZSm5DZz35bFt/L1nyq7Zc9ya8v2";
     pic = "<null>";
     place = "<null>";
     posts = "<null>";
     rank = "<null>";
     "remember_token" = "<null>";
     "role_id" = 2;
     "updated_at" = "2017-07-14 16:47:50";
     */
    var created_at:NSString = ""
    var date_of_birth:NSString = ""
    var deleted_at:NSString = ""
    var email:NSString = ""
    var name:NSString = ""
    var facebook_id:NSString = ""
    var follow:NSNumber = 0
    var followers:NSNumber = 0
    var following:NSNumber = 0
    var id:NSNumber = 0
    var identity:NSString = ""
    var password:NSString = ""
    var pic:NSString = ""
    var place:NSString = ""
    var posts:NSString = ""
    var rank:NSString = ""
    var remember_token:NSString = ""
    var role_id:NSNumber = 0
    var updated_at:NSString = ""


func encode(with coder: NSCoder) {
    coder.encode(created_at, forKey: "created_at")
    coder.encode(date_of_birth, forKey: "date_of_birth")
    coder.encode(deleted_at, forKey: "deleted_at")
    coder.encode(email, forKey: "email")
    coder.encode(name, forKey: "name")
    coder.encode(facebook_id, forKey: "facebook_id")
    coder.encode(follow, forKey: "follow")
    coder.encode(followers, forKey: "followers")
    coder.encode(following, forKey: "following")
    coder.encode(id, forKey: "id")
    coder.encode(identity, forKey: "identity")
    coder.encode(password, forKey: "password")
    coder.encode(pic, forKey: "pic")
    coder.encode(place, forKey: "place")
    coder.encode(posts, forKey: "posts")
    coder.encode(rank, forKey: "rank")
    coder.encode(remember_token, forKey: "remember_token")
    coder.encode(role_id, forKey: "role_id")
    coder.encode(updated_at, forKey: "updated_at")
    
    
}

required convenience init(coder decoder: NSCoder) {
    self.init()
    created_at = decoder.decodeObject(forKey: "created_at") as! NSString
    date_of_birth = decoder.decodeObject(forKey: "date_of_birth") as! NSString
    deleted_at = decoder.decodeObject(forKey: "deleted_at") as! NSString
    email = decoder.decodeObject(forKey: "email") as! NSString
    name = decoder.decodeObject(forKey: "name") as! NSString
    facebook_id = decoder.decodeObject(forKey: "facebook_id") as! NSString
    follow = decoder.decodeObject(forKey: "follow") as! NSNumber
    followers = decoder.decodeObject(forKey: "followers") as! NSNumber
    following = decoder.decodeObject(forKey: "following") as! NSNumber
    id = decoder.decodeObject(forKey: "id") as! NSNumber
    identity = decoder.decodeObject(forKey: "identity") as! NSString
    password = decoder.decodeObject(forKey: "password") as! NSString
    pic = decoder.decodeObject(forKey: "pic") as! NSString
    place = decoder.decodeObject(forKey: "place") as! NSString
    posts = decoder.decodeObject(forKey: "posts") as! NSString
    rank = decoder.decodeObject(forKey: "rank") as! NSString
    remember_token = decoder.decodeObject(forKey: "remember_token") as! NSString
    role_id = decoder.decodeObject(forKey: "role_id") as! NSNumber
    updated_at = decoder.decodeObject(forKey: "updated_at") as! NSString
}

}
