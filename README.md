# WebfilterTester
For IT personnel who want to verify if their web filter settings actually work :)

## Functionality

To check your web filter, I've curated a file [Domains.txt](./Domains.txt) containing the most important website categories and domains.

When you start it as explained in [Usage](./README.md##Usage), you'll receive a file listing all the websites that were accessed.

Depending on the user from which you started it, you shouldn't be able to access at least the domains listed in Critical. If you can access those, you really should fix your web filter ASAP.

If you want a slightly fancier output, just save it as a Markdown file instead of a .txt file. Due to the categories being formatted with "#", they will be formatted as titles and subtitles.

If you like this little script i would be happy if you could leave a Star

Thank you and have fun :)

## Usage:

```PowerShell
./WebFilterTester.ps1 /Input/Path/With/Domains.txt /Output/File.txt

```

### Or just copy this command and run it ;) :

```PowerShell
wget https://raw.githubusercontent.com/hack4mate/WebfilterTester/main/Domains.txt -OutFile Domains.txt;
IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/hack4mate/WebfilterTester/main/WebFilterTester.ps1');
WebFilterTest ./Domains.txt ./Outfile.txt
```
