param(
    [string]$InstallRoot = "$env:LOCALAPPDATA\GenuineTools"
)

$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

function Assert-Command([string]$Name) {
    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "Required command '$Name' is not available."
    }
}

function Get-VerifiedArchive {
    param(
        [Parameter(Mandatory)][string]$Url,
        [Parameter(Mandatory)][string]$Sha256,
        [Parameter(Mandatory)][string]$Destination
    )

    Invoke-WebRequest -Uri $Url -OutFile $Destination -UseBasicParsing
    $actual = (Get-FileHash -Path $Destination -Algorithm SHA256).Hash.ToLowerInvariant()
    if ($actual -ne $Sha256.ToLowerInvariant()) {
        Remove-Item $Destination -Force -ErrorAction SilentlyContinue
        throw "Checksum mismatch for $Url. Expected $Sha256, got $actual."
    }
}

Assert-Command npm

New-Item -ItemType Directory -Force -Path $InstallRoot | Out-Null
$bin = Join-Path $InstallRoot "bin"
New-Item -ItemType Directory -Force -Path $bin | Out-Null
$temp = Join-Path $env:TEMP ("genuine-tools-" + [guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Force -Path $temp | Out-Null

try {
    Write-Host "Installing Playwright CLI 0.1.22..."
    npm install -g @playwright/cli@0.1.22
    playwright-cli --help | Out-Null
    playwright-cli install --skills=agents

    $downloads = @(
        @{
            Name = "Trivy"
            Url = "https://github.com/aquasecurity/trivy/releases/download/v0.74.0/trivy_0.74.0_windows-64bit.zip"
            Sha = "94c40e0696e4b907a74b7b2e1438d5d72ebaca83115817407f568a002d520842"
            Archive = "trivy.zip"
            Exe = "trivy.exe"
        },
        @{
            Name = "actionlint"
            Url = "https://github.com/rhysd/actionlint/releases/download/v1.7.12/actionlint_1.7.12_windows_amd64.zip"
            Sha = "6e7241b51e6817ea6a047693d8e6fed13b31819c9a0dd6c5a726e1592d22f6e9"
            Archive = "actionlint.zip"
            Exe = "actionlint.exe"
        },
        @{
            Name = "zizmor"
            Url = "https://github.com/zizmorcore/zizmor/releases/download/v1.30.1/zizmor-x86_64-pc-windows-msvc.zip"
            Sha = "b183b1e996eddfab9659f1e9b46e059f1ef1cf984a1f14e5da09f7876a4b3a1c"
            Archive = "zizmor.zip"
            Exe = "zizmor.exe"
        }
    )

    foreach ($item in $downloads) {
        Write-Host "Installing $($item.Name)..."
        $archive = Join-Path $temp $item.Archive
        $extract = Join-Path $temp ([IO.Path]::GetFileNameWithoutExtension($item.Archive))
        Get-VerifiedArchive -Url $item.Url -Sha256 $item.Sha -Destination $archive
        Expand-Archive -Path $archive -DestinationPath $extract -Force
        $exe = Get-ChildItem -Path $extract -Filter $item.Exe -Recurse | Select-Object -First 1
        if (-not $exe) { throw "Could not find $($item.Exe) after extraction." }
        Copy-Item $exe.FullName (Join-Path $bin $item.Exe) -Force
    }

    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    $parts = @($userPath -split ';' | Where-Object { $_ })
    if ($parts -notcontains $bin) {
        [Environment]::SetEnvironmentVariable("Path", (($parts + $bin) -join ';'), "User")
    }
    if (($env:Path -split ';') -notcontains $bin) {
        $env:Path = "$bin;$env:Path"
    }

    & (Join-Path $bin "trivy.exe") --version
    & (Join-Path $bin "actionlint.exe") --version
    & (Join-Path $bin "zizmor.exe") --version

    Write-Host "Genuine toolchain installed and checksum-verified."
}
finally {
    Remove-Item $temp -Recurse -Force -ErrorAction SilentlyContinue
}
