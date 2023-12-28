@echo off
set "file=index.html"
set "scriptDir=%~dp0"
set "chromePath=C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"

:checkPath
    if not exist "%chromePath%" (
        set /p chromePath="Enter the path to Google Chrome: "
        goto checkPath
    ) else (
        echo "Found Google Chrome @ '%chromePath%'"
    )
	
echo "ScriptDir: '%scriptDir%'"
set "userDir=%TEMP%/Presentation/chrome-data"
echo "UserDir: '%userDir%'"
"%chromePath%" "--new-window" "--disable-web-security" "--user-data-dir=%userDir%" "%scriptDir%/%file%"