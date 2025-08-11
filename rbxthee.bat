@echo off
title RBX-THEENA Roblox Optimizer
color 0A
setlocal enabledelayedexpansion
mode con cols=80 lines=30

REM === Sound Function ===
set "beep=powershell -NoProfile -Command [console]::beep(800,200)"

REM === RBX-THEENA Roblox Optimizer ===
echo   Advanced Roblox Performance Optimizer
echo   Version 1.0 (Initial Release)
echo.
echo   Loading system information...

REM === 1. Detect System Information ===
for /f %%A in ('powershell -NoProfile -Command "(Get-WmiObject Win32_Processor).NumberOfCores"') do set cores=%%A
for /f %%B in ('powershell -NoProfile -Command "(Get-WmiObject Win32_Processor).NumberOfLogicalProcessors"') do set logical=%%B
for /f "tokens=*" %%C in ('powershell -NoProfile -Command "(Get-WmiObject Win32_Processor).Name"') do set cpuname=%%C
for /f "tokens=*" %%D in ('powershell -NoProfile -Command "(Get-WmiObject Win32_ComputerSystem).TotalPhysicalMemory/1GB"') do set rammb=%%D
for /f "tokens=*" %%E in ('powershell -NoProfile -Command "(Get-CimInstance Win32_VideoController).Name"') do set gpuname=%%E

if "%logical%"=="" (
    echo [ERROR] Unable to detect CPU information.
    echo Press any key to exit...
    pause > nul
    exit /b
)

cls

echo   System Information:
echo   - CPU: %cpuname%
echo   - Cores: %cores% physical cores, %logical% logical processors
echo   - RAM: %rammb% GB
echo   - GPU: %gpuname%
echo.

set /a ratio=%logical% / %cores%
if %ratio% GEQ 2 (
    echo   [i] Hyper-Threading is enabled
) else (
    echo   [!] Hyper-Threading is disabled or not supported
    echo       Optimization will still proceed but may be less effective
)
echo.

REM === 2. Affinity mask table ===
set "affinity2=2"
set "affinity4=10"
set "affinity6=42"
set "affinity8=170"
set "affinity12=2730"
set "affinity16=43690"
set "affinity20=699050"
set "affinity24=11184810"
set "affinity32=2863311530"
set "affinity48=187649984473770"

set "affinity="
for %%A in (2 4 6 8 12 16 20 24 32 48) do (
    if %logical%==%%A set "affinity=!affinity%%A!"
)

if "%affinity%"=="" (
    echo Unsupported number of logical CPU threads.
    pause
    exit /b
)

REM === 3. Auto-select Expert Optimization ===
echo   [i] Auto-selecting Expert Optimization mode...
echo   [i] Starting optimization automatically...
goto expert

:expert
echo.
echo   [i] Starting Expert Optimization...
echo   [i] Waiting for RobloxPlayerBeta.exe...

:waitloop_expert
for /f %%P in ('powershell -NoProfile -Command "(Get-Process RobloxPlayerBeta -ErrorAction SilentlyContinue).Id"') do set PID=%%P
if "%PID%"=="" (
    timeout /t 1 >nul
    goto waitloop_expert
)

echo   [i] Roblox found with PID=%PID%
powershell -NoProfile -Command [console]::beep(1500,400)

REM === Apply Core Optimizations ===
echo   [i] Setting process priority to High...
powershell -NoProfile -Command "Get-Process -Id %PID% | ForEach-Object { $_.PriorityClass = 'High' }"

echo   [i] Setting optimal CPU Affinity...
powershell -NoProfile -Command "$p = Get-Process -Id %PID%; $p.ProcessorAffinity = %affinity%"

REM === Apply Advanced Network Optimizations ===
echo   [i] Applying expert network optimizations...
powershell -NoProfile -Command "Set-NetTCPSetting -SettingName InternetCustom -AutoTuningLevelLocal Normal" >nul 2>&1
powershell -NoProfile -Command "Set-NetTCPSetting -SettingName InternetCustom -ScalingHeuristics Enabled" >nul 2>&1
powershell -NoProfile -Command "Set-NetTCPSetting -SettingName InternetCustom -InitialCongestionWindow 16" >nul 2>&1
powershell -NoProfile -Command "Set-NetTCPSetting -SettingName InternetCustom -CongestionProvider CTCP" >nul 2>&1

REM === Apply Memory Optimizations ===
echo   [i] Optimizing memory usage (expert mode)...
powershell -NoProfile -Command "Get-Process RobloxPlayerBeta | ForEach-Object { $_.MaxWorkingSet = [System.IntPtr]::new(1024*1024*1024) }" >nul 2>&1

REM === Apply GPU Optimizations ===
echo   [i] Applying GPU optimizations...
powershell -NoProfile -Command "$regPath = 'HKCU:\Software\Roblox\RobloxPlayer\Preferences'; if(!(Test-Path $regPath)) { New-Item -Path $regPath -Force | Out-Null }; New-ItemProperty -Path $regPath -Name 'DFIntTaskSchedulerTargetFPS' -Value 240 -PropertyType 'DWord' -Force | Out-Null" >nul 2>&1

