#!/bin/bash
stty intr ""
stty quit ""
stty susp undef

clear
rm -rf ngrok ngrok.zip ng.sh > /dev/null 2>&1
echo "======================="
echo "Downloading ngrok..."
echo "======================="
wget -O ngrok.tgz https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz > /dev/null 2>&1
tar -xvzf ngrok.tgz > /dev/null 2>&1


function goto
{
    label=$1
    cd 
    cmd=$(sed -n "/^:[[:blank:]][[:blank:]]*${label}/{:a;n;p;ba};" $0 | 
          grep -v ':$')
    eval "$cmd"
    exit
}

: ngrok
clear


# File where auth token will be stored
TOKEN_FILE="AUTH-TOKEN"

# Check if the AUTH-TOKEN file exists and is not empty
if [ -s "$TOKEN_FILE" ]; then
    # Read the token from the file
    CRP=$(cat "$TOKEN_FILE")
    echo "Ngrok Authtoken read from file."
else
    # If the file doesn't exist or is empty, ask for the token
    read -p "Paste Ngrok Authtoken: " CRP
    # Save the token to the AUTH-TOKEN file
    echo "$CRP" > "$TOKEN_FILE"
    echo "Ngrok Authtoken saved to file."
fi

# Add the auth token to ngrok config
./ngrok config add-authtoken $CRP

clear

# File where the region will be stored
REGION_FILE="REGION"

# Check if the REGION file exists and is not empty
if [ -s "$REGION_FILE" ]; then
    # Read the region from the file
    CRP=$(cat "$REGION_FILE")
    echo "Ngrok region read from file: $CRP."
else
    # If the file doesn't exist or is empty, ask for the region
    read -p "Choose Ngrok region ( us, eu, ap, au, sa, jp, in ): " CRP
    # Save the region to the REGION file
    echo "$CRP" > "$REGION_FILE"
    echo "Ngrok region saved to file."
fi

# Start ngrok with the saved region
./ngrok tcp --region $CRP 4000 &>/dev/null &
clear
sleep 2
if curl --silent --show-error http://127.0.0.1:4040/api/tunnels  > /dev/null 2>&1; then echo OK; else echo "Ngrok Error! Please try again!" && sleep 1 && goto ngrok; fi
sleep 28
docker logs nomashine
clear
echo Wait for 10 seconds
sleep 10
clear
clear

curl ifconfig.me
echo
echo
sleep 1

public_url=$(curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p' | tr -d :)
echo "$public_url"


echo
echo
seq 1 1200 | while read i; do 
    echo -en "\r Running .     $i s /1200 s"; sleep 0.1
    echo -en "\r Running ..    $i s /1200 s"; sleep 0.1
    echo -en "\r Running ...   $i s /1200 s"; sleep 0.1
    echo -en "\r Running ....  $i s /1200 s"; sleep 0.1
    echo -en "\r Running ..... $i s /1200 s"; sleep 0.1
    echo -en "\r Running     . $i s /1200 s"; sleep 0.1
    echo -en "\r Running  .... $i s /1200 s"; sleep 0.1
    echo -en "\r Running   ... $i s /1200 s"; sleep 0.1
    echo -en "\r Running    .. $i s /1200 s"; sleep 0.1
    echo -en "\r Running     . $i s /1200 s"; sleep 0.1
done



pkill ngrok
clear

seq 1 16800 | while read i; do 
    echo -en "\r Running .     $i s /16800 s"; sleep 0.1
    echo -en "\r Running ..    $i s /16800 s"; sleep 0.1
    echo -en "\r Running ...   $i s /16800 s"; sleep 0.1
    echo -en "\r Running ....  $i s /16800 s"; sleep 0.1
    echo -en "\r Running ..... $i s /16800 s"; sleep 0.1
    echo -en "\r Running     . $i s /16800 s"; sleep 0.1
    echo -en "\r Running  .... $i s /16800 s"; sleep 0.1
    echo -en "\r Running   ... $i s /16800 s"; sleep 0.1
    echo -en "\r Running    .. $i s /16800 s"; sleep 0.1
    echo -en "\r Running     . $i s /16800 s"; sleep 0.1
done
clear
gh codespace stop
