//
//  AktifSheet.swift
//  Zikirler
//
//  Created by osman dogan on 21.05.2025.
//

import SwiftUI // Identifiable için

enum AktifSheet: Identifiable {
    case ekleme(EklemeEkranı)
    // case zikirCekme(Binding<Hedef>) // KALDIRILDI, NavigationLink ile çözüldü
    case zikirKutuphanesi

    var id: String {
        switch self {
        case .ekleme(let ekran):
            return "ekleme-\(ekran)"
        // case .zikirCekme: // KALDIRILDI
        //     return "zikirCekme"
        case .zikirKutuphanesi:
            return "zikirKutuphanesi"
        }
    }
}
