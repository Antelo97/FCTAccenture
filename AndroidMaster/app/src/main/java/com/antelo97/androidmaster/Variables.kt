package com.antelo97.androidmaster

fun main() {

    /**
     * Variables numéricas
     */

    // Int [-2.147.483.647 a 2.147.483.647]
    val intExample1: Int = 30
    var intExample2: Int = 30
    intExample2 = 29

    // Long [-9.223.372.036.854.775.807 a 9.223.372.036.854.775.807]
    val longExample1: Long = 30
    val longExample2: Long = 30

    // Float (soporta hasta 6 decimales)
    val floatExample: Float = 30.5f

    // Double (soporta hasta 14 decimales)
    val doubleExample: Double = 20.39483948239

    /*
    println("Sumar:")
    println(intExample1 + intExample2)

    println("Restar:")
    println(intExample1 - intExample2)

    println("Multiplicar:")
    println(intExample1 * intExample2)

    println("Dividir:")
    println(intExample1 / intExample2)

    println("Módulo (resto):")
    println(intExample1 % intExample2)
    */

    //println(intExample1 + longExample1)
    //println(intExample1 + floatExample)

    var exampleSuma1: Float = intExample1 + floatExample
    var exampleSuma2 = intExample1 + floatExample.toInt()

    /**
     * Variables alfanuméricas
     */

    // Char
    val charExample1: Char = 'a'
    val charExample2: Char = '2'
    val charExample3: Char = '@'

    // String
    val stringExample1: String = "Antelo97"
    val stringExample2 = "Antelo97"
    val stringExample3 = "4"
    val stringExample4 = "23"

    //println(stringExample3 + stringExample4)
    //println(stringExample3.toInt() + stringExample4.toInt())

    var stringConcatenada: String = "Hola"
    println(stringConcatenada)

    //stringConcatenada = "Hola me llamo " + stringExample2 + " y tengo " + intExample1 + " años"
    stringConcatenada = "Hola me llamo $stringExample2 y tengo $intExample1 años"
    println(stringConcatenada)

    val example123:String = intExample1.toString()
    //val example123 = intExample1.toString()

    /**
     * Variables booleanas
     */

    // Boolean
    var booleanExample1: Boolean = true
    var booleanExample2: Boolean = false
    var booleanExample3 = false

    /*
    println(stringExample1)
    println(booleanExample1)
    println(doubleExample)
    */
}