project(all-libs)

cmake_minimum_required(VERSION 3.0)
set(CMAKE_COLOR_MAKEFILE ON)

if (CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set (CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/install" CACHE PATH "default install path" FORCE )
endif()
set(CMAKE_DEBUG_POSTFIX CACHE STRING "Postfix for debug library name. Usualy '_d'")

################################################################################


include(import-openssl.cmake) 


################################################################################
# print all compile flags on terminal
set(variables
  CMAKE_C_FLAGS_DEBUG
  CMAKE_C_FLAGS_MINSIZEREL
  CMAKE_C_FLAGS_RELEASE
  CMAKE_C_FLAGS_RELWITHDEBINFO
  CMAKE_CXX_FLAGS_DEBUG
  CMAKE_CXX_FLAGS_MINSIZEREL
  CMAKE_CXX_FLAGS_RELEASE
  CMAKE_CXX_FLAGS_RELWITHDEBINFO
  CMAKE_DEBUG_POSTFIX
)
message(STATUS "Initial build flags:")
foreach(variable ${variables})
	message(STATUS "  '${variable}': ${${variable}}")
endforeach()
message(STATUS "")
################################################################################
