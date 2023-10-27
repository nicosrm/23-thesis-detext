//
//  View+onTapGestureWithSoundAndHoverEffect.swift
//  iOS
//
//  Created by nicosrm
//

import SwiftUI
import AVFoundation

extension View {

    /// Add an action to perform when this view recognizes a tap gesture.
    /// Play a sound effect on tap. Apply a hover effect with passed shape to
    /// this view.
    ///
    /// - Parameters:
    ///   - count: The number of taps or clicks required to trigger the action
    ///     closure provided in `action`. Defaults to 1.
    ///   - soundID: The system sound to play.
    ///   - hoverEffect: The hover effect to apply to this view.
    ///     Defaults to `.automatic`
    ///   - shape: The shape of the hover effect.
    ///   - action: The action to perform.
    func onTapGestureWithSoundAndHoverEffect(
        count: Int = 1,
        soundID: SystemSoundID,
        hoverEffect: HoverEffect = .automatic,
        shape: some Shape,
        perform action: @escaping () -> Void
    ) -> some View {

        self.onTapGesture(count: count) {
            AudioServicesPlaySystemSound(soundID)
            action()
        }
        .padding()
        .contentShape(.hoverEffect, shape)
        .hoverEffect(hoverEffect)
    }

    /// Add an action to perform when this view recognizes a tap gesture.
    /// Play a sound effect on tap. Apply a hover effect with passed shape to
    /// this view.
    ///
    /// - Parameters:
    ///   - count: The number of taps or clicks required to trigger the action
    ///     closure provided in `action`. Defaults to 1.
    ///   - soundURL: A URL that identifies the local audio file to play.
    ///   - hoverEffect: The hover effect to apply to this view.
    ///     Defaults to `.automatic`
    ///   - shape: The shape of the hover effect.
    ///   - action: The action to perform.
    func onTapGestureWithSoundAndHoverEffect(
        count: Int = 1,
        soundURL: URL,
        hoverEffect: HoverEffect = .automatic,
        shape: some Shape,
        perform action: @escaping () -> Void
    ) -> some View {

        self.onTapGesture(count: count) {
            do {
                let sound = try AVAudioPlayer(contentsOf: soundURL)
                sound.play()
            } catch {
                print("Tried to play sound but \(soundURL.absoluteString) " +
                      "could not be loaded.")
            }
            action()
        }
        .padding()
        .contentShape(.hoverEffect, shape)
        .hoverEffect(hoverEffect)
    }
}
