@echo off


REM check JAVA_HOME & java
if "%JAVA_HOME%" == "" goto noJavaHome
if exist "%JAVA_HOME%\bin\java.exe" goto mainEntry
:noJavaHome
echo ---------------------------------------------------
echo Error: JAVA_HOME environment variable is not set. 
echo ---------------------------------------------------
goto end

:mainEntry
REM set HOME_DIR
set "CURR_DIR=%cd%"
cd ..
set "COMM_HOME=%cd%"
cd %CURR_DIR%

if exist "%COMM_HOME%\bin\startup.bat" goto okHome
echo ---------------------------------------------------
echo Error: COMM_HOME environment variable is not defined correctly.
echo ---------------------------------------------------
goto end



:okHome


REM startup Server
set "RUN_CMD=java -Xms128m -Xmx2048m"
set "RUN_CMD=%RUN_CMD% -Dcomm.home="%COMM_HOME%""
set "RUN_CMD=%RUN_CMD% -cp "%COMM_HOME%\conf;%COMM_HOME%\lib\*""
set "RUN_CMD=%RUN_CMD% com.my.blog.website.CoreApplication"
set "RUN_CMD=%RUN_CMD% --logging.file="%COMM_HOME%\logs\stdout.log""
echo "%RUN_CMD%"
call %RUN_CMD%


:end


