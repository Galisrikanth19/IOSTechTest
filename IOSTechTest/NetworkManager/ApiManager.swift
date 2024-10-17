//
//  ApiManager.swift
//  Created by GaliSrikanth on 16/10/24.

import Foundation

class ApiManager {
    static let shared = ApiManager()
    private init() {}
    
    func request<T: Codable>(WithUrlStr urlStr: String,
                             WithRequestType requestType: RequestType) async throws -> T {
        guard let urlIs = URL(string: urlStr) else {
            throw ApiErrors.invalidUrl
        }
        
        var urlRequest = URLRequest(url: urlIs)
        urlRequest.httpMethod = requestType.value
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        if let httpURLResponse = response as? HTTPURLResponse,
           httpURLResponse.statusCode == 200 {
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                return decodedResponse
            } catch {
                throw ApiErrors.decodingError
            }
        } else {
            throw ApiErrors.invalidResponse
        }
    }
}
