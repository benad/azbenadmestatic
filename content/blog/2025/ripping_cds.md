---toml
date = "2025-04-13T16:00:00-04:00"
title = "Ripping CDs Like It's 2000"
---

[Ripping](https://en.wikipedia.org/wiki/Ripping) audio CDs in 2025 is rather uncommon. Maybe you bought a "collector's edition" disk, maybe you prefer having a compression-less copy of an album that doesn't rely on a subscription service or any kind of online account, or maybe you just have very old CDs that never made the transition to streaming services. Whatever is the reason, ripping CDs in 2025 can be considerably more difficult than in 2000.

The first obvious obstacle is the lack of CD drives in most modern computers. They are still sold, and external "slim" USB-3 drives are still commonplace and convenient, as they can be used with laptops (unlike internal drives). Many require an external power supply, though mine is "self-powered" if connected on 2 USB ports.

But what about the software? In the past I used [iTunes](https://www.apple.com/itunes/), but now it is limited to podcasts and audio books. Its replacement, the app for [Apple Music](https://www.apple.com/apple-music/), doesn't support CDs anymore. Technically, ripping CDs is still possible in iTunes, but it assumes you're ripping an audio book CD, so it behaves a bit strangely.

I tried a few CD ripping software for Windows, and I ended up using [foobar2000](https://www.foobar2000.org/). What I wanted was to rip the CD, match it against some online track info data, encode it in MP4 AAC (or something close to what iTunes used to do), be able to add some cover images to the MP4 files, and then import the result in my music libraries.

foobar2000 can make use of Apple's own AAC encoder, as long as you install Apple Music and then the "[foobar2000 Free Encoder Pack](https://www.foobar2000.org/encoderpack)". The [qaac tool](https://github.com/nu774/qaac) used by foobar2000 will then be able to make use of the libraries from Apple Music. It should be noted that the "CBR" mode can corrupt audio, so you should use "Constrained VBR" instead (which is exactly what iTunes used). There are few good AAC alternatives (that also can be used by foobar2000), though another one I tried is [fhgaacenc](https://github.com/tmkk/fhgaacenc) which makes use of the old [Winamp](https://www.winamparchive.org/), be it by installing Winamp first or by [extracting a few specific files from its installer](https://wiki.hydrogenaud.io/index.php?title=Fhgaacenc).

Once the audio tracks are ripped, you can use foobar2000 to set a cover image on all the track files at once. I use either the images found on [Discogs](https://www.discogs.com/) or using [Bing's image search](https://www.bing.com/images) (I work at Microsoft, so I'm biased about my choice of web search engines). 

At that point, I copy the files over to Apple Music, which uploads them to my cloud-based music library using [iTunes Match](https://support.apple.com/en-us/108935). I talked about [iTunes Match a long time ago](/blog/2012/1/4/itunes-match-is-it-worth-it/), and it still works well. Its subscription is independent than Apple Music's own subscription, and now that Apple Music is [available on Windows](https://apps.microsoft.com/detail/9pfhdd62mxs1?hl=en-CA&gl=CA), [Android](https://play.google.com/store/apps/details?id=com.apple.android.music) and even [on the web](https://music.apple.com/), my collection isn't restricted to Apple devices anymore. Another option is to use [YouTube Music Premium](https://www.youtube.com/musicpremium) and then [upload your music files](https://support.google.com/youtubemusic/answer/9716522?hl=en).
