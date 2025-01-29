install(
    TARGETS mfw_exe
    RUNTIME COMPONENT mfw_Runtime
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
