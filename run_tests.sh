#!/bin/bash

# Check the service
echo "Check the service"

snap services podcast-dl-gael.podcast-dl


# Cleanup
echo "Cleanup"

sudo rm -f /var/snap/podcast-dl-gael/common/podcast-dl/rss-dl.conf.d/rss-dl.url
sudo rm -f /var/snap/podcast-dl-gael/common/podcast-dl/rss-dl.conf.d/rss-dl.download.archive

sudo rm -f /var/snap/podcast-dl-gael/common/podcast-dl/youtube-dl.conf.d/youtube-dl.url
sudo rm -f /var/snap/podcast-dl-gael/common/podcast-dl/youtube-dl.conf.d/youtube-dl.download.archive

sudo rm -rf /var/snap/podcast-dl-gael/common/podcast-dl/podcasts/*

# Test RSS feeds on a clean archive
echo "Add RSS feeds"

echo "https://linuxmatters.sh/episode/index.xml /var/snap/podcast-dl-gael/common/podcast-dl/podcasts/LM" | sudo tee /var/snap/podcast-dl-gael/common/podcast-dl/rss-dl.conf.d/rss-dl.url > /dev/null
echo "https://latenightlinux.com/feed/extra" | sudo tee -a "/var/snap/podcast-dl-gael/common/podcast-dl/rss-dl.conf.d/rss-dl.url" > /dev/null

# Skip all the episodes
echo "Skip the episodes"

sudo podcast-dl-gael.rss-skip-download https://linuxmatters.sh/episode/index.xml
sudo podcast-dl-gael.rss-skip-download https://latenightlinux.com/feed/extra

# Check the number of episodes skipped
echo "Number of episodes skipped"

sudo wc -l /var/snap/podcast-dl-gael/common/podcast-dl/rss-dl.conf.d/rss-dl.download.archive

# Remove a guid from each feed in the RSS archive
echo "Remove a guid from each feed"

sudo sed -i '/https:\/\/traffic.libsyn.com\/latenightlinux\/LMP52.mp3/d' /var/snap/podcast-dl-gael/common/podcast-dl/rss-dl.conf.d/rss-dl.download.archive
sudo sed -i '/https:\/\/latenightlinux.com\/?p=3565/d' /var/snap/podcast-dl-gael/common/podcast-dl/rss-dl.conf.d/rss-dl.download.archive

# Download all the missing files and check them
echo "Download the missing files"

sudo podcast-dl-gael.download-now

sudo ls -lRh /var/snap/podcast-dl-gael/common/podcast-dl/podcasts

# Remove one of the destination folder, download files again and check no empty folders were created
echo "Remove one of the destination folder, download files again"

sudo rm -rf /var/snap/podcast-dl-gael/common/podcast-dl/podcasts/LM
sudo podcast-dl-gael.download-now

sudo ls -lRh /var/snap/podcast-dl-gael/common/podcast-dl/podcasts


# Cleanup
echo "Cleanup"

sudo rm -f /var/snap/podcast-dl-gael/common/podcast-dl/rss-dl.conf.d/rss-dl.url
sudo rm -f /var/snap/podcast-dl-gael/common/podcast-dl/rss-dl.conf.d/rss-dl.download.archive

sudo rm -f /var/snap/podcast-dl-gael/common/podcast-dl/youtube-dl.conf.d/youtube-dl.url
sudo rm -f /var/snap/podcast-dl-gael/common/podcast-dl/youtube-dl.conf.d/youtube-dl.download.archive

sudo rm -rf /var/snap/podcast-dl-gael/common/podcast-dl/podcasts/*

# Test yt-dlp on a clean archive
echo "Add a YouTube list"

echo "https://www.youtube.com/watch?v=G35mqJ9JtQM&list=PLV3QObPp4Pie78Ye0bVGk23aAC7WsPUhK" | sudo tee /var/snap/podcast-dl-gael/common/podcast-dl/youtube-dl.conf.d/youtube-dl.url > /dev/null

# Skip all the tracks
echo "Skip all the tracks"

sudo podcast-dl-gael.youtube-dl-skip-download https://www.youtube.com/watch?v=G35mqJ9JtQM&list=PLV3QObPp4Pie78Ye0bVGk23aAC7WsPUhK

# Check the number of tracks skipped
echo "Check the number of tracks skipped"

sudo wc -l /var/snap/podcast-dl-gael/common/podcast-dl/rss-dl.conf.d/rss-dl.download.archive

# Remove the 1st line of the download archive
echo "Remove the 1st line of the download archive"

sed -i '1d' /var/snap/podcast-dl-gael/common/podcast-dl/rss-dl.conf.d/rss-dl.download.archive

# Download all the missing files and check them
echo "Download all the missing files"

sudo podcast-dl-gael.download-now

sudo ls -lRh /var/snap/podcast-dl-gael/common/podcast-dl/podcasts
