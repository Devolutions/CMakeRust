
add_executable(helloworld hello.c)
target_link_libraries(helloworld test-lib pthread dl)