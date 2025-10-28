@echo off
setlocal enabledelayedexpansion

if "%~1"=="" (
    echo Usage: convert_png_folder.bat path_to_folder
    exit /b
)

set "folder=%~1"
echo Converting all PNGs in: %folder%

for %%f in ("%folder%\*.png") do (
    set "fname=%%~nf"
    echo Processing %%f ...

    set "format=BC7_UNORM_SRGB"
    echo !fname! | findstr /I "ng" >nul && set "format=BC7_UNORM"

    echo Using format !format!
    texconv.exe -f BC7_UNORM_SRGB -m 0 -if LINEAR -sepalpha -y -nologo -nogpu -o "%folder%" "%%f"

if exist "%folder%\%%~nf.DDS" (
    ren "%folder%\%%~nf.DDS" "%%~nf.dds"
    echo   Output: %folder%\%%~nf.dds
) else (
    echo   !! No DDS created for %%f !!
)

)

echo Done.
pause
