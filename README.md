# WebfilterTester
For IT personnel who want to verify if their web filter settings actually work :)

## Functionality

To check your web filter, I've curated a file [Domains.csv](./Domains.csv) containing the most important website categories and domains.

When you start it as explained in [Usage](./README.md##Usage), you'll receive a file listing all the websites that were accessed.

Depending on the user from which you started it, you shouldn't be able to access at least the domains listed in Critical. If you can access those, you really should fix your web filter ASAP.

If you like this little script i would be happy if you could leave a Star

Thank you and have fun :)

## Usage:

```PowerShell
./WebFilterTester.ps1 /Input/Path/With/Domains.csv /Output/File.csv

```

### Or just copy this command and run it ;) :

```PowerShell
wget https://raw.githubusercontent.com/hack4mate/WebfilterTester/main/Domains.csv -OutFile Domains.csv;
IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/hack4mate/WebfilterTester/main/WebFilterTester.ps1');
WebFilterTest ./Domains.csv ./Outfile.csv
```
