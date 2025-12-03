# Define the action: What the scheduled task will execute
# This example runs a PowerShell script located at C:\Scripts\MyScript.ps1
$Action = New-ScheduledTaskAction -Execute ":\Utilities\msg.exe" -Argument "* The system will shutdown in 10 minutes"

# Define the trigger: When the scheduled task will run
# This example sets a daily trigger at 9:00 AM

$Trigger = @(
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Sunday,Monday,Tuesday,Wednesday,Thursday -At "11:20 PM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday,Tuesday,Wednesday,Thursday,Friday -At "11:50 PM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday,Tuesday,Wednesday,Thursday,Friday -At "12:20 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday,Tuesday,Wednesday,Thursday,Friday -At "12:50 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday,Tuesday,Wednesday,Thursday,Friday -At "1:20 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday,Tuesday,Wednesday,Thursday,Friday -At "1:50 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday,Tuesday,Wednesday,Thursday,Friday -At "2:20 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday,Tuesday,Wednesday,Thursday,Friday -At "2:50 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday,Tuesday,Wednesday,Thursday,Friday -At "3:20 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday,Tuesday,Wednesday,Thursday,Friday -At "3:50 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Saturday,Sunday -At "1:50 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Saturday,Sunday -At "2:20 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Saturday,Sunday -At "2:50 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Saturday,Sunday -At "3:20 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Saturday,Sunday -At "3:50 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Saturday,Sunday -At "4:20 AM")
)



# Define the principal (optional, but recommended for specific user context)
# This example sets the task to run under the SYSTEM account with highest privileges
$Principal = New-ScheduledTaskPrincipal -UserId "$env:USERNAME" -LogonType Interactive

# Define the settings (optional): How the scheduled task behaves
# This example sets the task to run even if the computer is on battery power
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

# Register the scheduled task
Register-ScheduledTask -TaskName "Shutdown-warning" -Action $Action -Trigger $Trigger -Principal $Principal -Settings $Settings -Description "Shutdown the system at night"

