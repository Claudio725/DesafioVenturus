//
//  InfoPictureApiResponse.swift
//  ImgurPics
//
//  Created by Claudio Menezes
//

struct InfoPictureApiResponse: Decodable {
    let data: InfoData?
}

struct InfoData: Decodable {
    let type: String?
    let height: Int?
    let width: Int?
    let views: Int?
}
