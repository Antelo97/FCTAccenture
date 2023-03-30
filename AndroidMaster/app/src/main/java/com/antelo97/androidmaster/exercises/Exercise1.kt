package com.antelo97.androidmaster.exercises

fun main() {
    val morningNotifications = 51
    val eveningNotifications = 135

    printNotificationSummary(morningNotifications)
    printNotificationSummary(eveningNotifications)
}

fun printNotificationSummary(numberOfMessages: Int) {
    if (numberOfMessages < 100) {
        println("You have $numberOfMessages notifications.")
    } else {
        println("Your phone is blowing up! You have 99+ notifications.")
    }

    /*
    when (numberOfMessages) {
        in 1..99 -> println("You have $numberOfMessages notifications.")
        else -> println("Your phone is blowing up! You have 99+ notifications.")
    }
    */
}