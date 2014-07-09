#
# Try to find AntTweakBar library and include path.
# Once done this will define
#
# ANT_TWEAK_BAR_FOUND
# ANT_TWEAK_BAR_INCLUDE_PATH/ANT_TWEAK_BAR_INCLUDE_DIR
# ANT_TWEAK_BAR_LIBRARIES/ANT_TWEAK_BAR_LIBRARY
# 

if (ANT_TWEAK_BAR_LIBRARIES AND ANT_TWEAK_BAR_INCLUDE_PATH)
  # in cache already
  set(ANT_TWEAK_BAR_FOUND TRUE)
else (ANT_TWEAK_BAR_LIBRARIES AND ANT_TWEAK_BAR_INCLUDE_PATH)

if(WIN32)
    find_path(ANT_TWEAK_BAR_INCLUDE_DIR
        NAMES AntTweakBar.h
        PATHS
            $ENV{ANT_TWEAK_BAR_ROOT}/include
        DOC
            "The directory where AntTweakBar.h resides"
    )

    find_library(ANT_TWEAK_BAR_LIBRARY
        AntTweakBar
        PATHS
            $ENV{ANT_TWEAK_BAR_ROOT}/lib
        DOC
            "The AntTweakBar library"
    )
else (WIN32)
    find_path(ANT_TWEAK_BAR_INCLUDE_DIR
        NAMES AntTweakBar.h
        PATH_SUFFIXES include Include include/AntTweakBar
        PATHS
            /usr
            /usr/local
            /sw # Fink
            /opt/local # DarwinPorts
            /opt/csw # Blastwave
            /opt
    )

    find_library(ANT_TWEAK_BAR_LIBRARY
        NAMES AntTweakBar
        PATH_SUFFIXES lib lib64 Library dylib
        PATHS
            /usr
            /usr/local
            /sw # Fink
            /opt/local # DarwinPorts
            /opt/csw # Blastwave
            /opt
    )
endif (WIN32)

if (ANT_TWEAK_BAR_LIBRARY)
  set(ANT_TWEAK_BAR_LIBRARIES ${ANT_TWEAK_BAR_LIBRARIES} ${ANT_TWEAK_BAR_LIBRARY})
endif (ANT_TWEAK_BAR_LIBRARY)

if (ANT_TWEAK_BAR_DIR)
  set(ANT_TWEAK_BAR_INCLUDE_PATH ${ANT_TWEAK_BAR_PATH} ${ANT_TWEAK_BAR_DIR})
endif (ANT_TWEAK_BAR_DIR)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(ANT_TWEAK_BAR DEFAULT_MSG ANT_TWEAK_BAR_LIBRARY ANT_TWEAK_BAR_INCLUDE_DIR)

mark_as_advanced(ANT_TWEAK_BAR_INCLUDE_DIR ANT_TWEAK_BAR_INCLUDE_PATH ANT_TWEAK_BAR_LIBRARY ANT_TWEAK_BAR_LIBRARIES)

endif (ANT_TWEAK_BAR_LIBRARIES AND ANT_TWEAK_BAR_INCLUDE_PATH)
