package com.antelo97.androidmaster

fun main() {
    ifMultipleOR()
}

fun ifBasico() {
    val name: String = "Pepe"

    if (name == "Antelo") {
        println("La variable [name] es 'Antelo'")
    } else {
        println("Este no es Antelo")
    }

}

fun ifAnidado() {
    val animal = "daog"

    if (animal == "dog") {
        println("Es un perr0")
    } else if (animal == "cat") {
        println("Es un gato")
    } else if (animal == "bird") {
        println("Es un pájaro")
    } else {
        println("No es ningún animal de los esperados")
    }
}

fun ifBoolean() {
    var soyFeliz: Boolean = false

    // Sin nada == true
    // Con '!' al principio == false

    if (!soyFeliz) {
        println("Estoy triste :(")
    }
}

fun ifInt() {
    var age = 18

    if (age >= 18) {
        println("Beber cerveza")
    } else {
        println("Beber zumo")
    }
}

fun ifMultipleAND() {
    var age = 18
    var parentPermission = true
    var imHappy = true

    if (age >= 18 && parentPermission && imHappy) {
        println("Puedo beber")
    }
}

fun ifMultipleOR() {
    var pet = "cat"
    var isHappy = true

    if (pet == "dog" || (pet == "cat" && isHappy)) {
        println("Es un perro o un gato")
    }

}