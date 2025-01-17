include(Compiler/GNU)
__compiler_gnu(CXX)


if((NOT DEFINED CMAKE_DEPENDS_USE_COMPILER OR CMAKE_DEPENDS_USE_COMPILER)
    AND CMAKE_GENERATOR MATCHES "Makefiles|WMake"
    AND CMAKE_DEPFILE_FLAGS_CXX)
  # dependencies are computed by the compiler itself
  set(CMAKE_CXX_DEPFILE_FORMAT gcc)
  set(CMAKE_CXX_DEPENDS_USE_COMPILER TRUE)
endif()

set(CMAKE_CXX_COMPILE_OPTIONS_EXPLICIT_LANGUAGE -x c++)

if (WIN32)
  if(NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 4.6)
    set(CMAKE_CXX_COMPILE_OPTIONS_VISIBILITY_INLINES_HIDDEN "-fno-keep-inline-dllexport")
  endif()
else()
  if(NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 4.0)
    set(CMAKE_CXX_COMPILE_OPTIONS_VISIBILITY_INLINES_HIDDEN "-fvisibility-inlines-hidden")
  endif()
endif()

if(NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 3.4)
  set(CMAKE_CXX98_STANDARD_COMPILE_OPTION "-std=c++98")
  set(CMAKE_CXX98_EXTENSION_COMPILE_OPTION "-std=gnu++98")
endif()

if (NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 4.7)
  set(CMAKE_CXX98_STANDARD__HAS_FULL_SUPPORT ON)
  set(CMAKE_CXX11_STANDARD_COMPILE_OPTION "-std=c++11")
  set(CMAKE_CXX11_EXTENSION_COMPILE_OPTION "-std=gnu++11")
elseif (NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 4.4)
  # 4.3 supports 0x variants
  set(CMAKE_CXX11_STANDARD_COMPILE_OPTION "-std=c++0x")
  set(CMAKE_CXX11_EXTENSION_COMPILE_OPTION "-std=gnu++0x")
endif()

if (NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 4.8.1)
  set(CMAKE_CXX11_STANDARD__HAS_FULL_SUPPORT ON)
endif()

if (NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 4.9)
  set(CMAKE_CXX14_STANDARD_COMPILE_OPTION "-std=c++14")
  set(CMAKE_CXX14_EXTENSION_COMPILE_OPTION "-std=gnu++14")
elseif (NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 4.8)
  set(CMAKE_CXX14_STANDARD_COMPILE_OPTION "-std=c++1y")
  set(CMAKE_CXX14_EXTENSION_COMPILE_OPTION "-std=gnu++1y")
endif()

if (NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 5.0)
  set(CMAKE_CXX14_STANDARD__HAS_FULL_SUPPORT ON)
endif()

if (NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 8.0)
  set(CMAKE_CXX17_STANDARD_COMPILE_OPTION "-std=c++17")
  set(CMAKE_CXX17_EXTENSION_COMPILE_OPTION "-std=gnu++17")
elseif (NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 5.1)
  set(CMAKE_CXX17_STANDARD_COMPILE_OPTION "-std=c++1z")
  set(CMAKE_CXX17_EXTENSION_COMPILE_OPTION "-std=gnu++1z")
endif()

if(CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 11.1)
  set(CMAKE_CXX20_STANDARD_COMPILE_OPTION "-std=c++20")
  set(CMAKE_CXX20_EXTENSION_COMPILE_OPTION "-std=gnu++20")
  set(CMAKE_CXX23_STANDARD_COMPILE_OPTION "-std=c++23")
  set(CMAKE_CXX23_EXTENSION_COMPILE_OPTION "-std=gnu++23")
elseif(CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 8.0)
  set(CMAKE_CXX20_STANDARD_COMPILE_OPTION "-std=c++2a")
  set(CMAKE_CXX20_EXTENSION_COMPILE_OPTION "-std=gnu++2a")
endif()

__compiler_check_default_language_standard(CXX 3.4 98 6.0 14 11.1 17)

if(CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 14.0)
  string(CONCAT CMAKE_EXPERIMENTAL_CXX_SCANDEP_SOURCE
    "<CMAKE_CXX_COMPILER> <DEFINES> <INCLUDES> <FLAGS> -E -x c++ <SOURCE>"
    " -MT <DYNDEP_FILE> -MD -MF <DEP_FILE>"
    " -fmodules-ts -fdeps-file=<DYNDEP_FILE> -fdeps-target=<OBJECT> -fdeps-format=p1689r5"
    " -o <PREPROCESSED_SOURCE>")
  set(CMAKE_EXPERIMENTAL_CXX_MODULE_MAP_FORMAT "gcc")
  string(CONCAT CMAKE_EXPERIMENTAL_CXX_MODULE_MAP_FLAG
    # Turn on modules.
    "-fmodules-ts"
    # Read the module mapper file.
    " -fmodule-mapper=<MODULE_MAP_FILE>"
    # Make sure dependency tracking is enabled (missing from `try_*`).
    " -MD"
    # Suppress `CXX_MODULES +=` from generated depfile snippets.
    " -fdeps-format=p1689r5"
    # Force C++ as a language.
    " -x c++")
  set(CMAKE_EXPERIMENTAL_CXX_MODULE_BMI_ONLY_FLAG "-fmodule-only")
endif()
