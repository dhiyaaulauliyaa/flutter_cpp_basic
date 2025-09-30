package com.example.flutter_cpp_basic

class FileInfoWrapper {
    init {
        System.loadLibrary("file_info")
    }

    external fun analyzeFile(path: String): String
}