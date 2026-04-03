$cmake = "C:\Program Files\Microsoft Visual Studio\18\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"
# Use junction path to avoid Japanese characters in path
$srcDir = "C:\libchardet_build"
$buildDir = "C:\libchardet_build\build2"
$realOutDir = "C:\Users\asano\OneDrive\デスクトップ\workspace\libchardet\release_package"

Write-Host "=== Regenerating CMake build (Visual Studio 18 2026 / x64) ===" -ForegroundColor Cyan
Remove-Item "$buildDir\CMakeCache.txt" -ErrorAction SilentlyContinue

& $cmake -S $srcDir -B $buildDir -G "Visual Studio 18 2026" -A x64
if ($LASTEXITCODE -ne 0) { Write-Error "CMAKE CONFIGURE FAILED"; exit 1 }

Write-Host "=== Building chardet (Release/x64) ===" -ForegroundColor Cyan
& $cmake --build $buildDir --config Release --clean-first
if ($LASTEXITCODE -ne 0) { Write-Error "BUILD FAILED"; exit 1 }

Write-Host "=== Creating release package ===" -ForegroundColor Cyan
if (Test-Path $realOutDir) { Remove-Item $realOutDir -Recurse -Force }
New-Item -ItemType Directory "$realOutDir\bin" | Out-Null
New-Item -ItemType Directory "$realOutDir\lib" | Out-Null
New-Item -ItemType Directory "$realOutDir\include" | Out-Null

Copy-Item "$buildDir\Release\chardet.dll" "$realOutDir\bin\"
Copy-Item "$buildDir\Release\chardet.lib" "$realOutDir\lib\"
Copy-Item "$srcDir\src\chardet.h" "$realOutDir\include\"
Copy-Item "$srcDir\include\version.h" "$realOutDir\include\"

Write-Host "=== Package contents ===" -ForegroundColor Cyan
Get-ChildItem $realOutDir -Recurse | Select-Object FullName, Length
Write-Host "=== Done ===" -ForegroundColor Green
