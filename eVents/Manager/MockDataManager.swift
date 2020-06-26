//
//  MockDataManager.swift
//  eVents
//
//  Created by Kartikeya Saxena Jain on 6/24/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import Foundation

class MockDataManager {
    
    // MARK: - Singelton
    static var shared = MockDataManager()
    private init() {}
    
    public func getEvents(for fileName: String ,completion: @escaping (Result<[Event], EVDataError>) -> Void){
        let file = fileName.components(separatedBy: ".")
        guard let name = file.first, !name.isEmpty else {
            completion(.failure(.fileNameIssue))
            return
        }
        
        guard let type =  file.last else {
            completion(.failure(.fileTypeIssue))
            return
        }
        
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            completion(.failure(.badPath))
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        guard let data = try? Data(contentsOf: url) else {
            completion(.failure(.badData))
            return
        }
        
        let decoder = JSONDecoder()
        do {
            let events = try decoder.decode([Event].self, from: data)
            completion(.success(events))
        } catch {
            completion(.failure(.decodeError))
        }
    }
}
