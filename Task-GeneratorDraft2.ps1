param(
[string] $taskName,
[int]$WaitSeconds
)


function Create-Task
{
 param(
[Parameter()]
 $argument,
 $execute,
 $interval,
 $name
 )

 $A = New-ScheduledTaskAction  -Execute PowerShell.exe -Argument $argument
 $T = New-ScheduledTaskTrigger   -At (Get-Date) -Once   -RepetitionInterval (New-TimeSpan -Minutes  $interval )
 $Task = Register-ScheduledTask  -Action $A -Trigger $T -TaskName $name


}

function Change-Status ($name)
{
 $task= Get-ScheduledTask -TaskName $name

if($task.State -eq "Running")
  {
   Stop-ScheduledTask -TaskName $name
   $task | Disable-ScheduledTask
  }
if($task.State -eq "Ready")
  {
  Stop-ScheduledTask -TaskName $name
  $task | Disable-ScheduledTask
  }   
}

function Get-AllTasks{

Get-ScheduledTask | Where-Object{$_.State -eq "Running"}
}

# from my understnding this is part 3, its written in part 3 to run the script 1 minute however it is not clear if meaning to the exacutable file or the main script itself
# sense in the expected result there is a confliect "A new task in the task scheduler that will run every X minute"
 Create-Task -argument "c:\mytask.ps1" -interval 1 -name $taskName 

# this can be enterd to Create-Task to keep the script to 3 functions like in expected result
 Start-ScheduledTask -TaskName $taskName 

# this can be enterd toChange-Status  to keep the script to 3 functions like in expected result
 Start-Sleep -s $WaitSeconds 

# this can be enterd to get-AllTasks   to keep the script to 3 functions like in expected result
 Change-Status -name $taskName
 Get-AllTasks|ForEach-Object {Write-Host $_.TaskName} 