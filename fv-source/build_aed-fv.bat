REM @echo off

cd fv-source

for /f "usebackq delims=#" %%a in (`"%programfiles(x86)%\Microsoft Visual Studio\Installer\vswhere" -latest -property installationPath`) do set VS_BASE_PATH=%%a\Common7
set VS_BASE_PATH=%programfiles(x86)%\Microsoft Visual Studio\2019\Community\Common7

call "%VS_BASE_PATH%\Tools\VsDevCmd.bat" -arch=amd64

cd libaed-fv\win

"%VS_BASE_PATH%\IDE\devenv" tuflowfv_external_wq.sln /Build "Release|x64"
