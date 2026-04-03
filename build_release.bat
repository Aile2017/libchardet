@echo off
set CMAKE="C:\Program Files\Microsoft Visual Studio\18\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"
set MSBUILD="C:\Program Files\Microsoft Visual Studio\18\Community\MSBuild\Current\Bin\amd64\MSBuild.exe"
set SRCDIR=%~dp0
set BUILDDIR=%~dp0build2

echo === Regenerating CMake build (Visual Studio 18 2026 / x64) ===
if exist "%BUILDDIR%\CMakeCache.txt" del "%BUILDDIR%\CMakeCache.txt"
%CMAKE% -S "%SRCDIR%" -B "%BUILDDIR%" -G "Visual Studio 18 2026" -A x64
if %ERRORLEVEL% neq 0 (
    echo CMAKE CONFIGURE FAILED
    exit /b %ERRORLEVEL%
)

echo === Building chardet (Release/x64) ===
%CMAKE% --build "%BUILDDIR%" --config Release --clean-first
if %ERRORLEVEL% neq 0 (
    echo BUILD FAILED
    exit /b %ERRORLEVEL%
)

echo === Creating release package ===
set OUTDIR=%~dp0release_package
if exist "%OUTDIR%" rmdir /s /q "%OUTDIR%"
mkdir "%OUTDIR%\bin"
mkdir "%OUTDIR%\lib"
mkdir "%OUTDIR%\include"

copy "%BUILDDIR%\Release\chardet.dll" "%OUTDIR%\bin\"
copy "%BUILDDIR%\Release\chardet.lib" "%OUTDIR%\lib\"
copy "%SRCDIR%src\chardet.h" "%OUTDIR%\include\"
copy "%SRCDIR%include\version.h" "%OUTDIR%\include\"

echo === Package contents ===
dir /s /b "%OUTDIR%"
echo === Done ===
