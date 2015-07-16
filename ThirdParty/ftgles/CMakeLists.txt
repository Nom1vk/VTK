PROJECT (VTKFTGLES)

set(vtkftgles_THIRD_PARTY 1)
set(vtkftgles_LIBRARIES vtkftgles)
set(vtkftgles_INCLUDE_DIRS ${VTKFTGL_SOURCE_DIR}/src)
vtk_module_export_info()
set(VTK_FREETYPE_LIBRARIES ${vtkfreetype_LIBRARIES})

#
# Dependency mask
#

INCLUDE_REGULAR_EXPRESSION(".*")

#
# Collect the required libs
#

SET (VTKFTGLES_LIBS "")

#
# Do not use the STL (portability issue)
#

SET (VTKFTGLES_DO_NOT_USE_STL 1)

#
# Source files
#

SET (FTGLES_SRCS
  src/FTBitmapGlyph.cpp
  src/FTBitmapGlyphImpl.cpp
  src/FTCharmap.cpp
  src/FTFace.cpp
  src/FTFont.cpp
  src/FTBitmapFont.cpp
  src/FTBitmapFontImpl.cpp
  src/FTPixmapFont.cpp
  src/FTPixmapFontImpl.cpp
  src/FTGlyph.cpp
  src/FTGlyphContainer.cpp
  src/FTLibrary.cpp
  src/FTPixmapGlyph.cpp
  src/FTPixmapGlyphImpl.cpp
  src/FTSize.cpp
)

#
# Do not use texture fonts (crash on Type1 fonts)
# 
SET (VTKFTGLES_DO_NOT_USE_TEXTURE_FONT 1)
IF (NOT VTKFTGLES_DO_NOT_USE_TEXTURE_FONT)
  SET (FTGLES_SRCS ${FTGLES_SRCS}
    src/FTTextureFont.cpp
    src/FTTextureGlyph.cpp
  )
ENDIF ()

#
# Do not use vector fonts (we only need pixmap and bitmaps and vector fonts
# needs glu). Might be an option at some point, but set it to 'true' for now.
# 
SET (VTKFTGLES_DO_NOT_USE_VECTORISER 1)
IF (NOT VTKFTGLES_DO_NOT_USE_VECTORISER)
  SET (FTGLES_SRCS ${FTGL_SRCS}
    src/FTExtrudeGlyph.cpp
    src/FTExtrudeFont.cpp
    src/FTOutlineFont.cpp
    src/FTPolygonFont.cpp
    src/FTOutlineGlyph.cpp
  )
ENDIF ()

#
# Shared/static lib settings)
# 
IF (BUILD_SHARED_LIBS)
  SET (VTKFTGLES_DLL 1)
ELSE ()
  SET (VTKFTGLES_STATIC 1)
ENDIF ()

#
# Win32 flags (and shared/static lib settings)
# 
IF (WIN32)
  # This will add -DUSE_STD_NAMESPACE and -DWIN32
  SET (VTKFTGLES_WIN32_FLAGS 1)
ENDIF ()

#
# Unix flags
# 
IF (UNIX)
  IF(CMAKE_SYSTEM MATCHES "HP-UX.*")
    SET (VTKFTGLES_HPUX_SOURCE 1)
  ENDIF()
ENDIF ()

#
# We need OpenGL ES
#
# Use GL library provided by parent VTK if possible.
# 

find_path(OPENGL_INCLUDE_DIR GLES2/gl2.h
         ${ANDROID_NDK}/platforms/android-${ANDROID_NATIVE_API_LEVEL}/arch-${ANDROID_ARCH_NAME}/usr/include
         ${_OPENGL_INCLUDE_PATH}
         NO_DEFAULT_PATH
         )
find_library(OPENGL_gl_LIBRARY
 NAMES GLESv2
 PATHS
   ${ANDROID_NDK}/platforms/android-${ANDROID_NATIVE_API_LEVEL}/arch-${ANDROID_ARCH_NAME}/usr/lib
   ${_OPENGL_LIB_PATH}
 )

 find_library(OPENGL_egl_LIBRARY
NAMES EGL
PATHS
 ${ANDROID_NDK}/platforms/android-${ANDROID_NATIVE_API_LEVEL}/arch-${ANDROID_ARCH_NAME}/usr/lib
 ${_OPENGL_LIB_PATH}
)
IF(OPENGL_gl_LIBRARY)
  SET (VTKFTGLES_LIBS "${VTKFTGLES_LIBS};${OPENGL_gl_LIBRARY}")
ENDIF()

IF (VTK_OPENGL_HAS_OSMESA AND OSMESA_LIBRARY)
  SET (VTKFTGLES_LIBS ${VTKFTGLES_LIBS} ${OSMESA_LIBRARY} )
ENDIF ()

#
# We obviously need FreeType
# 
SET (VTKFTGLES_LIBS "${VTKFTGLES_LIBS};${VTK_FREETYPE_LIBRARIES}")

#
# Define the library (and install it)
# 
VTK_ADD_LIBRARY (vtkftgles ${FTGLES_SRCS})
TARGET_LINK_LIBRARIES(vtkftgles ${VTKFTGLES_LIBS})

#
# Create the configuration file
# 
ADD_DEFINITIONS (-DVTKFTGLES)
CONFIGURE_FILE(${VTKFTGLES_SOURCE_DIR}/vtkftglesConfig.h.in
               ${VTKFTGLES_BINARY_DIR}/vtkftglesConfig.h)

#
# Build examples (testing purposes)
# (Warning, they use Glut)
#   
#OPTION (FTGLES_BUILD_EXAMPLES "Build FTGLES examples (warning: you need Glut)" OFF)
#MARK_AS_ADVANCED (FTGLES_BUILD_EXAMPLES)
SET(FTGLES_BUILD_EXAMPLES 0)


