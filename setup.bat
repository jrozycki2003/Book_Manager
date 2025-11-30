@echo off
REM Book Manager Pro - Windows Setup Script

echo ==========================================
echo Book Manager Pro - Setup Script
echo ==========================================
echo.

echo Checking Ruby...
ruby -v
if %ERRORLEVEL% NEQ 0 (
    echo Error: Ruby is not installed. Please install Ruby 3.2+ first.
    pause
    exit /b 1
)

echo.
echo Installing dependencies...
call bundle install
if %ERRORLEVEL% NEQ 0 (
    echo Error: Failed to install dependencies
    pause
    exit /b 1
)

echo.
echo Setting up database...
call bin/rails db:create
if %ERRORLEVEL% NEQ 0 (
    echo Warning: Database creation failed. It may already exist.
)

call bin/rails db:migrate
if %ERRORLEVEL% NEQ 0 (
    echo Error: Database migration failed
    pause
    exit /b 1
)

call bin/rails db:seed
if %ERRORLEVEL% NEQ 0 (
    echo Error: Seeding database failed
    pause
    exit /b 1
)

echo.
echo ==========================================
echo Setup Complete!
echo ==========================================
echo.
echo To start the server, run:
echo   bin\rails server
echo.
echo Default login credentials:
echo   Admin:
echo     Email: admin@bookmanager.com
echo     Password: password123
echo.
echo   User 1:
echo     Email: john@example.com
echo     Password: password123
echo.
echo   User 2:
echo     Email: jane@example.com
echo     Password: password123
echo.
echo Application will be available at: http://localhost:3000
echo.
pause
