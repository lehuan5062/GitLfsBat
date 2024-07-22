:: Copyright 2024 Le Vuong Gia Huan

@echo off
setlocal enabledelayedexpansion

:: Find files larger than 100MB and save to temp file
forfiles /s /m *.* /c "cmd /c if @fsize gtr 104857600 echo @relpath" > temp_files.txt

:: Initialize .gitattributes file
echo # Git LFS configuration > .gitattributes

:: Process temp file and append to .gitattributes
for /f "delims=" %%F in (temp_files.txt) do (
    set filepath=%%F
    :: Remove leading backslash if present
    set filepath=!filepath:~3!
    :: Remove trailing " if present
    set filepath=!filepath:~0,-1!
    :: Replace backslashes with forward slashes
    set filepath=!filepath:\=/!
    echo !filepath! filter=lfs diff=lfs merge=lfs >> .gitattributes
)

:: Clean up temp file
del temp_files.txt

endlocal
