param(
 [Parameter(Mandatory=$true)]
[string] $taskName,

[Parameter(Mandatory=$true)]
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
  Register-ScheduledTask  -Action $A -Trigger $T -TaskName $name

}

function Change-Status ($name)
{
 $task= Get-ScheduledTask -TaskName $name

if($task.State -ne "Disabled"){

   $task | Disable-ScheduledTask
  }
  else {
    $task | Enable-ScheduledTask
  }
  
}

function Get-AllTasks{

Get-ScheduledTask | Where-Object{$_.State -eq "Running"}
}

 Create-Task -argument "C:\Users\Ben\Desktop\Scripts\WriteToNotepad.ps1" -interval 1 -name $taskName 
 Start-Sleep -s $WaitSeconds 
 Change-Status -name $taskName
 Get-AllTasks|ForEach-Object {Write-Host $_.TaskName} 