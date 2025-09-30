cmake_minimum_required(VERSION 3.18.1)

project("flutter_cpp_basic")

# Add counter library
add_library(
        counter
        SHARED
        src/main/cpp/counter/counter.cpp
        src/main/cpp/counter/counter.h)

# Add data transformer library
add_library(
        data_transformer
        SHARED
        src/main/cpp/data_transformer/data_transformer.cpp
        src/main/cpp/data_transformer/data_transformer.h)

# Add file info library
add_library(
        file_info
        SHARED
        src/main/cpp/file_info/file_info.cpp
        src/main/cpp/file_info/file_info.h)

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

target_link_libraries(
        file_info
        ${log-lib}
        ${android-lib})
