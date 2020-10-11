---
title: "dotnet BitTorrent library written in C#"
date: 2020-10-09T23:00:00+01:00
draft: false
tags: ["dotnet", "bittorrent", "csharp", "library", "torrent", "bt"]
author: ["darren"]
---

[System.Net.Torrent](https://github.com/bizzehdee/System.Net.Torrent) is an open source bittorrent scraper and peer wire implementation written in C#
<!--more-->
It includes:

- [x] Tracker Announce (HTTP/UDP)
- [x] Tracker Scrape (HTTP/UDP)
- [x] PeerWire (TCP) Client
- [x] Choke
- [x] Unchoke
- [x] Interested
- [x] Not Interested
- [x] Have
- [x] Bitfield (Optional obsfucation)
- [x] Request
- [x] Piece
- [x] Fast Protocol Extensions
- [x] Extended Protocol Extensions
- [x] Local Peer Discovery (Non-existant Multicast BEP-14)
- [x] Peer Exchange (utPEX)
- [x] Trackerless Metadata (utMetadata)
- [x] Magnet Link Parser
- [x] Bencode Encode/Decode
- [x] .torrent Metadata Parser
- [x] Tracker Exchange Protocol

**Resolving a magnet link to metadata (.torrent file)**
```csharp
static void TestAsyncMagnetLink()
{
    var ubuntuMagnetLink = "magnet:?xt=urn:btih:e4be9e4db876e3e3179778b03e906297be5c8dbe&dn=ubuntu-18.04-desktop-amd64.iso&tr=http://torrent.ubuntu.com:6969/announce";

    var magnetMetadata = MagnetLink.ResolveToMetadata(ubuntuMagnetLink);

    foreach (var item in magnetMetadata.AnnounceList)
    {
        Console.WriteLine(item);
    }
}
```
**Scraping announce/tracker URLs**
```csharp
static void ScrapeTorrent()
{
    var scraper = new HTTPTrackerClient(15);
    var announce = scraper.Scrape("http://torrent.ubuntu.com:6969/announce", new string[] { "e4be9e4db876e3e3179778b03e906297be5c8dbe" });
}
```
**Announce (request peers from the tracker)**
```csharp
static void AnnounceTorrent()
{
    var scraper = new HTTPTrackerClient(15);
    var peers = scraper.Announce("http://torrent.ubuntu.com:6969/announce", "e4be9e4db876e3e3179778b03e906297be5c8dbe", "-LW2222-011345223110");
}
```