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
include(cmake/shader-compile.cmake)
include(cmake/variables.cmake)

# ---- Dependencies ----
find_package(glfw3 3.3 REQUIRED)
find_package(Vulkan REQUIRED COMPONENTS glslc)
find_package(glm REQUIRED)

find_program(glslc_executable NAMES glslc HINTS Vulkan::glslc)
if(NOT glslc_executable)
  message(FATAL_ERROR "glslc not found!")
endif()

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

target_link_libraries(
  mfw_exe 
  PRIVATE 
  mfw_lib 
  glm::glm
  glfw 
  Vulkan::Vulkan
)

# ---- Compile shaders ----
compile_shader(
    mfw_exe
    ENV vulkan1.2
    FORMAT bin
    SOURCES
    "shader/shader.vert"
    "shader/shader.frag"
)


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
