#!/bin/bash

# Capture the version number of the update
echo "We just need the version number of the new Plex Media Server release."
echo "Do not include the 'v.' in the input, as this isn't used in the file name."
sleep 1
echo "Example: '1.40.0.7998-c29d4c0c8' not 'v.1.40.0.7998-c29d4c0c8'"
echo -en "Enter the version number of the server update:"
read versionNumber
# Read back the input to verify
echo "You entered $versionNumber for the new Plex server version."
echo "Downloading v.$versionNumber of Plex Server for x86 Linux from https://downloads.plex.tv/plex-media-server-new/${versionNumber}/debian/plexmediaserver_${versionNumber}_amd64.deb"
echo "-----------------------------------------------------"
sleep 1
# Download the the installer, run it and then delete it
wget "https://downloads.plex.tv/plex-media-server-new/${versionNumber}/debian/plexmediaserver_${versionNumber}_amd64.deb"
echo "Running plexmediaserver_"${versionNumber}"_amd46.deb"
sudo dpkg -i plexmediaserver_${versionNumber}_amd64.deb
echo "-----------------------------------------------------"
sleep 1
echo "No longer need the installer, so removing plexmediaserver_"${versionNumber}"_amd46.deb"
sudo rm plexmediaserver_${versionNumber}_amd64.deb
