//
//  Global.swift
//  ListSearch_Task
//
//  Created by Admin on 12/14/20.
//

import Foundation

struct Domain {
	static let dev = "https://api.androidhive.info/"
}
extension Domain {
	static func baseUrl() -> String {
		return Domain.dev
	}
}

struct APIEndpoint {
	static let movies         = "json/movies.json"
}


enum HTTPHeaderField: String {
	case authentication  = "Authorization"
	case contentType     = "Content-Type"
	case acceptType      = "Accept"
	case acceptEncoding  = "Accept-Encoding"
	case acceptLangauge  = "Accept-Language"
}

enum ContentType: String {
	case json            = "application/json"
	case multipart       = "multipart/form-data"
	case ENUS            = "en-us"
}




struct Strings {
	static let appTitle         = "Movies"
}
