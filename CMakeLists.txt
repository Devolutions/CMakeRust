cmake_minimum_required(VERSION 3.0)

project(CMakeRust)

set(CMAKE_LOCAL_ROOT ${CMAKE_SOURCE_DIR}/cmake)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_LOCAL_ROOT}/Modules")

enable_language(Rust)
include(CMakeCargo)

add_subdirectory(hello_world)
add_subdirectory(crates)