REM === Apply Texture Quality Optimizations ===
echo   [i] Optimizing texture quality settings...
powershell -NoProfile -Command "$regPath = 'HKCU:\Software\Roblox\RobloxPlayer\Preferences'; New-ItemProperty -Path $regPath -Name 'DFIntTextureQuality' -Value 1 -PropertyType 'DWord' -Force | Out-Null" >nul 2>&1

REM === Apply Input Latency Optimizations ===
echo   [i] Reducing input latency...
powershell -NoProfile -Command "$regPath = 'HKCU:\Software\Roblox\RobloxPlayer\Preferences'; New-ItemProperty -Path $regPath -Name 'DFIntMouseSensitivityShift' -Value 1 -PropertyType 'DWord' -Force | Out-Null" >nul 2>&1

REM === Apply Windows Game Mode Optimization ===
echo   [i] Configuring Windows Game Mode...
powershell -NoProfile -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\GameBar' -Name 'AllowAutoGameMode' -Value 1 -Type DWord" >nul 2>&1
powershell -NoProfile -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\GameBar' -Name 'AutoGameModeEnabled' -Value 1 -Type DWord" >nul 2>&1

REM === Apply DirectX Optimizations ===
echo   [i] Optimizing DirectX settings...
powershell -NoProfile -Command "$regPath = 'HKCU:\Software\Roblox\RobloxPlayer\Preferences'; New-ItemProperty -Path $regPath -Name 'DFIntMaxTextureSize' -Value 1024 -PropertyType 'DWord' -Force | Out-Null" >nul 2>&1
powershell -NoProfile -Command "$regPath = 'HKCU:\Software\Roblox\RobloxPlayer\Preferences'; New-ItemProperty -Path $regPath -Name 'DFIntDebugGraphicsPreferVulkan' -Value 0 -PropertyType 'DWord' -Force | Out-Null" >nul 2>&1
powershell -NoProfile -Command "$regPath = 'HKCU:\Software\Roblox\RobloxPlayer\Preferences'; New-ItemProperty -Path $regPath -Name 'DFIntDebugGraphicsPreferD3D11' -Value 1 -PropertyType 'DWord' -Force | Out-Null" >nul 2>&1

REM === Apply Shader Cache Optimization ===
echo   [i] Optimizing shader cache...
powershell -NoProfile -Command "$regPath = 'HKCU:\Software\Roblox\RobloxPlayer\Preferences'; New-ItemProperty -Path $regPath -Name 'DFIntMaxCachedPatches' -Value 64 -PropertyType 'DWord' -Force | Out-Null" >nul 2>&1
powershell -NoProfile -Command "$regPath = 'HKCU:\Software\Roblox\RobloxPlayer\Preferences'; New-ItemProperty -Path $regPath -Name 'DFIntShaderCacheSizeKB' -Value 307200 -PropertyType 'DWord' -Force | Out-Null" >nul 2>&1

REM === Apply Thread Optimization ===
echo   [i] Optimizing thread usage...
powershell -NoProfile -Command "$regPath = 'HKCU:\Software\Roblox\RobloxPlayer\Preferences'; New-ItemProperty -Path $regPath -Name 'DFIntMaxNumJobsPerTask' -Value %cores% -PropertyType 'DWord' -Force | Out-Null" >nul 2>&1
powershell -NoProfile -Command "$regPath = 'HKCU:\Software\Roblox\RobloxPlayer\Preferences'; New-ItemProperty -Path $regPath -Name 'DFIntRenderThreadCount' -Value %cores% -PropertyType 'DWord' -Force | Out-Null" >nul 2>&1

REM === Apply Physics Optimization ===
echo   [i] Optimizing physics engine...
powershell -NoProfile -Command "$regPath = 'HKCU:\Software\Roblox\RobloxPlayer\Preferences'; New-ItemProperty -Path $regPath -Name 'DFIntPhysicsSenderRate' -Value 120 -PropertyType 'DWord' -Force | Out-Null" >nul 2>&1
powershell -NoProfile -Command "$regPath = 'HKCU:\Software\Roblox\RobloxPlayer\Preferences'; New-ItemProperty -Path $regPath -Name 'DFIntPhysicsReceiveRate' -Value 240 -PropertyType 'DWord' -Force | Out-Null" >nul 2>&1

REM === Disable Background Apps ===
echo   [i] Optimizing system resources...
powershell -NoProfile -Command "Get-Process | Where-Object {$_.ProcessName -ne 'RobloxPlayerBeta' -and $_.ProcessName -ne 'explorer' -and $_.ProcessName -ne 'cmd' -and $_.ProcessName -ne 'powershell' -and $_.ProcessName -ne 'System' -and $_.PriorityClass -ne 'High' -and $_.PriorityClass -ne 'RealTime'} | ForEach-Object { try { $_.PriorityClass = 'BelowNormal' } catch {} }" >nul 2>&1

REM === Apply Power Plan Optimization ===
echo   [i] Setting high performance power plan...
powershell -NoProfile -Command "powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c" >nul 2>&1

echo   [i] Expert optimizations applied successfully!
powershell -NoProfile -Command [console]::beep(2000,600)
echo.
echo   [i] All optimizations complete. Window will close in 3 seconds...

REM === Auto close after completion ===
timeout /t 3 >nul
exit