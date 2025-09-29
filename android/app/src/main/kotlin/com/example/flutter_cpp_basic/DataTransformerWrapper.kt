package com.example.flutter_cpp_basic

class DataTransformerWrapper {
    init {
        System.loadLibrary("data_transformer")
    }

    external fun transformJson(jsonInput: String): String
    external fun analyzeText(textInput: String): String
    external fun convertFormat(dataInput: String, fromFormat: String, toFormat: String): String
}