param (
    [Parameter(Mandatory = $false)] [String]  $TenantId = "00193bc8-dddd-41dd-8c93-264763bc0348",
    [Parameter(Mandatory = $false)] [String]  $Subscriptionid = "d9bc6363-1579-4256-8ac0-7686697ffdb4",
    [Parameter(Mandatory = $false)] [String]  $ResourceGroupName = 'RGSQLAllwaysOn',
    [Parameter(Mandatory = $false)] [string]  $TemplateFile = "./azuredeployNewVM-WinAvSet.json",
    [Parameter(Mandatory = $false)] [String]  $TemplateParameterFile = "./azuredeploy.parameters.json",
    [Parameter(Mandatory = $false)] [switch]  $WhatIf 
)

$DebugPreference = 'Continue'
function Login($SubscriptionId, $TenantId) {
    $context = Get-AzContext

    if (!$context -or ($context.Subscription.Id -ne $SubscriptionId)) {
        Connect-AzAccount -TenantId $TenantId
        Select-AzSubscription   -subscriptionid    $SubscriptionId
        Write-Output " Authenticated in tenant: $($context.Tenant.Id)"
    } 
    else {
        Write-Output "SubscriptionId $($context.Subscription.Id) already connected"
    }
}

Login -SubscriptionId $SubscriptionId -TenantId $TenantId

if ($WhatIf.IsPresent) {
    Write-Output "Whatif $($true)"
    New-AzResourceGroupDeployment -Name "OnDemandDeployment" -ResourceGroupName $ResourceGroupName -Location "EastUs" -TemplateFile $TemplateFile -TemplateParameterFile $TemplateParameterFile  -DeploymentDebugLogLevel All -WhatIf

}
else {
    Write-Output "whatIf $($false)"
    New-AzResourceGroupDeployment -Name "OnDemandDeployment" -ResourceGroupName $ResourceGroupName  -Location "EastUs" -TemplateFile $TemplateFile -TemplateParameterFile $TemplateParameterFile  -DeploymentDebugLogLevel All
}