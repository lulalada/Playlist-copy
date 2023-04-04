//
//  MusicDelegate.swift
//  Playlist
//
//  Created by Alua Sayabayeva on 2023-04-03.
//

import Foundation
import AVFoundation

protocol MusicDelegate: AnyObject
{
    func continueSong(position: Int, currentTime: TimeInterval, isPreviousPlaying: Bool)
}
