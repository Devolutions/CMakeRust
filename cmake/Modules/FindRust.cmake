
if(WIN32)
	set(USER_HOME "$ENV{HOMEDRIVE}$ENV{HOMEPATH}")
else()
	set(USER_HOME "$ENV{HOME}")
endif()

# Find cargo prefix
find_path(CARGO_PREFIX "bin"
	PATHS "${USER_HOME}/.cargo")

# Find cargo executable
find_program(CARGO_EXECUTABLE cargo
	HINTS "${CARGO_PREFIX}"
	PATH_SUFFIXES "bin")
mark_as_advanced(CARGO_EXECUTABLE)

# Find rustc executable
find_program(RUSTC_EXECUTABLE rustc
	HINTS "${CARGO_PREFIX}"
	PATH_SUFFIXES "bin")
mark_as_advanced(RUSTC_EXECUTABLE)

# Find rustdoc executable
find_program(RUSTDOC_EXECUTABLE rustdoc
	HINTS "${CARGO_PREFIX}"
	PATH_SUFFIXES "bin")
mark_as_advanced(RUSTDOC_EXECUTABLE)

# Find rust-gdb executable
find_program(RUST_GDB_EXECUTABLE rust-gdb
	HINTS "${CARGO_PREFIX}"
	PATH_SUFFIXES "bin")
mark_as_advanced(RUST_GDB_EXECUTABLE)

# Find rust-lldb executable
find_program(RUST_LLDB_EXECUTABLE rust-lldb
	HINTS "${CARGO_PREFIX}"
	PATH_SUFFIXES "bin")
mark_as_advanced(RUST_LLDB_EXECUTABLE)

# Find rustup executable
find_program(RUSTUP_EXECUTABLE rustup
	HINTS "${CARGO_PREFIX}"
	PATH_SUFFIXES "bin")
mark_as_advanced(RUSTUP_EXECUTABLE)

set(RUST_FOUND FALSE CACHE INTERNAL "")

if(CARGO_EXECUTABLE AND RUSTC_EXECUTABLE AND RUSTDOC_EXECUTABLE)
	set(RUST_FOUND TRUE CACHE INTERNAL "")

	set(CARGO_PREFIX "${CARGO_PREFIX}" CACHE PATH "Rust Cargo prefix")

	execute_process(COMMAND ${RUSTC_EXECUTABLE} --version OUTPUT_VARIABLE RUSTC_VERSION OUTPUT_STRIP_TRAILING_WHITESPACE)
	string(REGEX REPLACE "rustc ([^ ]+) .*" "\\1" RUSTC_VERSION "${RUSTC_VERSION}")
endif()

if(NOT RUST_FOUND)
	message(FATAL_ERROR "Could not find Rust!")
endif()

