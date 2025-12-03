# Define the action: What the scheduled task will execute
# This example runs a PowerShell script located at C:\Scripts\MyScript.ps1
$Action = New-ScheduledTaskAction -Execute "shutdown.exe" -Argument "-s"

# Define the trigger: When the scheduled task will run
# This example sets a daily trigger at 9:00 AM

$Trigger = @(
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Sunday,Monday,Tuesday,Wednesday,Thursday -At "11:30 PM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday,Tuesday,Wednesday,Thursday,Friday -At "12:00 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday,Tuesday,Wednesday,Thursday,Friday -At "12:30 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday,Tuesday,Wednesday,Thursday,Friday -At "1:00 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday,Tuesday,Wednesday,Thursday,Friday -At "1:30 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday,Tuesday,Wednesday,Thursday,Friday -At "2:00 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday,Tuesday,Wednesday,Thursday,Friday -At "2:30 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday,Tuesday,Wednesday,Thursday,Friday -At "3:00 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday,Tuesday,Wednesday,Thursday,Friday -At "3:30 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday,Tuesday,Wednesday,Thursday,Friday -At "4:00 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Saturday,Sunday -At "2:00 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Saturday,Sunday -At "2:30 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Saturday,Sunday -At "3:00 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Saturday,Sunday -At "3:30 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Saturday,Sunday -At "4:00 AM"),
    $(New-ScheduledTaskTrigger -Weekly -DaysOfWeek Saturday,Sunday -At "4:30 AM")
)

# This ensures we don't "synchronize across time zones" - we want to be warned at 11:30PM no mattter what the time zone:
foreach ($trig in $Trigger)
{
    if($trig.StartBoundary.EndsWith("Z"))
    {
        # $trig.StartBoundary = $[DateTime]::Parse($trig.StartBoundary).ToString("yyyy-MM-ddTHH:mm:ss")
        $trig.StartBoundary = $([DateTime]::Parse($trig.StartBoundary).ToString("yyyy-MM-ddTHH:mm:ss"))
    }
}


# Define the principal (optional, but recommended for specific user context)
# This example sets the task to run under the SYSTEM account with highest privileges
$Principal = New-ScheduledTaskPrincipal -UserId "$env:USERNAME" -LogonType Interactive

# Define the settings (optional): How the scheduled task behaves
# This example sets the task to run even if the computer is on battery power
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

# Register the scheduled task
Register-ScheduledTask -TaskName "Shutdown" -Action $Action -Trigger $Trigger -Principal $Principal -Settings $Settings -Description "Shutdown the system at night"

