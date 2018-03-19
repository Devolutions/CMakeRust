
add_executable(helloworld hello.c)
if(WIN32)
    target_link_libraries(helloworld test-lib ws2_32 userenv)
else()
    target_link_libraries(helloworld test-lib pthread dl)
endif()