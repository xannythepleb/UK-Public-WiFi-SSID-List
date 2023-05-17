# UK Public WiFi SSID List

An alphabetic list of the most frequently used UK public WiFi names. Gathered via recon and scraping. All SSIDs in this list are publicly broadcast.

Most are generic for widely found routers, providers, hotels, restaurants, etc while others are location specific e.g. London Underground, bus and train companies, and various local council hotspots.

Scan for WiFi in any busy area in the UK and you will almost certainly find at least one SSID on this list.

Made this a repo rather than a gist so it can be open to PRs and there is the potential to create separate categorised lists for location specific SSIDs and scripts etc.

My plan is to use this to demonstrate the dangers of public WiFi in a white hat manner. Got ideas to contribute to that effort? Throw a PR!

**What you do with this info is not my responsibility. If you load them into PineAP or similar, only do so for educational purposes or for white hat/pentesting projects. It is on you to follow all applicable laws and regulations.**

## How to use the script to add the full list to PineAP

The web UI only allows you to add one SSID at a time. If you want the entire list, SSH into your Pineapple and you can use the shell script to automate filling your SSID pool with the latest version.

You run the script directly on your Pineapple. Tested on an Mk7. No reason it wouldn't work on any Pineapple as long as the `pineap` command works the same way. Make sure to `cd` to the SD if you have a Nano.

Download from the Pineapple shell:

```
wget https://raw.githubusercontent.com/xannythepleb/UK-Public-WiFi-SSID-List/main/grab-uk-ssids-pineap.sh
chmod +x grab-uk-ssids-pineap.sh
```

Run from the Pineapple shell whenever you need it:

```
./grab-uk-ssids-pineap.sh
```

The script is very simple: it uses `wget` to grab the latest version and `pineap add_ssid_file` to add it to the SSID pool.

If you are offline and have previously downloaded the list you can simply add it using `pineap add_ssid_file` plus the file name.

## How does a list of SSIDs have any impact on security?

WiFi is specifically designed so that a device will auto connect to any access point with the same name as one it knows even if it comes from a different router with a different MAC address. This is so it can support "roaming" - for instance in an office or hotel, there will be multiple routers throughout the building. Roaming is useful here since connecting to one means you connect to the rest as long as they have the same name and password.

The fact they must have the same password adds security for encrypted networks (although handshakes can still be intercepted and used to crack a password, but this is more difficult and an extra step) however for open WiFi networks that only authenticate through captive portals (login pages) the name alone is enough to make any device currently or previously on that network connect to an attacker who creates an evil twin network. Anyone with a WiFi radio can broadcast an evil twin of a public network, and even run a deauthentication attack on the real network to force devices onto the fake one.

Once those devices connect, the evil twin network just has to show its own captive portal. It is trivial to use CSS to make it resemble the real one. Most people will think there was a short WiFi blip and have no reason to suspect an attack is going on, and anyone who joins after won't notice anything at all, but in reality all the details they enter into the portal are being sent to the attacker's computer. This is so easy to do because unlike modern websites, captive portals are usually served up over plain HTTP with no encryption.

After that you can access the internet but you are proxied through the evil twin controlled by the attacker who is now a "man in the middle." They control the network so they can run additional attacks on any device connected. For instance, if you haven't updated your phone to the latest OS, it is often easy to find known exploits that allow remote code execution if the attacker owns the network you're on.

Own the network, own the devices.

A VPN won't protect you against such an attack.

**Don't use public WiFi.**
