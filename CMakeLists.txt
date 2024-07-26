cmake_minimum_required(VERSION 3.5)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

SET(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -O0 -Wall -g2 -ggdb")
SET(CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -O3 -Wall")

PROJECT(vr2ar-converter)
set(Target vr2ar-converter)

SET(NCNN_INSTALL_DIR $ENV{NCNN_INSTALL_DIR})
SET(OpenCV_DIR $ENV{OpenCV_DIR})

find_package(OpenCV REQUIRED)
find_package(ncnn REQUIRED)

include_directories(${OpenCV_INCLUDE_DIRS} )
include_directories(${PROJECT_SOURCE_DIR}/src)
include_directories(${NCNN_INSTALL_DIR}/include/ncnn)

add_executable(${Target} src/${Target}.cpp)
link_directories(${OpenCV_LIBRARY_DIRS})

target_link_libraries(${Target} ${OpenCV_LIBRARIES})
target_link_libraries (${Target} ${NCNN_INSTALL_DIR}/lib/libncnn.so -fopenmp)

