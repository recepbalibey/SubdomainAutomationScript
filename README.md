# SubdomainAutomationScript
This script is automating the subdomain enumeration.

The tools are used in this script:
- subfinder : https://github.com/projectdiscovery/subfinder
- assetfinder : https://github.com/tomnomnom/assetfinder
- httprobe : https://github.com/tomnomnom/httprobe
- gowitness : https://github.com/sensepost/gowitness
- nmap : https://nmap.org/

Most of them come with Kali Linux but you may need to install them manually which is very simple.
The script is modified and inspired by TCM Security training and will be updated according to my needs and with new ideas. 
This is just to keep it for me and for you to improve.

Usage:

```
┌──(kali㉿kali)-[~/Documents]
└─$ sudo apt update -y
┌──(kali㉿kali)-[~/Documents]
└─$ mousepad SubdomainAutomation.sh
┌──(kali㉿kali)-[~/Documents]
└─$ sudo chmod +x SubdomainAutomation.sh
┌──(kali㉿kali)-[~/Documents]
└─$ ./SubdomainAutomation.sh -h
┌──(kali㉿kali)-[~/Documents]
└─$ ./SubdomainAutomation.sh example.com

```
