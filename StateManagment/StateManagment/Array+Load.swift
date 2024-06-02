import Foundation

extension Array where Element: Decodable {
    static func fromJSON(named fileName: String) throws -> [Element] {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            fatalError("Couldn't find file \(fileName)")
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            return try decoder.decode([Element].self, from: data)
        } catch {
            fatalError("Failed to decode \(fileName): \(error.localizedDescription)")
        }
    }
}

