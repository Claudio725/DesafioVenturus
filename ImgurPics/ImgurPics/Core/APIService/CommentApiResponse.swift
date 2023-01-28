//
//  CommentApiResponse.swift
//  ImgurPics
//
//  Created by Claudio Menezes.
//

struct CommentApiResponse: Decodable {
    let data: [CommentData]?
}

struct CommentData: Decodable {
    let author: String?
    let comment: String?
}
