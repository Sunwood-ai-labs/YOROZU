param (
    [string]$InputPath = "d:\Prj\YOROZU\assets\header.png",
    [string]$OutputPath = "d:\Prj\YOROZU\assets\header.png"
)

Add-Type -AssemblyName System.Drawing

if (-not (Test-Path $InputPath)) {
    Write-Error "Input file not found: $InputPath"
    exit 1
}

try {
    # Load image
    # We load to a temp bitmap to avoid locking the file if we want to overwrite it
    $tempImg = [System.Drawing.Image]::FromFile($InputPath)
    $bmp = New-Object System.Drawing.Bitmap($tempImg)
    $tempImg.Dispose()
    
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality

    # Define Text
    $titleText = "YOROZU"
    $subtitleText = "～Your Own Repository Organization Zero-gravity Utility～"

    # Define Title Font (Try different standard Windows fonts)
    $titleFontFamily = "Yu Mincho" # Japanese Serif style
    if (-not (New-Object System.Drawing.FontFamily($titleFontFamily)).Name) {
        $titleFontFamily = "Georgia" 
    }
    
    # Calculate Title Size
    $targetTitleHeight = $bmp.Height * 0.25
    $titleFontSize = 10
    do {
        $titleFontSize++
        $font = New-Object System.Drawing.Font($titleFontFamily, $titleFontSize, [System.Drawing.FontStyle]::Bold)
        $size = $g.MeasureString($titleText, $font)
    } while ($size.Height -lt $targetTitleHeight)
    
    $titleFont = New-Object System.Drawing.Font($titleFontFamily, $titleFontSize, [System.Drawing.FontStyle]::Bold)
    $titleSize = $g.MeasureString($titleText, $titleFont)

    # Define Subtitle Font
    $subtitleFontFamily = "Yu Gothic" # Japanese Sans-serif style
    if (-not (New-Object System.Drawing.FontFamily($subtitleFontFamily)).Name) {
        $subtitleFontFamily = "Segoe UI"
    }
    $subtitleFontSize = [int]($titleFontSize * 0.25)
    $subtitleFont = New-Object System.Drawing.Font($subtitleFontFamily, $subtitleFontSize)
    $subtitleSize = $g.MeasureString($subtitleText, $subtitleFont)

    # Positions (Center)
    $centerX = $bmp.Width / 2
    $centerY = $bmp.Height / 2
    
    $titleX = $centerX - ($titleSize.Width / 2)
    $titleY = $centerY - ($titleSize.Height / 2) - ($titleSize.Height * 0.1) # Move up slightly

    $subtitleX = $centerX - ($subtitleSize.Width / 2)
    $subtitleY = $titleY + $titleSize.Height - ($titleSize.Height * 0.2) # Below title

    # Colors (Gold-ish with shadow)
    $goldColor = [System.Drawing.ColorTranslator]::FromHtml("#E6D285")
    $shadowColor = [System.Drawing.Color]::FromArgb(180, 0, 0, 0)
    
    $mainBrush = New-Object System.Drawing.SolidBrush($goldColor)
    $shadowBrush = New-Object System.Drawing.SolidBrush($shadowColor)
    
    # Draw Shadow (Offset)
    $shadowOffset = $titleFontSize / 15
    $g.DrawString($titleText, $titleFont, $shadowBrush, $titleX + $shadowOffset, $titleY + $shadowOffset)
    $g.DrawString($subtitleText, $subtitleFont, $shadowBrush, $subtitleX + ($shadowOffset / 2), $subtitleY + ($shadowOffset / 2))

    # Draw Main Text
    $g.DrawString($titleText, $titleFont, $mainBrush, $titleX, $titleY)
    $g.DrawString($subtitleText, $subtitleFont, $mainBrush, $subtitleX, $subtitleY)

    # Save
    $bmp.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)
    
    # Cleanup
    $mainBrush.Dispose()
    $shadowBrush.Dispose()
    $titleFont.Dispose()
    $subtitleFont.Dispose()
    $g.Dispose()
    $bmp.Dispose()
    
    Write-Host "Success: Added text to $OutputPath"

}
catch {
    Write-Error "Error processing image: $_"
    exit 1
}
