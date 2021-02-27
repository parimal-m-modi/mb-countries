//
//  Province.swift
//  MBCountries
//
//  Created by Parimal Modi on 27/02/21.
//

struct Province: Codable {
    let id: Int
    let countryCode: String
    let code: String
    let name: String
    
    init?(id: Int?, countryCode: String?, code: String?, name: String?) {
        guard let id = id,
              let countryCode = countryCode,
              let code = code,
              let name = name else {
            print("All required fields not available")
            return nil
        }
        self.id = id
        self.countryCode = countryCode
        self.code = code
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case countryCode = "CountryCode"
        case code = "Code"
        case name = "Name"
        
    }
}
