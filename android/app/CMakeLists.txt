cmake_minimum_required(VERSION 3.18.1)

project("flutter_cpp_basic")

# Add our counter library
add_library(
        counter
        SHARED
        src/main/cpp/counter.cpp
        src/main/cpp/counter.h)

# Add our data transformer library
add_library(
        data_transformer
        SHARED
        src/main/cpp/data_transformer.cpp
        src/main/cpp/data_transformer.h)

# Find and link Android libraries
find_library(log-lib log)
find_library(android-lib android)

# Link libraries
target_link_libraries(
        counter
        ${log-lib}
        ${android-lib})

target_link_libraries(
        data_transformer
        ${log-lib}
        ${android-lib})