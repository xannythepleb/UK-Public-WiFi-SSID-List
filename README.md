# UK Public WiFi SSID List

An alphabetic list of the most frequently used UK public WiFi names. Gathered via recon and scraping. All SSIDs in this list are publicly broadcast.

Most are generic for widely found routers, providers, hotels, restaurants, etc while others are location specific e.g. London Underground, bus and train companies, and various local council hotspots.

Scan for WiFi in any busy area in the UK and you will almost certainly find at least one SSID on this list.

Made this a repo rather than a gist so it can be open to PRs and there is the potential to create separate categorised lists for location specific SSIDs and scripts etc.

My plan is to use this to demonstrate the dangers of public WiFi in a white hat manner. Got ideas to contribute to that effort? Throw a PR!

**What you do with this info is not my responsibility. If you load them into PineAP or similar, only do so for educational purposes or for white hat/pentesting projects. It is on you to follow all applicable laws and regulations.**

## I'm new to this. How does a list of WiFi network names have any impact on security?

WiFi is specifically designed so that a device will auto connect to any access point broadcasting the same name (SSID) as one it knows even if it comes from a different router with a different MAC address. This is so it can support "roaming" - for instance in an office or hotel, there will be multiple routers throughout the building. Roaming is useful here since connecting to one means you connect to the rest as long as they have the same name and password.

The fact they must have the same password adds security for encrypted networks (although handshakes can still be intercepted and used to crack a password, but this is more difficult and an extra step) however for open WiFi networks that only authenticate through captive portals (login pages) merely broadcasting an identical SSID is enough to make any device currently or previously on that network connect to an evil twin AP. Anyone with a WiFi radio can broadcast an evil twin of any open network, and even run a deauthentication attack on it to force devices onto the "evil" one.

Once those devices connect, the evil twin network just has to show its own captive portal. It is trivial to use CSS to make it resemble the real one. Most people will think there was a short WiFi blip and have no reason to suspect an attack is going on, and anyone who joins after won't notice anything at all, but in reality all the details they enter into the portal are being sent to the attacker's computer.

https://github.com/xannythepleb/UK-Public-WiFi-SSID-List/assets/133000108/e1ca24c6-39ff-4442-b326-9caf3a46fede

Above is an example where I ran a captive portal phishing attack against myself using the extremely common Wifi Extra SSID that is preinstalled on O2 and giffgaff phones even if they never connected to it before. These captive portal attacks are so easy to carry out discreetly because unlike modern websites, captive portals are usually served up over plain HTTP without any encryption whatsoever, so devices have no way to check if a captive portal is legitimate, whereas for an HTTPS site they can tell if a certificate is spoofed (self-signed).

After the captive portal is submitted you can access the internet but you are proxied through the evil twin controlled by the attacker who is now a "man in the middle." They control the network so they can run additional attacks on any device connected. For instance, if you haven't updated your phone to the latest OS, it is often easy to find known exploits that allow remote code execution if the attacker owns the network you're on.

An attacker can also serve up a payload using the captive portal itself. This could be a browser exploit that pwns your device through the web view or simply displaying a page tricking you into installing a malicious app onto your own device by claiming it's required to access the network.

Own the network, own the devices.

A VPN won't protect you against any of these attacks.

**Don't use public WiFi.**

More detailed guides on how these attacks are carried out can be found [here](https://github.com/ivan-sincek/wifi-penetration-testing-cheat-sheet) and documentation on how WiFi works, and therefore why the attacks work, can be found [here.](https://docs.hak5.org/wifi-pineapple/wifi-basics/introduction-to-wifi)

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
