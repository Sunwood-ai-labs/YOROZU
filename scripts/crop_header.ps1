param (
    [string]$InputPath,
    [string]$OutputPath
)

Add-Type -AssemblyName System.Drawing

if (-not (Test-Path $InputPath)) {
    Write-Error "Input file not found: $InputPath"
    exit 1
}

try {
    $img = [System.Drawing.Image]::FromFile($InputPath)
    $width = $img.Width
    $targetHeight = [int]($width * 9 / 16)

    # Check if cropping is needed
    if ($img.Height -le $targetHeight) {
        Write-Host "Image is already wide enough or too short. No cropping performed."
        $img.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)
    } else {
        $cropY = [int](($img.Height - $targetHeight) / 2)
        $rect = New-Object System.Drawing.Rectangle(0, $cropY, $width, $targetHeight)
        
        $destImg = new-object System.Drawing.Bitmap($width, $targetHeight)
        $destImg.SetResolution($img.HorizontalResolution, $img.VerticalResolution)
        
        $g = [System.Drawing.Graphics]::FromImage($destImg)
        
        $destRect = New-Object System.Drawing.Rectangle(0, 0, $width, $targetHeight)
        
        $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $g.DrawImage($img, $destRect, $rect, [System.Drawing.GraphicsUnit]::Pixel)
        
        $tempOutput = $OutputPath + ".tmp"
        $destImg.Save($tempOutput, [System.Drawing.Imaging.ImageFormat]::Png)
        
        $g.Dispose()
        $destImg.Dispose()
        
        $img.Dispose()
        
        Move-Item -Path $tempOutput -Destination $OutputPath -Force
        Write-Host "Cropped image to 16:9 ($width x $targetHeight)"
    }
    
    if ($img) { $img.Dispose() }
} catch {
    Write-Error "Error processing image: $_"
    exit 1
}
