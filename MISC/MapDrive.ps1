$path = "\\server\share\%username%"
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
	  }
	  
 New-PSDrive –Name “J” –PSProvider FileSystem –Root “$path” –Persist