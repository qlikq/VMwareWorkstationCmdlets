$private = @(

    #'SomeSecretFunc'

    #'SomeSecretFunc2'

)


foreach ($file in $private) {

    . ("{0}\private\{1}.ps1" -f $psscriptroot, $file)

}


$public = @(

    Join-Path $psscriptroot -ChildPath 'Public' | Get-ChildItem -Filter *.ps1 | Select-Object -expandProperty BaseName

)


foreach ($file in $public) {

    . ("{0}\public\{1}.ps1" -f $psscriptroot, $file)

}


$functionsToExport = @(

    Join-Path $psscriptroot -ChildPath 'Public' | Get-ChildItem -Filter *.ps1 | Select-Object -expandProperty BaseName

)

Export-ModuleMember -Function $functionsToExport
