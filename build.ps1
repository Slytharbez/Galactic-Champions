# Compila nuestro Ruffle y arma el juego para PC (Windows, PowerShell 5).
#
#   .\build.ps1                   compila Ruffle (si hace falta) y arma ..\Ben10GalacticChampions
#   .\build.ps1 -SinCompilar      solo rearma el juego con el Ruffle ya compilado
#   .\build.ps1 -Destino C:\Juegos
#
# Requisitos para compilar: git, Rust (rustup), Visual Studio Build Tools 2022 (C++), Java en el PATH.
# Nada de esto queda dentro del repo:
#   ..\ruffle-src\                 codigo de Ruffle + compilacion (el .exe queda en target\release)
#   ..\Ben10GalacticChampions\     el juego: Ben10GalacticChampions.exe, game\, saves\, licencias\
param(
  [string]$Destino = (Split-Path $PSScriptRoot -Parent),
  [string]$RuffleSrc = (Join-Path (Split-Path $PSScriptRoot -Parent) "ruffle-src"),
  [string]$RuffleTag = "v0.8.0",
  [switch]$SinCompilar
)
$ErrorActionPreference = "Stop"
$Repo = $PSScriptRoot
$exe = Join-Path $RuffleSrc "target\release\ruffle_desktop.exe"

# ---------- 1) Ruffle ----------
if (-not $SinCompilar) {
  $patch = Join-Path $Repo "ruffle\ruffle.patch"

  # Codigo de Ruffle en la version fija
  if (-not (Test-Path (Join-Path $RuffleSrc ".git"))) {
    git clone --depth 1 --branch $RuffleTag https://github.com/ruffle-rs/ruffle.git $RuffleSrc
    if ($LASTEXITCODE) { throw "git clone fallo" }
  }

  # Parche (si ya esta aplicado, no hace nada). cmd /c: en PowerShell 5 el stderr de git cortaria el script.
  cmd /c "git -C `"$RuffleSrc`" apply --check `"$patch`" 2>nul"
  if ($LASTEXITCODE -eq 0) {
    git -C $RuffleSrc apply $patch
    if ($LASTEXITCODE) { throw "No se pudo aplicar ruffle.patch" }
  } else {
    cmd /c "git -C `"$RuffleSrc`" apply --reverse --check `"$patch`" 2>nul"
    if ($LASTEXITCODE) { throw "ruffle.patch no encaja con $RuffleSrc (otra version de Ruffle?)" }
    Write-Host "Parche ya aplicado."
  }

  # Icono: .ico para el .exe y 32x32 RGBA crudo para la ventana
  # (el 32x32 sale del .png: System.Drawing lee mal las entradas PNG comprimidas del .ico)
  $assets = Join-Path $RuffleSrc "desktop\assets"
  Copy-Item (Join-Path $Repo "icons\omnitrix.ico") (Join-Path $assets "favicon.ico") -Force
  Add-Type -AssemblyName System.Drawing
  $png = [System.Drawing.Image]::FromFile((Join-Path $Repo "icons\omnitrix.png"))
  $bmp = New-Object System.Drawing.Bitmap 32, 32, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
  $g.DrawImage($png, 0, 0, 32, 32); $g.Dispose(); $png.Dispose()
  $rgba = New-Object byte[] (32 * 32 * 4)
  for ($y = 0; $y -lt 32; $y++) { for ($x = 0; $x -lt 32; $x++) {
    $c = $bmp.GetPixel($x, $y); $i = ($y * 32 + $x) * 4
    $rgba[$i] = $c.R; $rgba[$i + 1] = $c.G; $rgba[$i + 2] = $c.B; $rgba[$i + 3] = $c.A
  } }
  $bmp.Dispose()
  [IO.File]::WriteAllBytes((Join-Path $assets "favicon-32.rgba"), $rgba)

  # Compilar (release)
  Push-Location $RuffleSrc
  try {
    cmd /c "cargo build --release --package ruffle_desktop 2>&1"
    if ($LASTEXITCODE) { throw "cargo build fallo" }
  } finally { Pop-Location }
}
if (-not (Test-Path $exe)) { throw "Falta $exe; corre .\build.ps1 sin -SinCompilar" }

# ---------- 2) Juego ----------
$pkg = Join-Path $Destino "Ben10GalacticChampions"
if ($pkg.StartsWith($Repo, [StringComparison]::OrdinalIgnoreCase)) { throw "El juego no puede quedar dentro del repo." }

# game\: solo lo que esta en el ultimo commit (nada suelto ni sin guardar). saves\ no se toca.
if (Test-Path "$pkg\game") { Remove-Item -Recurse -Force "$pkg\game" }
New-Item -ItemType Directory -Force "$pkg\game", "$pkg\saves", "$pkg\licencias" | Out-Null
$tar = Join-Path $env:TEMP "ben10-game.tar"
git -C $Repo archive -o $tar HEAD:game
if ($LASTEXITCODE) { throw "git archive fallo" }
tar -xf $tar -C "$pkg\game"
if ($LASTEXITCODE) { throw "tar fallo" }
Remove-Item $tar

Copy-Item $exe (Join-Path $pkg "Ben10GalacticChampions.exe") -Force
Copy-Item (Join-Path $RuffleSrc "LICENSE.md") "$pkg\licencias\Ruffle.md" -Force
Write-Host "Listo: $pkg\Ben10GalacticChampions.exe"
