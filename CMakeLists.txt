cmake_minimum_required(VERSION 3.9)
project(FaceRecognition VERSION 2.0 LANGUAGES C CXX)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_GENERATOR_PLATFORM x64)
set(CMAKE_BUILD_TYPE "Release")
set(REPOSITORY ${CMAKE_SOURCE_DIR}/third_party)

if (CMAKE_SYSTEM_NAME MATCHES "Windows")
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /we4013 /we4431 /we4133 /we4716 /we6244 /we6246 /we4457 /we4456 /we4172 /we4700 /we4477 /we4018 /we4047")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /we4013 /we4431 /we4133 /we4716 /we6244 /we6246 /we4457 /we4456 /we4172 /we4700 /we4477 /we4018 /we4047")
endif()

include_directories(${CMAKE_SOURCE_DIR}/include/)

add_subdirectory(${CMAKE_SOURCE_DIR}/third_party/gflags ${CMAKE_SOURCE_DIR}/third_party/gflags)
get_target_property(GFLAGS_INCLUDE_DIRS gflags INTERFACE_INCLUDE_DIRECTORIES)
include_directories(BEFORE "${GFLAGS_INCLUDE_DIRS}")
link_libraries(gflags)

include_directories(${REPOSITORY}/TNN/include/)
link_directories(${REPOSITORY}/TNN/lib)
aux_source_directory(${CMAKE_SOURCE_DIR}/src/ SRC_FILES)

find_package(OpenCV REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})

#SHARED/STATIC
add_library(${PROJECT_NAME} STATIC ${SRC_FILES})
target_link_libraries(${PROJECT_NAME} TNN)

link_directories(${CMAKE_CURRENT_BINARY_DIR}/)

aux_source_directory(${CMAKE_SOURCE_DIR}/demo/ DEMO_SRC)
add_executable(DemoFaceRecognition ${DEMO_SRC} )
target_link_libraries(DemoFaceRecognition ${OpenCV_LIBS} ${PROJECT_NAME})

