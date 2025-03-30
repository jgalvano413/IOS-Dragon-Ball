//
//  ServicesAPI.swift
//  DBZ Wiki
//
//  Created by Luis Galvan on 30/03/25.
//

// APIService.swift
import Foundation
import Foundation

class APIService {
    let URL_BASE = "https://www.dragonball-api.com/api/character"
    
    
    func fetchCharacter(numberPerson: String, completion: @escaping (Result<DBZCharacter, Error>) -> Void) {
        guard let url = URL(string: "\(URL_BASE)/\(numberPerson)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "Data is null", code: 1001, userInfo: nil)))
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Response Code: \(httpResponse.statusCode)")
                print("Response Headers: \(httpResponse.allHeaderFields)")
            }

    
            do {
                let character = try JSONDecoder().decode(DBZCharacter.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(character))
                }
            } catch {
                print("Error Decodificando JSON: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    
    func fetchCharacters(completion: @escaping (Result<allCharacter, Error>) -> Void) {
        guard let url = URL(string: "https://dragonball-api.com/api/characters?limit=58") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)

        session.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "Data is null", code: 1001, userInfo: nil)))
                }
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Response Code: \(httpResponse.statusCode)")
                print("Response Headers: \(httpResponse.allHeaderFields)")
            }

            do {
                let characters = try JSONDecoder().decode(allCharacter.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(characters))
                }
            } catch {
                print("Error Decodificando JSON: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }

}
