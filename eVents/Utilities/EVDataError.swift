//
//  EVDataError.swift
//  eVents
//
//  Created by Kartikeya Saxena Jain on 6/24/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

// MARK: - Error
enum EVDataError: String, Error {
    case fileNameIssue  = "Seems like you got the file name wrong - try File.type format"
    case fileTypeIssue  = "Seems like you got the file type wrong - try File.type format"
    case badPath        = "Failed to locate file in bundle."
    case badData        = "Failed to load file from bundle."
    case decodeError    = "We tried to decode the data you needed, but failed. Oops :("
}
