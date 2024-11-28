$Outlook = New-Object -ComObject Outlook.Application

$TobeProcessedFolder = $outlook.Session.Folders.Item("Robotpl1.rpa.external@atos.net").Folders.Item("Inbox").Folders.Item("VMWWIN").Folders.Item("To be processed")

$AllEmails = $TobeProcessedFolder.Items

function APICall
{
    $tenant = "PRD_IDM_BRIDGE"  
    $usernameOrEmailAddress = "a892235"   
    $password = "GAsikarako007664!" 


    $authUrl = "https://nluipprdwin001.saacon.net/api/Account/Authenticate"


    $body = @{
        tenancyName = $tenant
        usernameOrEmailAddress = $usernameOrEmailAddress
        password = $password
    } | ConvertTo-Json

    
    $response = Invoke-RestMethod -Uri $authUrl -Method Post -Body $body -ContentType “application/json”
    $accessToken = $response.result

    
    $Header = @{
        "authorization" = "Bearer $accessToken"
        "Content-Type" = "application/json"
        "X-UIPATH-TenantName" = "$tenant"
        "X-UIPATH-OrganizationUnitId" = "10"
    }

    $processName = "BriAut_BDEPL1_ORG_VMWWIN_PL_Test"

    $ReleaseKeyUri = "https://nluipprdwin001.saacon.net/odata/Releases?%24filter=ProcessKey%20eq%20'"+$processName+"'"
    $resultReleases = Invoke-RestMethod -Method GET -Uri $ReleaseKeyUri -Headers $Header
    $releaseKey = $resultReleases.value[0].Key
    
    $body = @{
        "startInfo" = @{
            "ReleaseKey" = $releaseKey
            "Strategy" = "ModernJobsCount"
            "RobotIds" = @(74) 
            "NoOfRobots" = 1   
            "JobsCount" = 1    
            "Source" = "Manual" 
            "JobPriority" = "Normal"
            "RuntimeType" = "Unattended"
            "InputArguments" = ""  
            "Reference" = ""       
            "MachineRobots" = @(
                @{
                    "MachineId" = 14
                    "MachineName" = "NLUIPPRDWIN007"
                    "RobotId" = 74
                    "RobotUserName" = "saacon\atcy_a931884"
                }
            )
            "RequiresUserInteraction" = $true
        }
    }

    $jsonBody = $body | ConvertTo-Json -Depth 5
    
    
    $result = Invoke-RestMethod -Method POST -Uri "https://nluipprdwin001.saacon.net/odata/Jobs/UiPath.Server.Configuration.OData.StartJobs" -Headers $Header -Body $jsonBody 
	
}


if ($AllEmails.Count -gt 0) {
    
   APICall

}

$Outlook.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Outlook) | Out-Null
Remove-Variable Outlook