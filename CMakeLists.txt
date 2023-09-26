cmake_minimum_required(VERSION 3.26)

set(CMAKE_TOOLCHAIN_FILE ${CMAKE_SOURCE_DIR}/CMake/toolchain.cmake)

project(Test C )
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/CMake" ${CMAKE_MODULE_PATH})

add_subdirectory(Docs)

file(GLOB ST_HAL_C "${CMAKE_SOURCE_DIR}/Drivers/STM32F4xx_HAL_Driver/Src/*.c")
file(GLOB CORE_C "${CMAKE_SOURCE_DIR}/Core/Src/*.c")
file(GLOB ST_HAL_H "${CMAKE_SOURCE_DIR}/Drivers/STM32F4xx_HAL_Driver/Inc/*.h")
file(GLOB CORE_H "${CMAKE_SOURCE_DIR}/Core/Inc/*.h")



add_executable(${PROJECT_NAME} ${CORE_C} ${CORE_H} ${ST_HAL_C} ${ST_HAL_H} ${CMAKE_SOURCE_DIR}/startup_stm32f412rx.s)

target_include_directories(${PROJECT_NAME} PRIVATE 
    ${CMAKE_SOURCE_DIR}/Drivers/STM32F4xx_HAL_Driver/Inc
    ${CMAKE_SOURCE_DIR}/Drivers/CMSIS/Device/ST/STM32F4xx/Include
    ${CMAKE_SOURCE_DIR}/Core/Inc
    ${CMAKE_SOURCE_DIR}/Drivers/CMSIS/Include

)
set(ELF_OUTPUT_FILE ${CMAKE_BINARY_DIR}/bin/${PROJECT_NAME}.elf)
set(HEX_OUTPUT_FILE ${CMAKE_BINARY_DIR}/bin/${PROJECT_NAME}.hex)
set(BIN_OUTPUT_FILE ${CMAKE_BINARY_DIR}/bin/${PROJECT_NAME}.bin)

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${PROJECT_NAME}> ${ELF_OUTPUT_FILE}
    COMMAND ${CMAKE_OBJCOPY} -O ihex $<TARGET_FILE:${PROJECT_NAME}> ${HEX_OUTPUT_FILE}
    COMMAND arm-none-eabi-objcopy -O binary ${ELF_OUTPUT_FILE} ${BIN_OUTPUT_FILE}
)
target_compile_definitions(${PROJECT_NAME} PRIVATE
    USE_HAL_DRIVER
    STM32F412Rx
)