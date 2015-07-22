if(NOT ANDROID)
vtk_module(vtkRenderingFreeType
  GROUPS
    Rendering
  DEPENDS
    vtkRenderingCore
    vtkfreetype
    vtkftgl
  TEST_DEPENDS
    vtkTestingRendering
    vtkViewsContext2D
  )
else()
vtk_module(vtkRenderingFreeType
  GROUPS
    Rendering
  DEPENDS
    vtkRenderingCore
    vtkfreetype
    #vtkftgl
  TEST_DEPENDS
    vtkTestingRendering
    vtkViewsContext2D
  )
endif(NOT ANDROID)
