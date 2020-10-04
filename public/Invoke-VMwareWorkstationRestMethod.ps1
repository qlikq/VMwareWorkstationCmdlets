
function Invoke-VMwareWorkstationRestMethod {
    <#
    .SYNOPSIS
    Invoke a REST method using the VMware Workstation API.

    .DESCRIPTION
    Handles authentication and calls to the REST API.

    .EXAMPLE
    C:\PS> Invoke-VMwareWorkstationRestMethod -RestMethod 'vms' -Method Get -Vmwserver 'localhost:8697' -user 'greg' -Password 'VMware1!'
    id            path
    --            ----
    JO6NNJRVKJO6C C:\Greg\Virtual Machines\VMware-vCenter-
    U73QR4PS2D6GU C:\Greg\Virtual Machines\openwrt15cc\ope
    NUS9H0K3V6AH9 C:\Greg\Windows Server 2016.vmx

    .NOTES
    Version:        0.1
    Author:         Grzegorz Kulikowski
    Creation Date:  04/10/2020

    #>

    [CmdletBinding()]
    param (
        #Everything that goes after the api url /vms /vms/123
        [String]$RestMethod,
        #In case a body will be a needed for a call like PUT/POST use a PS object, it will be transformed to json later on
        [Object]$Body,
        #by default we will be using GET if not told otherwise
        [Microsoft.PowerShell.Commands.WebRequestMethod]$Method = 'GET',

        [ValidateNotNullOrEmpty()][String]$Vmwserver = 'localhost:8697',
        [parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][String]$User,
        [parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][String]$Password

    )
        [securestring]$secPassword = ConvertTo-SecureString $Password -AsPlainText
        [pscredential]$creds = New-Object System.Management.Automation.PSCredential ($User, $secPassword)

    $params = @{
        Authentication = 'Basic'
        Method  = $Method
        Uri     = 'http://{0}/api/{1}' -f $Vmwserver, $RestMethod
        Headers = @{
            'Content-Type'  = 'application/json'
            #'Authorization' = $Script:AuthHeader
        }
    }

    if ($Body) {
        $params['Body'] = $Body | ConvertTo-Json
    }


    #Write-HostLog -message "[RestAPI]",$params.uri,$method -color 'darkgrey','green','darkgrey','lightblue'
    try {
        $FetchedData = Invoke-RestMethod -AllowUnencryptedAuthentication -Credential $creds @params
        $FetchedData
    }
    catch {

        #$err = $_.Exception.Message
        #write-HostLog -message "[Error]","Oops ? : $err : $bodyerror" -colors 'darkgrey','red','lightred'
        $PSCmdlet.ThrowTerminatingError($_)
    }
    
}