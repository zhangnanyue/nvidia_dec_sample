#set min cmake version
cmake_minimum_required(VERSION 3.0) 

SET( CMAKE_CXX_FLAGS "-std=c++11 -O3")
add_compile_options(-std=c++11)
#set project name
set(PROJECTNAME nvidiadec)
project(${PROJECTNAME})   

# set(CUDA_DIR /usr/local/cuda/lib64/stubs)
# find_package(CUDA REQUIRED)

set(SOURCE_FILES  ./AppDec/NvDecoder.cpp
                  ./AppDec/AppDec.cpp
                  )

# set include 
set(INC_DIR ./include)
include_directories(${INC_DIR})
set(CUDA_INCLUDE_DIRS /usr/local/cuda/include)
include_directories(${CUDA_INCLUDE_DIRS})

#link cuda lib
set(CUDA_DYNAMIC_LIBS /usr/local/cuda/lib64/stubs)
add_library(_libcuda SHARED IMPORTED )
set_target_properties(_libcuda PROPERTIES IMPORTED_LOCATION "${CUDA_DYNAMIC_LIBS}/libcuda.so")
set(CUDA_LIBS  _libcuda )

#ink deco lib
set(CODEC_LIBS_DIR ${CMAKE_CURRENT_SOURCE_DIR}/lib)
add_library(nvcuvid SHARED IMPORTED )
set_target_properties(nvcuvid PROPERTIES IMPORTED_LOCATION "${CODEC_LIBS_DIR}/libnvcuvid.so")
add_library(encodec SHARED IMPORTED )
set_target_properties(encodec PROPERTIES IMPORTED_LOCATION "${CODEC_LIBS_DIR}/libnvidia-encode.so")
set(CODEC_LIBS nvcuvid encodec)

#link ffmpeg lib
set(ffmpeg_lib_dir /usr/local/ffmpeg/lib)
add_library(avcodec-58 SHARED IMPORTED)
set_target_properties(avcodec-58 PROPERTIES IMPORTED_LOCATION
        ${ffmpeg_lib_dir}/libavcodec.so)
add_library(avformat-58 SHARED IMPORTED)
set_target_properties(avformat-58 PROPERTIES IMPORTED_LOCATION
        ${ffmpeg_lib_dir}/libavformat.so)
add_library(avutil-56 SHARED IMPORTED)
set_target_properties(avutil-56 PROPERTIES IMPORTED_LOCATION
        ${ffmpeg_lib_dir}/libavutil.so)
set(FFMPEG_LIBS avcodec-58 avformat-58 avutil-56)

add_executable(${PROJECTNAME} ${SOURCE_FILES} ) 
target_link_libraries(  ${PROJECTNAME}     
                        ${FFMPEG_LIBS}
                        ${CUDA_LIBS}
                        ${CODEC_LIBS}
)
                               
                                      



