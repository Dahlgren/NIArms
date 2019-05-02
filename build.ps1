$pboproject = "pboproject"
$workspace = "P:"

function Build-Pbo ($folder) {
	$params = @(
		"$workspace\$folder"
		"-P"
		"-Workspace=$workspace\"
		"+Mod=$workspace\@niarsenal"
	)

	Write-Output "Building $folder"

	$proc = Start-Process $pboproject -ArgumentList $params -PassThru
	Wait-Process -InputObject $proc

	if ($proc.ExitCode -ne 0) {
		Throw "Error building $folder $($proc.ExitCode)"
	}
}

function Build-Pbos ($folders) {
	foreach($folder in $folders) {
		Build-Pbo $folder.Name
	}
}

Build-Pbos($(Get-ChildItem "hlc_*"))
Build-Pbos($(Get-ChildItem "nia_*"))
