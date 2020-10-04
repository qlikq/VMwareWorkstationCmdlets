$moduleDirPath='C:\git\VMwareWorkstationCmdlets\'
$params = @{
    Path              = 'C:\git\VMwareWorkstationCmdlets\VMwareWorkstationCmdlets.psd1'
    RootModule        = 'VMwareWorkstationCmdlets.psm1'
    ModuleVersion     = '0.0.1'
    FunctionsToExport = Join-Path $moduleDirPath -ChildPath 'Public' | Get-ChildItem -Filter *.ps1 | Select-Object -expandProperty BaseName
    Author            = 'Grzegorz Kulikowski'
    CompanyName       = 'xDLabs'
    Description       = 'VMwareWorkstationCmdlets Module provides various cmdlets to interact with VMware Workstation Rest API'
    Copyright         = '(c) 2020 Grzegorz Kulikowski.xDlabs. All rights reserved.'
    PowerShellVersion = '3.0'

}
New-ModuleManifest @params