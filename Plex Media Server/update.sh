#!/bin/bash

# Capture the version number of the update
echo "We just need the version number of the new Plex Media Server release."
echo "Include the 'v.' in the input if it is present in the version."
sleep 1
echo "Example: 'v.1.40.0.7998-c29d4c0c8' or '1.40.0.7998-c29d4c0c8'"
echo -en "Enter the version number of the server update:"
read versionNumber

# Check if 'v.' prefix is present and remove it
if [[ $versionNumber == v.* ]]; then
    cleanVersion=${versionNumber#v.}
else
    cleanVersion=$versionNumber
fi

# Read back the input to verify
echo "You entered $versionNumber for the new Plex server version."
echo "Downloading ${versionNumber} of Plex Server for x86 Linux from https://downloads.plex.tv/plex-media-server-new/${cleanVersion}/debian/plexmediaserver_${cleanVersion}_amd64.deb"
echo "-----------------------------------------------------"
sleep 1

# Download the installer, run it and then delete it
wget "https://downloads.plex.tv/plex-media-server-new/${cleanVersion}/debian/plexmediaserver_${cleanVersion}_amd64.deb"
echo "Running plexmediaserver_${cleanVersion}_amd64.deb"
sudo dpkg -i plexmediaserver_${cleanVersion}_amd64.deb
echo "-----------------------------------------------------"
sleep 1
echo "No longer need the installer, so removing plexmediaserver_${cleanVersion}_amd64.deb"
sudo rm plexmediaserver_${cleanVersion}_amd64.deb
