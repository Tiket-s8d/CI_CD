set(TARGET_CPU "cortex-m4")
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_C_COMPILER "arm-none-eabi-gcc")
set(CMAKE_CXX_COMPILER "arm-none-eabi-g++")
set(CMAKE_OBJECT_PATH_MAX 500)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
# Select C/C++ version
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 14)

add_compile_options(
    -mcpu=cortex-m4 -std=gnu11 -g3
    -O0 -ffunction-sections -fcommon -fdata-sections -Wall -fstack-usage --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb
    -MMD -MP
)

add_link_options(
    -mcpu=cortex-m4 -T "${CMAKE_SOURCE_DIR}/STM32F412RETX_FLASH.ld" --specs=nosys.specs -Wl,--gc-sections --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -Wl,--start-group -lc -lm -Wl,--end-group
)
