
function Authenticate {
    param (
        [string]$Tenant,
        [string]$UsernameOrEmailAddress,
        [string]$Password,
        [string]$AuthUrl
    )

    $body = @{
        tenancyName = $Tenant
        usernameOrEmailAddress = $UsernameOrEmailAddress
        password = $Password
    } | ConvertTo-Json 

    $authResponse = Invoke-RestMethod -Uri $AuthUrl -Method Post -Headers @{ "Content-Type" = "application/json" } -Body $body
    return $authResponse.result
}


function GetRobots {
    param (
        [string]$AccessToken,
        [string]$Tenant,
        [string]$OrganizationUnitId,
        [string]$RobotsUri
    )

    $headers = @{
        "authorization" = "Bearer $AccessToken"
        "Content-Type" = "application/json"
        "X-UIPATH-TenantName" = $Tenant
        "X-UIPATH-OrganizationUnitId" = $OrganizationUnitId
    }

    $robotsResponse = Invoke-RestMethod -Method GET -Uri $RobotsUri -Headers $headers
    return $robotsResponse.value
}


function GetMachines {
    param (
        [string]$AccessToken,
        [string]$Tenant,
        [string]$OrganizationUnitId,
        [string]$MachinesUri
    )

    $headers = @{
        "authorization" = "Bearer $AccessToken"
        "Content-Type" = "application/json"
        "X-UIPATH-TenantName" = $Tenant
        "X-UIPATH-OrganizationUnitId" = $OrganizationUnitId
    }

    $machinesResponse = Invoke-RestMethod -Method GET -Uri $MachinesUri -Headers $headers
    return $machinesResponse.value
}


$tenant = "PRD_IDM_BRIDGE"
$usernameOrEmailAddress = "a892235"
$password = "GAsikarako007664!"
$authUrl = "https://nluipprdwin001.saacon.net/api/Account/Authenticate"
$robotsUri = "https://nluipprdwin001.saacon.net/odata/Robots/UiPath.Server.Configuration.OData.GetConfiguredRobots"
$machinesUri = "https://nluipprdwin001.saacon.net/odata/Machines"
$organizationUnitId = "10"

# Authenticate and get the token
$accessToken = Authenticate -Tenant $tenant -UsernameOrEmailAddress $usernameOrEmailAddress -Password $password -AuthUrl $authUrl

# Get robots
$robots = GetRobots -AccessToken $accessToken -Tenant $tenant -OrganizationUnitId $organizationUnitId -RobotsUri $robotsUri
Write-Output "Robots:"
Write-Output $robots 

<# Get machines
$machines = GetMachines -AccessToken $accessToken -Tenant $tenant -OrganizationUnitId $organizationUnitId -MachinesUri $machinesUri
Write-Output "Machines:"
Write-Output $machines #>