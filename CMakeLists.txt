# =========================================================================
# Freetype GL - A C OpenGL Freetype engine
# Platform:    Any
# WWW:         http://code.google.com/p/freetype-gl/
# -------------------------------------------------------------------------
# Copyright 2011,2012 Nicolas P. Rougier. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#  1. Redistributions of source code must retain the above copyright notice,
#     this list of conditions and the following disclaimer.
#
#  2. Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY NICOLAS P. ROUGIER ''AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
# EVENT SHALL NICOLAS P. ROUGIER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
# THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# The views and conclusions contained in the software and documentation are
# those of the authors and should not be interpreted as representing official
# policies, either expressed or implied, of Nicolas P. Rougier.
# =========================================================================
CMAKE_MINIMUM_REQUIRED( VERSION 2.8.5 )
SET( CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/CMakeModules"
                       "${CMAKE_MODULE_PATH}" )

OPTION(freetype-gl_BUILD_DEMOS "Build the freetype-gl example programs" ON)
OPTION(BUILD_SHARED_LIBS "Build shared libraries" OFF)

# Get required and optional library
FIND_PACKAGE( OpenGL REQUIRED )
IF( WIN32 OR WIN64 )
	SET( WINDOWS_DIR
         ${CMAKE_CURRENT_SOURCE_DIR}/windows )
    SET( GLEW_INCLUDE_PATH
         ${CMAKE_CURRENT_SOURCE_DIR}/windows/glew/include )
    SET( GLEW_LIBRARY
         ${CMAKE_CURRENT_SOURCE_DIR}/windows/glew/lib/glew32.lib )
	SET( FREETYPE_INCLUDE_DIRS
         ${CMAKE_CURRENT_SOURCE_DIR}/windows/freetype )
	SET( FREETYPE_INCLUDE_DIR_ft2build
         ${CMAKE_CURRENT_SOURCE_DIR}/windows/freetype )
	SET( FREETYPE_INCLUDE_DIR_freetype2
         ${CMAKE_CURRENT_SOURCE_DIR}/windows/freetype/freetype )
	SET( FREETYPE_LIBRARY
         ${CMAKE_CURRENT_SOURCE_DIR}/windows/freetype/freetype.lib )
    SET( VS789FIX_INCLUDE_DIR
         ${CMAKE_CURRENT_SOURCE_DIR}/windows/include )
ELSE( WIN32 OR WIN64 )
    FIND_PACKAGE( Freetype REQUIRED )
    FIND_PACKAGE( GLEW REQUIRED )
ENDIF( WIN32 OR WIN64 )

INCLUDE_DIRECTORIES( ${OPENGL_INCLUDE_DIRS}
                     ${FREETYPE_INCLUDE_DIRS}
                     ${GLEW_INCLUDE_PATHS}
                     ${CMAKE_CURRENT_SOURCE_DIR}
                     ${VS789FIX_INCLUDE_DIR}
                     ${GLEW_INCLUDE_PATH})
					 
IF(MSVC)
	ADD_DEFINITIONS(-D_CRT_SECURE_NO_WARNINGS)
ENDIF(MSVC)

SET( FREETYPE_GL_INCLUDE freetype-gl.h
                         vec234.h
                         opengl.h
                         markup.h
                         mat4.h
                         texture-atlas.h
                         texture-font.h
                         vertex-buffer.h
                         vertex-attribute.h
                         font-manager.h
                         text-buffer.h
                         shader.h
                         vector.h
                         platform.h )

SET( FREETYPE_GL_SRC mat4.c
                     texture-atlas.c
                     texture-font.c
                     vertex-buffer.c
                     vertex-attribute.c
                     font-manager.c
                     text-buffer.c
                     shader.c
                     vector.c
                     platform.c )

ADD_LIBRARY( freetype-gl ${FREETYPE_GL_SRC} )

LINK_DIRECTORIES(${PROJECT_SOURCE_DIR})

IF (freetype-gl_BUILD_DEMOS)
    ADD_SUBDIRECTORY(demo)
ENDIF (freetype-gl_BUILD_DEMOS)

INSTALL(TARGETS freetype-gl 
    ARCHIVE DESTINATION lib/freetype-gl/
    LIBRARY DESTINATION lib/freetype-gl/
    COMPONENT LIBRARY)
INSTALL(FILES ${FREETYPE_GL_INCLUDE} DESTINATION include/freetype-gl/)
