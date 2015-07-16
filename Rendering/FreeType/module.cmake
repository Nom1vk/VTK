#IF(NOT ANDROID)
vtk_module(vtkRenderingFreeType
  IMPLEMENTS
    vtkRenderingCore
  GROUPS
    Rendering
  DEPENDS
    vtkRenderingCore
    vtkfreetype
    vtkftgl
  TEST_DEPENDS
    vtkRenderingMatplotlib
    vtkTestingRendering
    vtkViewsContext2D
    vtkRendering${VTK_RENDERING_BACKEND}
    vtkRenderingContext${VTK_RENDERING_BACKEND}
  KIT
    vtkRendering
  )
#ELSE()
#vtk_module(vtkRenderingFreeType
#  IMPLEMENTS
#    vtkRenderingCore
#  GROUPS
#    Rendering
#  DEPENDS
#   vtkRenderingCore
#    vtkfreetype
#    vtkftgles
#  TEST_DEPENDS
#    vtkRenderingMatplotlib
#    vtkTestingRendering
#    vtkViewsContext2D
#    vtkRendering${VTK_RENDERING_BACKEND}
#   vtkRenderingContext${VTK_RENDERING_BACKEND}
#  KIT
#    vtkRendering
#  )
#ENDIF(NOT ANDROID)
