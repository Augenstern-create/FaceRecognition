@echo off

set ROOT_DIR=%~dp0
set BUILD_DIR=%ROOT_DIR%\build
set EXAMPLE_INSTALL_PATH=%BUILD_DIR%\Release
set TNN_BIN_PATH=%ROOT_DIR%\third_party\tnn\bin

mkdir %BUILD_DIR%
cd %BUILD_DIR%

cmake .. ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_SYSTEM_NAME=Windows ^
    -DCMAKE_SYSTEM_PROCESSOR=AMD64 

if !errorlevel! == 1 (
    echo Building TNN Examples Failed
    goto errorHandle
)

cmake --build . --config Release -j4

if !errorlevel! == 1 (
    echo Building TNN Examples Failed
    goto errorHandle
)

if not exist %EXAMPLE_INSTALL_PATH% (
    mkdir %EXAMPLE_INSTALL_PATH%
)

@REM for %%e in (.\*.exe) do copy "%%e" %EXAMPLE_INSTALL_PATH%
for %%e in (%TNN_BIN_PATH%\*.dll) do copy "%%e" %EXAMPLE_INSTALL_PATH%
for /R %OpenCV_DIR% %%e in (*.dll) do copy "%%e" %EXAMPLE_INSTALL_PATH%

