# Parent project does not export its library target, so this CML implicitly
# depends on being added from it, i.e. the testing is done only from the build
# tree and is not feasible from an install location

project(mfwTests LANGUAGES CXX)

# ---- Tests ----

add_executable(mfw_test source/mfw_test.cpp)
target_link_libraries(mfw_test PRIVATE mfw_lib)
target_compile_features(mfw_test PRIVATE cxx_std_20)

add_test(NAME mfw_test COMMAND mfw_test)

# ---- End-of-file commands ----

add_folders(Test)
