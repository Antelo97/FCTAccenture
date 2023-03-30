package com.antelo97.androidmaster

fun main() {
    var nullableName: String? = null
    var nonNullablename: String = "Antelo97"

    println(nullableName?.get(6) ?: "Es nulo weon")
    println(nonNullablename[6])
}