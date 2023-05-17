# UK Public WiFi SSID List

An alphabetic list of the most frequently used UK public WiFi names. Gathered via recon and scraping. All SSIDs in this list are publicly broadcast.

Most are generic for widely found routers, providers, hotels, restaurants, etc while others are location specific e.g. London Underground, bus and train companies, and various local council hotspots.

Scan for WiFi in any busy area in the UK and you will almost certainly find at least one SSID on this list.

Made this a repo rather than a gist so it can be open to PRs and there is the potential to create separate categorised lists for location specific SSIDs and scripts etc.

My plan is to use this to demonstrate the dangers of public WiFi in a white hat manner. Got ideas to contribute to that effort? Throw a PR!

**What you do with this info is not my responsibility. If you load them into PineAP or similar, only do so for educational purposes or if authorised for white hat pentesting purposes. It is on you to follow all applicable local laws and regulations.**

## How to use the script to add the full list to PineAP

The web UI only allows you to add one SSID at a time. If you want the entire list, SSH into your Pineapple and you can use the shell script to automate filling your SSID pool with the latest version.

You run the script directly on your Pineapple. Tested on an Mk7. No reason it wouldn't work on any Pineapple with internal storage. Has to be modified for the Nano with SD storage.

Download from the Pineapple shell:

```
wget https://raw.githubusercontent.com/xannythepleb/UK-Public-WiFi-SSID-List/main/grab-uk-ssids-pineap.sh
chmod +x grab-uk-ssids-pineap.sh
```

Run from the Pineapple shell whenever you need it:

```
./grab-uk-ssids-pineap.sh
```

The script is very simple: it simply uses `wget` to grab the latest version and the `pineap add_ssid_file` command to add it to the SSID pool.

If you are offline and have previously downloaded the list you can simply add it using the `pineap add_ssid_file` command.
