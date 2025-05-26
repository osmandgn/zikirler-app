//
//  ZikirEntry.swift
//  Zikirler
//
//  Created by Your Name on \(Date())
//

import Foundation

struct ZikirEntry: Identifiable, Codable {
    var id: UUID = UUID() // Automatically generated default value
    var name: String        // e.g., "Subhanallah", "Alhamdulillah"
    var count: Int          // The number of times this dhikr was recited
    var date: Date          // The date and time when this dhikr entry was recorded
}

// Example Usage (Optional - can be removed or commented out)
/*
let exampleEntry = ZikirEntry(name: "Sübhanallah", count: 100, date: Date())
let exampleEntry2 = ZikirEntry(id: UUID(), name: "Elhamdülillah", count: 50, date: Date().addingTimeInterval(-3600)) // Example with explicit ID and different time

func printEntry(entry: ZikirEntry) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .short
    print("ID: \(entry.id)")
    print("Zikir Adı: \(entry.name)")
    print("Sayısı: \(entry.count)")
    print("Tarih: \(dateFormatter.string(from: entry.date))")
}

// printEntry(entry: exampleEntry)
// printEntry(entry: exampleEntry2)
*/
