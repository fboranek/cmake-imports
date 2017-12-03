################################################################################
# openssl
################################################################################
include(ExternalProject)

set(extlibs_INSTALL_PREFIX "${CMAKE_CURRENT_BINARY_DIR}/install")

find_program (PERL_CMD perl)

ExternalProject_Add(openssl_extern
    PREFIX ${extlibs_INSTALL_PREFIX} # Root dir for entire project
    GIT_REPOSITORY https://github.com/openssl/openssl.git
    GIT_TAG OpenSSL_1_1_0-stable
    CONFIGURE_COMMAND ${PERL_CMD} ${extlibs_INSTALL_PREFIX}/src/openssl_extern/Configure "darwin64-x86_64-cc" "--prefix=${extlibs_INSTALL_PREFIX}"
    #CONFIGURE_COMMAND sh "${extlibs_INSTALL_PREFIX}/src/openssl_extern/config" "--prefix=${extlibs_INSTALL_PREFIX}"
    #BUILD_IN_SOURCE 1
    BUILD_COMMAND make
    #TEST_COMMAND make test # 50% failing on mac os xz
    INSTALL_COMMAND make install
)
 #To build for Win64/x64:

 #> perl Configure VC-WIN64A
 #> ms\do_win64a
 #> nmake -f ms\ntdll.mak
 #> cd out32dll
 #> ..\ms\test


add_library(ssl SHARED IMPORTED)
add_dependencies(ssl openssl_extern)
set_property(TARGET ssl APPEND PROPERTY
    IMPORTED_LOCATION "${extlibs_INSTALL_PREFIX}/lib/libssl.1.1.dylib"
)
set_property(TARGET ssl APPEND PROPERTY
    INTERFACE_INCLUDE_DIRECTORIES "${extlibs_INSTALL_PREFIX}/include"
)

add_library(crypto SHARED IMPORTED)
add_dependencies(crypto openssl_extern)
set_property(TARGET crypto APPEND PROPERTY
    IMPORTED_LOCATION "${extlibs_INSTALL_PREFIX}/lib/libcrypto.1.1.dylib"
)
set_property(TARGET crypto APPEND PROPERTY
    INTERFACE_INCLUDE_DIRECTORIES "${extlibs_INSTALL_PREFIX}/include"
)

