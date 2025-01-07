#!/bin/bash

#Define Regex values for the valid version number inputs
versionA='^v.[0-9]\.[0-9]{2}\.[0-9]\.[0-9]{4}-[a-z0-9]{9}$'
versionB='^[0-9]\.[0-9]{2}\.[0-9]\.[0-9]{4}-[a-z0-9]{9}$'


# Capture the version number of the update
echo 'We just need the version number of the new Plex Media Server release.'
sleep 1
echo 'Please include the full version ID including the trailing alphanumeric sequence.'
sleep 1
echo 'Example: "v.1.40.0.7998-c29d4c0c8" or "1.40.0.7998-c29d4c0c8"'
sleep 1
echo -en 'Enter the version number of the server update: '
read versionNumber

# Check if 'v.' prefix is present and remove it if so
if [[ $versionNumber =~ $versionA ]]; then
    cleanVersion=${versionNumber#v.}
elif [[ $versionNumber =~ $versionB ]]; then
    cleanVersion=$versionB
else
    echo 'The input "'$versionNumber'" does not match either input example.'
    sleep 1
    echo 'Exiting the script.'
    exit
fi

# Define a variable for the PMS download URL
downloadURL="https://downloads.plex.tv/plex-media-server-new/${cleanVersion}/debian/plexmediaserver_${cleanVersion}_amd64.deb"

# Read back the input to verify
echo 'You entered "'$versionNumber'" for the new Plex server version.'
sleep 1
echo 'Downloading "'$versionNumber'" of Plex Server for x86 Linux from $downloadURL'
echo '-----------------------------------------------------'
sleep 1

# Download the installer, run it and then delete it
wget $downloadURL
echo 'Running plexmediaserver_'$cleanVersion'_amd64.deb'
sudo dpkg -i plexmediaserver_${cleanVersion}_amd64.deb
sleep 1
echo '-----------------------------------------------------'
sleep 1
echo 'No longer need the installer, so removing plexmediaserver_'$cleanVersion'_amd64.deb'
sudo rm plexmediaserver_${cleanVersion}_amd64.deb
