@echo off
setlocal

REM default behavior is to build against uima-cpp SDK image, specified by UIMACPP_HOME
REM alternate behavior is to override any or all of the dependent libraries

REM need a Java JRE for the JNI interface
if "%JAVA_HOME%"==""    set    JAVA_HOME=c:\PROGRA~1\IBM\Java142
if not exist %JAVA_HOME%\include\jni.h goto nojava

REM If UIMACPP_HOME undefined, all dependencies must be defined
if not "%UIMACPP_HOME%"=="" (
  REM default the overrides if not set
  if "%APR_HOME%"==""     set APR_HOME=%UIMACPP_HOME%/noPlace
  if "%ICU_HOME%"==""     set ICU_HOME=%UIMACPP_HOME%/noPlace
  if "%XERCES_HOME%"==""  set XERCES_HOME=%UIMACPP_HOME%/noPlace
)else (
  REM UIMACPP_HOME undefined, all dependencies must be defined
  if "%APR_HOME%"==""     goto noapr
    echo remember to set APR_VER=-1 to use APR version 1.x
  if "%ICU_HOME%"==""     goto noicu
  if "%XERCES_HOME%"==""  goto noxerces
)

REM Start project build
devenv uimacpp.sln /build release
goto end

:noapr
echo need UIMACPP_HOME or APR_HOME to be set
goto end

:noicu
echo need UIMACPP_HOME or ICU_HOME to be set
goto end

:noxerces
echo need UIMACPP_HOME or XERCES_HOME to be set
goto end

:nojava
echo %JAVA_HOME%\include does not exist or does not contain jni.h

:end
endlocal