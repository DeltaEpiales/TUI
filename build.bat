@echo off
echo Assembling main.asm...
nasm -O0 -w-label-redef-late -f win64 main.asm -o main.obj
nasm -f win64 highlight.asm -o highlight.obj
if errorlevel 1 goto error

echo Linking...
gcc main.obj highlight.obj -o editor.exe -mwindows -luser32 -lkernel32 -lgdi32 -lcomctl32 -ldwmapi -lcomdlg32
if errorlevel 1 goto error

echo Build successful.
exit /b 0

:error
echo Build failed.
exit /b 1
