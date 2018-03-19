function(cargo_build)
    cmake_parse_arguments(CARGO "" "NAME" "" ${ARGN})
    string(REPLACE "-" "_" LIB_NAME ${CARGO_NAME})
    
    if(WIN32)
        if(CMAKE_SIZEOF_VOID_P EQUAL 8)
            set(LIB_TARGET "x86_64-pc-windows-msvc")
        else()
            set(LIB_TARGET "i686-pc-windows-msvc")
        endif()
    else()
        if(CMAKE_SIZEOF_VOID_P EQUAL 8)
            set(LIB_TARGET "x86_64-unknown-linux-gnu")
        else()
            set(LIB_TARGET "i686-unknown-linux-gnu")
        endif()
    endif()

    if(NOT CMAKE_BUILD_TYPE)
        set(LIB_BUILD_TYPE "debug")
    elseif(${CMAKE_BUILD_TYPE} STREQUAL "Release")
        set(LIB_BUILD_TYPE "release")
    else()
        set(LIB_BUILD_TYPE "debug")
    endif()    
    
    if(WIN32)
        set(LIB_FILE "target/${LIB_TARGET}/${LIB_BUILD_TYPE}/${LIB_NAME}.lib")
    else()
        set(LIB_FILE "target/${LIB_TARGET}/${LIB_BUILD_TYPE}/lib${LIB_NAME}.a")
    endif()

    set(CARGO_ARGS "build")
    list(APPEND CARGO_ARGS "--target" ${LIB_TARGET})
    
    if(${LIB_BUILD_TYPE} STREQUAL "release")
        list(APPEND CARGO_ARGS "--release")
    endif()    
    
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_SOURCE_DIR}/${LIB_FILE}"
        COMMAND cargo ARGS ${CARGO_ARGS}
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        COMMENT "running cargo")
    add_custom_target(${CARGO_NAME}_target ALL DEPENDS ${LIB_FILE})
    add_library(${CARGO_NAME} STATIC IMPORTED GLOBAL)
    add_dependencies(${CARGO_NAME} ${CARGO_NAME}_target)
    set_target_properties(${CARGO_NAME} PROPERTIES IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/${LIB_FILE}")
endfunction()