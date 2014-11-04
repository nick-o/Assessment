#your solution goes in here
# ------------------------------------------------------------------------
# NAME:		solution.ps1
# AUTHOR:	Gabriel Brussa
# DATE:		03/Nov/2014
# ------------------------------------------------------------------------

#Define parameters
	#URL to gather the file from
set-variable -name getfrom -value "https://gist.githubusercontent.com/nick-o/fb83168225b53421c353/raw/3740ea8de88fb6ab37ba4d979ef3b3488c373456/PoSh.txt" -visibility private
#set-variable -name getfrom -value "http://followup.netposible.com/powershell.txt" -visibility private

	#Filename to use
set-variable -name savefile -value "PoShText.txt" -visibility private

	#Line to fetch a word from
set-variable -name parseline -value 9 -visibility private	

	#Word from line to be fetched a word from
set-variable -name parseword -value 9 -visibility private	


#Define all functions

function getfile($uri) {
	try {
		#(new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1")
		$webClient = New-Object System.Net.Webclient
		$webClient.DownloadString($uri)
	} catch {
		Write-Output "Error occurred while downloading file. " $_.Exception.Message
		exit
	}
}

function savefile($file, $data){
	try {
		out-file -FilePath $file -inputobject $data
	} catch {
		Write-Output "Error occurred while saving file. " $_.Exception.Message
		exit
	}
}

function loadfile($file){
	try {
		Get-Content -path $file
	} catch {
		Write-Output "Error occurred while loading file. " $_.Exception.Message
		exit
	}
}

function gatherword($data, $line, $word){
	#First fix the line and word number, as we process it as array
	$line --
	$word --
	
	#Now that we have the line number, split the line into an array
	$linearray = $data[$line] -split " "
	
	#Return the word
	$ret = $linearray[$word]
	$ret
}

function reverseword($word){
	#Split the word we need as a character array
	$word = $word.tochararray()
	
	#Reverse it and join it back to a string
	[array]::Reverse($word)
	$word -join ''
}

function stripnonletters($data){
	#get the data, execute a regex to replace chars with spaces 
	$data = $data -replace '[^a-zA-Z0-9]',' '
	$data
}

function getstatwords($data){
	#let's break the array into a word-by-word array
	$data = $data -split " "
	
	#get the word statistics by grouping them and reading the count, excluding spaces. Sort in desc and show only the top 10
	$data | Group-Object $_ | Select-Object Name, Count | Where-Object {$_.Name -ne ''}  | Sort-Object -Property Count -Descending | Select-Object -First 10
}

function getstatchars($data){
	#let's break the array into a word-by-word array
	$data = $data.tochararray()
	
	#get the word statistics by grouping them and reading the count, excluding spaces. Sort in desc and show only the top 10
	$data | Group-Object $_ | Select-Object Name, Count | Where-Object {$_.Name -ne ' '}  | Sort-Object -Property Count -Descending | Select-Object -First 10
}

#Execute!
	#Let's grab the file - Requirement 3.i
	$data = getfile $getfrom

	#and save it
	savefile $savefile $data
	
	#let's load it as an array now - Requirement 3.ii (the data it's already in $data var, however as string and we rather use it as array)
	$filecontent = loadfile($savefile)

	#get lines, words and characters - Requirement 3.iii
	#first, let's get the lines from the array length (measure-object will NOT count blank lines!)
	$lines = $filecontent.length
	$wordsandchars = ($filecontent | Measure-Object -Character -Word)
	#output to console
	Write-Output "`n`nDocument information`n"     
	Write-Output "Lines:      $($lines)"
	Write-Output "Words:      $($wordsandchars.words)"
	Write-Output "Characters: $($wordsandchars.characters)"
	
	#get a specific word and show it backwards - Requirement 3.iv
	try {
		Write-Output "The word '$($parseword)' in line '$($parseline)', reversed is: '$(reverseword(gatherword $filecontent $parseline $parseword))'"
	} catch {
		Write-Output "The word '$($parseword)' in line '$($parseline)' could not be reversed due to error"
	}
	
	
	#to process the occurrences, let's first strip all non letters/numbers - Requirement 3.v
	$data2 = stripnonletters $data
	#call the function to get the stats on words
	Write-Output "`nMost common words in the document:"
	getstatwords $data2 | format-table -auto
	#and on chars
	Write-Output "`nMost common characters in the document:"
	getstatchars $data2 | format-table -auto
	