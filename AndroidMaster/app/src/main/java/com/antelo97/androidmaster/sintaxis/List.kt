package com.antelo97.androidmaster

fun main() {
    //inmutableList()
    mutableList()
}

fun inmutableList() {
    val readOnly: List<String> =
        listOf("Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo")

    println(readOnly.size)
    println(readOnly)
    println(readOnly[0])
    println(readOnly.last())
    println(readOnly.first())

    // Filtrar
    val example = readOnly.filter { it.contains("a") }
    print(example)

    // Iterar
    readOnly.forEach { weekDays -> println(weekDays) }
}

fun mutableList() {
    val weekDays: MutableList<String> =
        mutableListOf("Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo")
    println(weekDays)

    weekDays.add(3, "Antelo97")
    println(weekDays)

    if (weekDays.isEmpty()) {

    } else {
        weekDays.forEach() { println(it) }
    }

    if (weekDays.isNotEmpty()) {
        weekDays.forEach() { println(it) }
    }

    println(weekDays.last())

    for (item in weekDays) {
        println("Ahora es $item")
    }
}