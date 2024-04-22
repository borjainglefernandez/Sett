//
//  WorkoutTimer.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 3/6/24.
//

import UIKit

class WorkoutTimer: UILabel {
    
    public let viewModel: WorkoutBottomBarVM
    private var timer: Timer?
    private var seconds = 0
    
    // MARK: - Init
    init(frame: CGRect = .zero, viewModel: WorkoutBottomBarVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        self.font = .systemFont(ofSize: 17, weight: .bold)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.updateTimerLabel()
        self.initialiseTimer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Initialisations
    public func initialiseTimer() {
        self.seconds = self.viewModel.getWorkoutTimeElapsedSeconds()
        self.updateTimerLabel()
        
        if self.viewModel.isOngoingWorkout() {
            self.startTime()
        }
    }
    
    // MARK: - Actions
    private func updateTimerLabel() {
        // Calculate hours, minutes, and seconds
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        
        // Update the label text with the formatted time
        self.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    public func startTime() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.seconds += 1
                  
            // Update the label with the new elapsed time
            self.updateTimerLabel()
        }
      }
    
    public func stopTime() {
        timer?.invalidate()
        self.viewModel.pauseOrFinishWorkoutTimer(durationSeconds: seconds)
    }
}
