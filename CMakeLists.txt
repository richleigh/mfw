cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    mfw
    VERSION 0.1.0
    DESCRIPTION "MFW"
    HOMEPAGE_URL "https://m-f-w.com/"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----

add_library(
    mfw_lib OBJECT
    source/lib.cpp
)

target_include_directories(
    mfw_lib ${warning_guard}
    PUBLIC
    "\$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/source>"
)

target_compile_features(mfw_lib PUBLIC cxx_std_20)

# ---- Declare executable ----

add_executable(mfw_exe source/main.cpp)
add_executable(mfw::exe ALIAS mfw_exe)

set_property(TARGET mfw_exe PROPERTY OUTPUT_NAME mfw)

target_compile_features(mfw_exe PRIVATE cxx_std_20)

target_link_libraries(mfw_exe PRIVATE mfw_lib)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Developer mode ----

if(NOT mfw_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of mfw"
  )
endif()

include(cmake/dev-mode.cmake)
