//
//  AchievementUtils.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/22/24.
//

import Foundation

class AchievementUtils {
    
    static public func createAchievement(workout: Workout,
                                         title: String,
                                         subtitle: String,
                                         subtitleDescription: String) {
        print(title)
        let newAchievement = Achievement(context: CoreDataBase.context)
        newAchievement.workout = workout
        newAchievement.title = title
        newAchievement.subTitle = subtitle
        newAchievement.subTitleDescription = subtitleDescription
        CoreDataBase.save()
    }
    
    
    static public func prWeightAchievement(workout: Workout) {
        for workoutExercise in WorkoutUtils.getWorkoutExerciseList(workout: workout) {
            let exercise = workoutExercise.exercise
            for sett in WorkoutExerciseUtils.getSettsInWorkoutExercise(workoutExercise: workoutExercise) {
                
                // Get all optional vars
                if let prWeight = exercise?.prWeight,
                   let settWeight = sett.weight,
                   let exerciseName = exercise?.name,
                   prWeight < Int64(truncating: settWeight) {
                    
                    if prWeight > 0 { // Only achievement if not first try
                        // New achievement
                        AchievementUtils.createAchievement(workout: workout,
                                        title: "\(settWeight) lbs",
                                        subtitle: "\(exerciseName)",
                                        subtitleDescription: "Personal Record")
                    }
                    
                    // Set new PR
                    exercise?.prWeight = Int64(truncating: settWeight)
                }
            }
        }
    }
    
    static public func netIncreaseOrPerfectWorkoutAchievement(workout: Workout) {
        
        // Check if perfect workout
        var perfectWorkout: Bool = false
        for workoutExercise in WorkoutUtils.getWorkoutExerciseList(workout: workout) {
            for sett in WorkoutExerciseUtils.getSettsInWorkoutExercise(workoutExercise: workoutExercise) {
                if let settNetWeight = sett.netProgress?.weight,
                   let settNetReps = sett.netProgress?.reps {
                    // Perfect workout is if every sett was improved
                    if settNetWeight <= 0 || settNetReps <= 0 {
                        perfectWorkout = false
                    }
                    
                }
            }
        }
        if perfectWorkout {
            AchievementUtils.createAchievement(workout: workout, 
                                               title: "medal",
                                               subtitle: "Perfect Workout",
                                               subtitleDescription: "Improved on all exercises")
          return
        }
        
        // If not perfect workout, check if overall net progress
        if (workout.netProgress?.weight ?? 0 > 0 && workout.netProgress?.reps ?? 0 >= 0) ||
            (workout.netProgress?.weight ?? 0 >= 0 && workout.netProgress?.reps ?? 0 > 0) {
            AchievementUtils.createAchievement(workout: workout, 
                                               title: "chart.bar.xaxis.ascending",
                                               subtitle: "Progressing Workout",
                                               subtitleDescription: "Improved on some exercises")
        }
    }
    
    static public func workoutStreakAchievement(workout: Workout) {
        // Get all workouts of the same name
        if let workoutTitle = workout.title {
            if let sameWorkouts = CoreDataBase.fetchEntities(withEntity: "Workout",
                                                          expecting: Workout.self,
                                                          predicates: [NSPredicate(format: "title == %@", workoutTitle)],
                                                             sortDescriptors: [NSSortDescriptor(key: "startTime", ascending: false)]) {
                // Get calendar components
                let calendar = Calendar.current
                let currentDate = Date()
                
                guard let earliestWorkoutDate = sameWorkouts[sameWorkouts.count - 1].startTime else {
                    return
                }
                
                let weeksBetweenLastWorkoutAndFirst = calendar.dateComponents([.weekOfYear],
                                                           from: earliestWorkoutDate,
                                                           to: currentDate).weekOfYear ?? 0
                var consecutiveWeeksCount = 0

                for i in 0..<weeksBetweenLastWorkoutAndFirst {
                    // Calculate start and end dates of the current week
                      if let startDate = calendar.date(byAdding: .weekOfYear, value: -i, to: currentDate) {
                          // Check if any entity falls within the current week
                          if sameWorkouts.contains(where: { DateUtils.isWithinOneWeek(of: startDate, comparedToDate: $0.startTime) }) {
                              consecutiveWeeksCount += 1
                          } else {
                              // If no entity found in the current week, break the loop
                              break
                          }
                      }
                }
                
                if consecutiveWeeksCount > 3 {
                    AchievementUtils.createAchievement(workout: workout,
                                                       title: "\(consecutiveWeeksCount) Weeks",
                                                       subtitle: "\(workoutTitle)",
                                                       subtitleDescription: "Workout Streak")
                }

            }

        }
    }
    
    static public func checkIfAchievementsHit(workout: Workout) {
        print("Here")
        AchievementUtils.prWeightAchievement(workout: workout)
        AchievementUtils.netIncreaseOrPerfectWorkoutAchievement(workout: workout)
        AchievementUtils.workoutStreakAchievement(workout: workout)
    }
}
