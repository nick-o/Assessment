Assessment
==========

For this assessment, please follow the below instructions:

1. Fork this repo to your own github account
2. Clone this down to your workstatation
3. Add code to solution.ps1 to achieve the following:
  1. Download the content of [PoSh.txt](https://gist.githubusercontent.com/nick-o/fb83168225b53421c353/raw/3740ea8de88fb6ab37ba4d979ef3b3488c373456/PoSh.txt "PoSh.txt on gist.github.com") to the PoShText.txt file in this repo
  2. Read all lines from PoShText.txt into a local variable
  3. Output the following information:
    1. Total number of lines in the file
    2. Total number of words in the file (to make it simple, every text surrounded by spaces is considered a word)
    3. Total number of characters in the file
  3. Output the 9th word of the 9th line backwards (i.e. "Hello" turns into "olleH")
  4. [BONUS] Gather the following statistics:
    1. The amount of occurrences of each word in the example text (ideally completely disregard any non-word characters), for instance scripting appears 5 times. Only output the 10 words the occur the most along with the amount.
    2. The amount of occurrences of each character in the text (e.g. y appears 39 times). Only ouput the 10 characters that occurr the most.
4. Submit the changes to your fork
5. Issue a pull request to this repo to merge your code in


The above instructions assume that you do all this in Powershell, however, if this is easier to achieve in other languages (ideally a Windows-realted framework though like .NET) feel free to use that.
