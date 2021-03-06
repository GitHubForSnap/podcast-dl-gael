# [podcast-dl-gael](https://snapcraft.io/podcast-dl-gael)

A simple script I use to download podcasts from YouTube and RSS feeds. It uses [youtube-dl](https://youtube-dl.org/) and a (badly) written bash script. Files are then synchronized to my laptop and mobile using [syncthing](https://snapcraft.io/syncthing-gael).

**Caveat:** It suits MY needs and is provided as-is. It's FOSS. Use it for whatever you want.

**Usage**

* List your YouTube video or playlist URLs here (one Youtube URL per line)
```
sudo vi /var/snap/podcast-dl-gael/common/podcast-dl/youtube-dl.conf.d/youtube-dl.url
```

* List your RSS feeds here (one RSS feed per line)
```
sudo vi /var/snap/podcast-dl-gael/common/podcast-dl/rss-dl.conf.d/rss-dl.url
```

* Podcasts are downloaded here once a day at 06:00
```
sudo ls -lh /var/snap/podcast-dl-gael/common/podcast-dl/podcasts/
```

* Display the last/next time podcast-dl has/will run
```
systemctl list-timers | grep -e NEXT -e podcast-dl-gael
```

**2021-08-27**
* New build to resolve CVE-2021-3634/USN-5053-1

**2021-07-23**
* New build to resolve CVE-2021-22898/CVE-2021-22924/CVE-2021-22925/USN-5021-1

**2021-04-14**
* New build to resolve CVE-2021-20305/USN-4906-1

**2021-04-01**
* New build to resolve CVE-2021-22876/CVE-2021-22890/USN-4898-1

**2021-03-26**
* New build to resolve CVE-2021-3449/USN-4891-1

**2021-03-20**
* Initial release
