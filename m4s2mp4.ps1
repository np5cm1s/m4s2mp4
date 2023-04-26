##[Ps1 To Exe]
##
##NcDBCIWOCzWE8paP3zJx6FvrRSYudsD7
##Kd3HDZOFADWE8uO1
##Nc3NCtDXTlGDjuGDs7G5DM4Liu7+gU1cUTNeDAVkFGIxZhnfSIwdSlt51mGtTQW0Wv1y
##Kd3HFJGZHWLWoLaVvnQnhQ==
##LM/RF4eFHHGZ7/K1
##K8rLFtDXTiSJ0g==
##OsHQCZGeTiiZ4tI=
##OcrLFtDXTiW5
##LM/BD5WYTiiZ4tI=
##McvWDJ+OTiiZ4tI=
##OMvOC56PFnzN8u+VslQ=
##M9jHFoeYB2Hc8u+Vs1Q=
##PdrWFpmIG2HcofKIo2QX
##OMfRFJyLFzWE8uO1
##KsfMAp/KUzWJ0g==
##OsfOAYaPHGbQvbyVvnQX
##LNzNAIWJGmPcoKHc7Do3uAuO
##LNzNAIWJGnvYv7eVvnQX
##M9zLA5mED3nfu77Q7TV64AuzAgg=
##NcDWAYKED3nfu77Q7TV64AuzAgg=
##OMvRB4KDHmHQvbyVvnQX
##P8HPFJGEFzWE8tI=
##KNzDAJWHD2fS8u+Vgw==
##P8HSHYKDCX3N8u+Vgw==
##LNzLEpGeC3fMu77Ro2k3hQ==
##L97HB5mLAnfMu77Ro2k3hQ==
##P8HPCZWEGmaZ7/K1
##L8/UAdDXTlGDjuGDs7G5DM4Liu7+gU1cUTNeDAVkFGIxZhnbQJYdS117n2nsBwu5VuUcWfoUsJEXXBEvE6tesuKJSL74FZ4HxvAtZvXa6LcxEDo=
##Kc/BRM3KXxU=
##
##
##fd6a9f26a06ea3bc99616d4851b372ba
Set-ExecutionPolicy -Force remotesigned

$path = (get-location).path
# $path = "D:\360安全浏览器下载\bilibili pc download file\950093910"
# set-location $path

$str = [System.IO.File]::ReadAllText($path + "\.videoInfo")
$start = $str.indexof("tabName") + 10
$end = $str.indexof("uid") - 4
$str2 = $str[$start..$end]

$tmpVideo = $path + "\video.m4s"
$tmpAudio = $path + "\audio.m4s"

$fname = dir -Filter *30080.m4s;
$stream = New-Object System.IO.FileStream($fname.FullName,[IO.FileMode]::Open ,[IO.FileAccess]::Read ,[IO.FileShare]::Read)

$outStream = New-Object System.IO.FileStream($tmpVideo,[IO.FileMode]::Create ,[IO.FileAccess]::Write ,[IO.FileShare]::Read)
$buffer = New-Object byte[](1024*1024*10)

$stream.Position = 9
while(1){
    $r = $stream.read($buffer,0,$buffer.length)
    if ($r -eq 0){
        break
    }
    $outStream.write($buffer,0,$r)
    $outStream.Flush()
}
$outStream.Close()
$stream.Close()


$fname2 = dir -Filter *30280.m4s;
$stream2 = New-Object System.IO.FileStream($fname2.FullName,[IO.FileMode]::Open ,[IO.FileAccess]::Read ,[IO.FileShare]::Read)

$outStream2 = New-Object System.IO.FileStream($tmpAudio,[IO.FileMode]::Create ,[IO.FileAccess]::Write ,[IO.FileShare]::Read)
$buffer = New-Object byte[](1024*1024*10)

$stream2.Position = 9
while(1){
    $r = $stream2.read($buffer,0,$buffer.length)
    if ($r -eq 0){
        break
    }
    $outStream2.write($buffer,0,$r)
    $outStream2.Flush()
}
$outStream2.Close()
$stream2.Close()

$out = ("$str2" + ".mp4").replace(" ","")
echo $out

if(!$fname) {
$out = "Output.mp4"
}

#$ffpath = (dir env:p2eincfilepath).value + "\ffmpeg.exe"
#$arg = "-i video.m4s -i audio.m4s -codec copy output.mp4"

#Start-Process "$ffpath" "$arg"

.\ffmpeg.exe -i video.m4s -i audio.m4s -codec copy $out

if ($fname) {
del $tmpVideo
del $tmpAudio
}

echo "合并完成"
cmd /c pause | out-null