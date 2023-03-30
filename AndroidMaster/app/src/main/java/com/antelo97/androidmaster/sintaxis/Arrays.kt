package com.antelo97.androidmaster

fun main() {

    // Índice 0-6
    // Tamaño 7
    val weekDays =
        arrayOf("Monday", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo")

    // Modificar valores
    weekDays[0] = "Lunes"

    println(weekDays[0])
    println(weekDays[0][2])
    println(weekDays.size)

    // Tamaños
    if (weekDays.size >= 8) {
        println(weekDays[7])
    } else {
        println("No hay más valores en el array")
    }

    // Bucles para recorrer arrays
    for (position in weekDays.indices) {
        println(weekDays[position])
    }

    for ((position, value) in weekDays.withIndex()) {
        println("La posición $position, contiene $value")
    }

    for (weekDay in weekDays) {
        println("Ahora es $weekDay")
    }

    weekDays.forEach { println(it) }
}