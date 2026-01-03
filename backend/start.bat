@echo off
echo Testing Java...
java -version
echo.
echo Testing Maven...
call mvn -version
echo.
echo If you see errors above, you need to install Java or Maven.
echo.
echo Starting Backend Application...
call mvn spring-boot:run
echo.
echo Application finished.
pause
