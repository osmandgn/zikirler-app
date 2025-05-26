//
//  ZikirDataManager.swift
//  Zikirler
//
//  Created by Your Name on \(Date())
//

import Foundation

class ZikirDataManager {

    private static let userDefaultsKey = "zikirEntries"

    // MARK: - Saving Data
    
    /// Saves an array of ZikirEntry objects to UserDefaults.
    /// - Parameter entries: The array of ZikirEntry objects to save.
    static func saveZikirEntries(_ entries: [ZikirEntry]) {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(entries)
            UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
            print("Zikir entries saved successfully.")
        } catch {
            print("Error encoding ZikirEntry array: \(error.localizedDescription)")
        }
    }

    // MARK: - Loading Data

    /// Loads an array of ZikirEntry objects from UserDefaults.
    /// - Returns: An array of ZikirEntry objects. Returns an empty array if no data is found or if decoding fails.
    static func loadZikirEntries() -> [ZikirEntry] {
        guard let savedData = UserDefaults.standard.data(forKey: userDefaultsKey) else {
            print("No saved zikir entries found.")
            return []
        }
        
        do {
            let decoder = JSONDecoder()
            let loadedEntries = try decoder.decode([ZikirEntry].self, from: savedData)
            print("Zikir entries loaded successfully.")
            return loadedEntries
        } catch {
            print("Error decoding ZikirEntry array: \(error.localizedDescription)")
            return [] // Return empty array in case of an error
        }
    }
    
    // MARK: - Convenience Methods (Optional)

    /// Adds a new ZikirEntry and saves the updated list.
    static func addZikirEntry(name: String, count: Int, date: Date = Date()) {
        var currentEntries = loadZikirEntries()
        let newEntry = ZikirEntry(name: name, count: count, date: date)
        currentEntries.append(newEntry)
        saveZikirEntries(currentEntries)
        print("New zikir entry '\(name)' added and saved.")
    }

    /// Clears all ZikirEntry data from UserDefaults.
    static func clearAllZikirEntries() {
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
        print("All zikir entries cleared from UserDefaults.")
    }
}

// Example Usage (Optional - can be commented out or removed)
/*
func demonstrateZikirDataManager() {
    // Clear any existing data for a clean test
    ZikirDataManager.clearAllZikirEntries()

    // Load initial (should be empty)
    var entries = ZikirDataManager.loadZikirEntries()
    print("Loaded entries count initially: \(entries.count)")

    // Add a few entries
    ZikirDataManager.addZikirEntry(name: "Sübhanallah", count: 100)
    ZikirDataManager.addZikirEntry(name: "Elhamdülillah", count: 200, date: Date().addingTimeInterval(-86400)) // Yesterday
    ZikirDataManager.addZikirEntry(name: "Allahu Ekber", count: 150)

    // Load again
    entries = ZikirDataManager.loadZikirEntries()
    print("Loaded entries count after adding: \(entries.count)")

    for entry in entries {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        print(" - \(entry.name): \(entry.count) (ID: \(entry.id), Date: \(dateFormatter.string(from: entry.date)))")
    }

    // Example of saving a modified list directly (e.g., if you modify counts or remove items)
    if var firstEntry = entries.first {
        firstEntry.count += 50
        entries[0] = firstEntry
        ZikirDataManager.saveZikirEntries(entries)
        print("Modified first entry and re-saved.")
    }
    
    let updatedEntries = ZikirDataManager.loadZikirEntries()
    if let firstEntry = updatedEntries.first {
         print("Updated count for first entry: \(firstEntry.count)")
    }
}

// Call the demonstration function
// demonstrateZikirDataManager()
*/
