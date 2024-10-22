@echo off
setlocal enabledelayedexpansion

:: Read arguments (first argument is environment, second is branch)
set ENV=%1
set BRANCH=%2

if "%ENV%"=="" (
    echo "No environment specified. Defaulting to QA."
    set ENV=qa
)
if "%BRANCH%"=="" (
    echo "No branch specified. Defaulting to master."
    set BRANCH=master
)

:: Print environment and branch
if "%ENV%"=="dev" (
    echo Environment: Development and branch: %BRANCH%
) else (
    echo Environment: QA and branch: master
)

:: Clean up old directories and create new ones
rmdir /S /Q protos
rmdir /S /Q temp
mkdir temp
mkdir protos

:: Switch to temp directory
cd temp

:: Clone repositories and switch branch if needed
call :clone_and_copy "https://github.com/HeartfulnessInstitute/heartintune-common" "heartintune-common-api/src/main/proto/*"
call :clone_and_copy "https://github.com/HeartfulnessInstitute/heartintune-profile-service.git" "heartintune-profile-api/src/main/proto/"
call :clone_and_copy "https://github.com/HeartfulnessInstitute/gamification-service.git" "gamification-api/src/main/proto/"
call :clone_and_copy "https://github.com/HeartfulnessInstitute/guided-meditation-service.git" "guided-meditation-api/src/main/proto/"
call :clone_and_copy "https://github.com/HeartfulnessInstitute/live-meditation-service.git" "live-meditation-api/src/main/proto/"
call :clone_and_copy "https://github.com/HeartfulnessInstitute/hfn-events-service.git" "hfn-events-api/src/main/proto/"

:: Clean up temp directory
cd ..
rmdir /S /Q temp

echo "Protos copied successfully."
exit /B

:: Function to clone repository, switch branch if needed, and copy files
:clone_and_copy
git clone %1
set REPO_NAME=%~n1

if "%ENV%"=="dev" (
    cd !REPO_NAME!
    git switch %BRANCH%
    cd ..
)

xcopy /E /I /Y !REPO_NAME!\%2 ..\protos
exit /B
