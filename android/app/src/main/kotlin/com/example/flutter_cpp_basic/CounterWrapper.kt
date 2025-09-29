package com.example.flutter_cpp_basic

class CounterWrapper {
    init {
        System.loadLibrary("counter")
    }

    external fun getValue(): Int
    external fun increment()
    external fun decrement()
    external fun reset()
}