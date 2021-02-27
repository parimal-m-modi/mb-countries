//
//  Country.swift
//  MBCountries
//
//  Created by Parimal Modi on 27/02/21.
//

struct Country: Codable {
    let id: Int
    let name: String
    let code: String
    let phoneCode: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
        case code = "Code"
        case phoneCode = "PhoneCode"
    }
    
    //Since id is needed for details screen, name is needed to display in UI and code is needed for image,
    //using failable initializer to make sure these fields are always available
    init?(id: Int?, name: String?, code: String?, phoneCode: String?) {
        guard let id = id,
              let name = name,
              let code = code else {
            print("Required field not available")
            return nil
        }
        self.id = id
        self.name = name
        self.code = code
        self.phoneCode = phoneCode
    }
}
