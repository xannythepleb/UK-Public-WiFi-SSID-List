#!/bin/bash

# run this on your Pineapple to load this full list into PineAP automagically

# below is required if wget isn't installed
# opkg update && opkg install wget

wget https://raw.githubusercontent.com/xannythepleb/UK-Public-WiFi-SSID-List/main/UK-WiFi-Common-SSID-List-Alphabetical

pineap add_ssid_file UK-WiFi-Common-SSID-List-Alphabetical
