
function Get-VMwareWorkstationVMs {
    <#
    .SYNOPSIS
        Get VMware Workstation virtual machines

    .DESCRIPTION
       It retrieves list of virtual machines registered for particular vmware workstation instance.
    #>

    [CmdletBinding()]
    param (
        [ValidateNotNullOrEmpty()][String]$Vmwserver = 'localhost:8697',
        [parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][String]$User,
        [parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][String]$Password

    )

    try {
        $FetchedData = Invoke-VMwareWorkstationRestMethod -RestMethod 'vms' -Method Get -Vmwserver 'localhost:8697' -user $User -Password $Password 
        $FetchedData
    }
    catch {
        #$err = $_.Exception.Message
        #write-HostLog -message "[Error]","Oops ? : $err : $bodyerror" -colors 'darkgrey','red','lightred'
        $PSCmdlet.ThrowTerminatingError($_)
    }
    
}