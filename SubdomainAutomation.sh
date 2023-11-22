#!/bin/bash

# Creating color to better visualize.
RED="\033[1;31m"
RESET="\033[0m"

# Help message
help_message() {
    echo "Usage: $0 <target_domain>"
    echo "Example: $0 example.com"
}

# Check if the user provided a target domain
if [ -z "$1" ]; then
    help_message
    exit 1
fi


# Update system
# echo -e  "${RED} [*] Updating the system... ${RESET}"
# sudo apt update -y

echo -e  "${RED} [*] Installing necessary tools... ${RESET}"

# echo -e  "${RED} [*] Installing subfinder... ${RESET}"
# sudo apt install subfinder -y

# echo -e  "${RED} [*] Installing assetfinder... ${RESET}"
# go get -u github.com/tomnomnom/assetfinder

# echo -e  "${RED} [*] Installing amass... ${RESET}"
# GO111MODULE=on go get -u -v github.com/OWASP/Amass/v3/...

# echo -e  "${RED} [*] Installing gowitness... ${RESET}"
# go get -u github.com/sensepost/gowitness

# echo -e  "${RED} [*] Installing nmap... ${RESET}"
# sudo apt install nmap -y



domain=$1

# Creating folder
subdomain_path=$domain/subdomains
screenshot_path=$domain/screenshots
scan_path=$domain/scans

# Creating the path-directories for the output if it does not exist.
if [ ! -d "$domain" ]; then
	mkdir $domain
fi	

if [ ! -d "$subdomain_path" ]; then
	mkdir $subdomain_path
fi	

if [ ! -d "$screenshot_path" ]; then
	mkdir $screenshot_path
fi	

if [ ! -d "$scan_path" ]; then
	mkdir $scan_path
fi	

# Run subdomain enumeration
echo -e "${RED} [+] Launching subfinder to enumerate subdomain .... ${RESET}"
subfinder -d $domain -o $subdomain_path/found.txt

# Run subdomain enumeration
echo -e "${RED} [+] Launching assetfinder to enumerate subdomains .... ${RESET}"
assetfinder $domain | grep $domain >> $subdomain_path/found.txt

# Run subdomain enumeration
# echo -e "${RED} [+] Launching amass .... ${RESET}"
# amass enum -d $domain >> $subdomain_path/found.txt

# Run httprobe to check which subdomains are alive
# sed will from HTTPS from the beginning
echo -e "${RED} [+] Launching httprobe to check which subdomains are alive .... ${RESET}"
cat $subdomain_path/found.txt | grep $domain | sort -u | httprobe -prefer-https | grep https | sed 's/https\?:\/\///' | tee -a $subdomain_path/alive.txt

# Run gowitness to take screenshots
echo -e "${RED} [+] Taking screenshots of alive subdomains with gowitness .... ${RESET}"
gowitness file -f $subdomain_path/alive.txt -P $screenshot_path/ --no-http

# Run nmap to check open ports on alive subdomains
echo -e "${RED} [+] Launching nmap on alive subdomains.... ${RESET}"
nmap -iL $subdomain_path/alive.txt -T4 -p- -oN $scan_path/nmap.txt


echo -e "${RED} [+] Script completed successfully! Output saved. ${RESET}"
