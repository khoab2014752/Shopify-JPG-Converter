@echo off
setlocal enabledelayedexpansion
set inputFolder=input

REM Check if input folder exists
if not exist "%inputFolder%" (
    echo Input folder "%inputFolder%" does not exist.
    exit /b 1
)

REM Check if input folder has image files (all common formats)
set hasFiles=0
for %%F in ("%inputFolder%\*.jpg" "%inputFolder%\*.jpeg" "%inputFolder%\*.png" "%inputFolder%\*.gif" "%inputFolder%\*.bmp" "%inputFolder%\*.tiff" "%inputFolder%\*.tif" "%inputFolder%\*.webp" "%inputFolder%\*.svg" "%inputFolder%\*.ico" "%inputFolder%\*.JPG" "%inputFolder%\*.JPEG" "%inputFolder%\*.PNG" "%inputFolder%\*.GIF" "%inputFolder%\*.BMP" "%inputFolder%\*.TIFF" "%inputFolder%\*.TIF" "%inputFolder%\*.WEBP" "%inputFolder%\*.SVG" "%inputFolder%\*.ICO") do (
    if exist "%%F" set hasFiles=1
)

if %hasFiles%==0 (
    echo No image files found in input folder.
    exit /b 1
)

REM Process each image file (all common formats)
for %%F in ("%inputFolder%\*.jpg" "%inputFolder%\*.jpeg" "%inputFolder%\*.png" "%inputFolder%\*.gif" "%inputFolder%\*.bmp" "%inputFolder%\*.tiff" "%inputFolder%\*.tif" "%inputFolder%\*.webp" "%inputFolder%\*.svg" "%inputFolder%\*.ico" "%inputFolder%\*.JPG" "%inputFolder%\*.JPEG" "%inputFolder%\*.PNG" "%inputFolder%\*.GIF" "%inputFolder%\*.BMP" "%inputFolder%\*.TIFF" "%inputFolder%\*.TIF" "%inputFolder%\*.WEBP" "%inputFolder%\*.SVG" "%inputFolder%\*.ICO") do (
    if exist "%%F" (
        echo Processing: %%F
        
        REM Extract filename without extension and force .jpg output
        set "filename=%%~nF"
        
        magick "%%F" ^
        -resize 145%% ^
        -background white ^
        -gravity center ^
        -extent 1800x2600+0-100 ^
        "!filename!.jpg"
        
        REM Check if conversion was successful before deleting
        if exist "!filename!.jpg" (
            echo Successfully processed: %%F
            del "%%F"
        ) else (
            echo Error processing: %%F
        )
    )
)

REM Check if any image files are left in input folder
set remainingFiles=0
for %%F in ("%inputFolder%\*.jpg" "%inputFolder%\*.jpeg" "%inputFolder%\*.png" "%inputFolder%\*.gif" "%inputFolder%\*.bmp" "%inputFolder%\*.tiff" "%inputFolder%\*.tif" "%inputFolder%\*.webp" "%inputFolder%\*.svg" "%inputFolder%\*.ico" "%inputFolder%\*.JPG" "%inputFolder%\*.JPEG" "%inputFolder%\*.PNG" "%inputFolder%\*.GIF" "%inputFolder%\*.BMP" "%inputFolder%\*.TIFF" "%inputFolder%\*.TIF" "%inputFolder%\*.WEBP" "%inputFolder%\*.SVG" "%inputFolder%\*.ICO") do (
    if exist "%%F" (
        echo Warning: File "%%F" remains in input folder
        set remainingFiles=1
    )
)

if %remainingFiles%==0 (
    echo All image files processed successfully.
)

exit /b 0