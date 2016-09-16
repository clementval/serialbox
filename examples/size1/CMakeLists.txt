CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
PROJECT(2D_SIZE1_SERIALBOX_FORTRAN_SAMPLE NONE)
ENABLE_LANGUAGE(Fortran)

set(SERIALBOX_DIR "${CMAKE_SOURCE_DIR}/../../install/")
set(SERIALBOXI "${SERIALBOX_DIR}/${COMPILER}/include/SerialBox/")
set(SERIALBOXL "${SERIALBOX_DIR}/lib")
SET(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -cpp -ffree-form -ffree-line-length-180 -J.")
add_definitions(-DSERIALIZE)

file(MAKE_DIRECTORY pp) # Destination directory for the pp_ser processed files

include_directories(${SERIALBOXI})
include_directories("${SERIALBOX_DIR}/include/fortran")
link_directories(${SERIALBOXL})


# generate preprocessed files with pp_ser
ADD_CUSTOM_COMMAND(
  OUTPUT pp/main_consumer.f90 pp/main_producer.f90
  COMMAND ${CMAKE_SOURCE_DIR}/../../python/pp_ser.py -d pp ${CMAKE_SOURCE_DIR}/main_consumer.f90
  COMMAND ${CMAKE_SOURCE_DIR}/../../python/pp_ser.py -d pp ${CMAKE_SOURCE_DIR}/main_producer.f90
  DEPENDS main_consumer.f90 main_producer.f90
)

ADD_EXECUTABLE(
  main_producer
  pp/main_producer.f90
)

ADD_EXECUTABLE(
  main_consumer
  pp/main_consumer.f90
)

target_link_libraries(main_producer FortranSer.a)
target_link_libraries(main_producer SerialboxWrapper.a)
target_link_libraries(main_producer Serialbox.a)
target_link_libraries(main_producer Utils.a)
target_link_libraries(main_producer sha256.a)
target_link_libraries(main_producer json.a)
target_link_libraries(main_producer stdc++)

target_link_libraries(main_consumer FortranSer.a)
target_link_libraries(main_consumer SerialboxWrapper.a)
target_link_libraries(main_consumer Serialbox.a)
target_link_libraries(main_consumer Utils.a)
target_link_libraries(main_consumer sha256.a)
target_link_libraries(main_consumer json.a)
target_link_libraries(main_consumer stdc++)


