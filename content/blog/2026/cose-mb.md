---
date: "2026-11-29T20:00:00-05:00"
title: "COSE-MB: Encrypted Messaging for Micro-Blogging Platforms"
---

***TODO***

https://github.com/benad/cose-mb-proto

# Primary Source: OneDrive Backup

I'm always sceptical of encrypted messaging apps. Whatever well intentioned and audited by 3rd-parties, too often there's just one implementation of the messaging client, and it just so happens to be the flagship one shipped on closed-sourced app stores. Some logic, like message deletion, may also depend on the well-behaviour of the messaging server, which just so happens is also hosted by the same people that defined the protocol *and* shipped the *de-facto* standard client.

It is true that some level of privacy and "working around government-imposed firewalls" involves clever server-side work. But I remain skeptical of those (nearly) single-vendor encrypted messaging stacks. Especially for larger corporations, like Apple or Meta, that can be pressured by large governments. While for smaller non-profit groups, you only need one supply-chain attack and a little bit of server-side backdoor to defeat the whole "encrypted, secure and private" edifice.

## PGP and Emails

I used to be a fan of PGP. While it can encrypt or sign any file, I liked how it could be "ASCII armored" into plain text, making it easy to transport over email. With its open specifications (***TODO*** RFC), named OpenPGP, and its primary open-source implementation, GnuPG, it became a sort of de-facto standard for file and message signature and encryption.

The problem is, it kind of sucks. Its whole system of key exchange and trust levels is just far too complex for most people, myself included. The tools, even more recent GUI ones (***TODO*** examples, like Kleopatra? and Mac one), still end up being too complex to use. Even the simplest of use cases, encrypting a file with a password, is somehow difficult.

The truth is that if the security thing is not dead easy, people don't bother. Even if OpenPGP was available for email for decades now, everybody still sends plain text emails. Security is seen as a transport thing, not a client-side thing.

## S/MIME

***TODO** Is S/MIME older than OpenPGP? Answer: Both were made in the early 90s, standardized as RFCs in late 90s. S/MIME: RFC 2331 1998. OpenPGP: RFC 1991 1996.

On a quick aside, in the late 90s, there also was S/MIME, as in "secure MIME" encrypted and signed emails, that was natively supported by the most popular email clients. It built atop of X.509, with the difference that the certificate is for an email address rather than a host name. If fact, some email clients like Apple's NeXT Step based Mail.app, still support it in some form or another.

If you think that PGP had low adoption rate due to its barrier of entry, imagine if you had to *buy* your own email certificate, the same way you would buy an HTTPS SSL certificate. Yeah, not free, needs email client that supports it, nobody's going to bother. To this day it remains a niche enterprise thing.

But that aside also raises an uncomfortable truth about 2020s messaging: Most of it isn't done by email. It's social networks, text-messaging-like, micro-blogging and so on. S/MIME's and OpenPGP's formats are just too large and inconvenient for anything but file transfer and email.

TODO note: S/MIME was supported in Netscape Communicator 4. It was the flagship implementation before S/MIME v2 was standardized in 1998 RFC 2311.

## JOSE

***TODO*** Really simple, compared to the bloated OpenPGP and S/MIME. Look at the number of implementations of JWT and JWS and JWK. Not all stacks are full or equivalent, but it just shows that it's "dumb-proof" enough to be implemented anywhere, without decades of legacy stuff to support. It's more "pick and choose", but the specs are really clear.

* JWT (https://datatracker.ietf.org/doc/rfc7519/ ): JSON Web Token
* JWS (https://datatracker.ietf.org/doc/rfc7515/ ): Integrity protection via digital signatures	
* JWE (https://datatracker.ietf.org/doc/rfc7516/ ): Confidentiality via encryption	
* JWK (https://datatracker.ietf.org/doc/rfc7517/ ): JSON representation of cryptographic keys	
* JWA (https://datatracker.ietf.org/doc/rfc7518/ ): Algorithms for JWS/JWE

## COSE

***TODO*** Was a fan of CBOR before finding COSE even existed. Self-describing like JSON or XML, has a bit of XML-like extensibility (through tags), doesn't require a schema like Protobuf. Not just "binary JSON" like MessagePack. Doesn't support "out of the box" every known structure like YAML. Specs is small and "dumb-proof", to the point that most software doesn't have the need to use a common "CBOR library" and just implement what's needed from scratch. Comparison between "the spec is too small and ambiguous" (JSON minefield), "the spec is too bloated" (XML, or worse, YAML).

https://datatracker.ietf.org/doc/rfc9052/

***TODO*** CBOR applied to JOSE, and more flexibility, equals COSE. Far fewer library implementations than JOSE, but is increasingly popular, and again simple enough that most software just implement from scratch. Which is quite a feat compared to the monstrous ASN.1 X.509 stack, or the custom binary format of OpenPGP.

## COSE-MB Idea

***TODO***

## Examples

Public key:

```
C1;S=k1;;ogBYS6QBAiABIVggsKUDQ8eKZnAnwgERnO2B1-ehHjmzlQntgcE9h0B4Ea0iWCBAW_372-wVGoDbzWSvTKwCmhCIR6Ri_BRIrgwe-2hfHQEB
```

Message:

```
Hello, world!
```

Encrypted to self, Blusky 300-chars limit:

Fragment 1:

```
C1;P=1/02;I=4ad50853;;ogBY4NhghEOhAQOhBUyLgSGhOD3nJ4KfT0hYdK8deeq0hVqG1fq4RKmWrHj1wsocv4vNUwUkTsyuFwDpasuRkt3Z75jtYPMKZEHmaPmSnp5OzZOQ-ZjFyjMX7Rv80oARZPT9RWQS48Ywx8igFQUaDZKwHR_i-jDwsKv-dknomIBIT7-9-LJvUSUG-E3WN8RkgYNAogE4GCCkAQIgASFYIGflpLHPO8gAvzGKCtlwaOmDLTCw9qU4AvHXvO54NUMiIlggLtUYe5QXOP3CcS-bXH
```

Fragment 2:

```
C1;P=2;I=4ad50853;;eT8MKdzfI5l59tuzEFBo76v6xAAQI
```

Overhead is P-256 ephemeral key, nonce, COSE structure, timestamp.

[Base85](https://rfc.zeromq.org/spec/32/):

```
C1;E=1;;Q5XrN/Kfw1P-Cm?1X:OsuMb(aYB(E}I-aWVx!>I!6-M^u[]P%Tp9foia3L7/h5!}$<4I5S/L]d:n$54]!@pyn0h?cAN&4fFvBz@FYH5S+wfs(iD{i:}w<03iP.d68Rds%.dRaJ4iFVzJ[:M[b-s!J!Xry4{V@:gv9KS46r]]O[kZRdS2S/lKFRcjZ0xp]sQYyJt0u>L/M0goECy=XeaMmRu0Si=Gysxt@/c&zI&X6u*mO.rhb3k%zA-%Db2t=zcawwq}(([(Z99<h85J!B&OaiHD{RmIe0rJl3
```

[Base2048](https://github.com/qntm/base2048), seems to work well with Twitter and Bluesky:

```
C1;E=2;;ਝUњଛħʨࠌʝਕϘϮྌ௰໔шළฐಀಬଜԱςκຯଶࠑӨƵƵಣܨƷܤRӻൎԵوϣශࡧøՍॺڄϿၒʩཨψलඅॐઍဂԛஞऋՊoඍॾҟȥકಝȢ๐ѬଽÞܦԚථθبBFಪဿٺqওݓಠദя੦Գ൯ǷಐਇΓ୮ݧૠࢰߗҬѵଜஹސඥƓകӈȶƓࠀߘP8Ԋଗf২Тƾဃธ೫ֆܯවȜચܨݭਚ෫ߏഉଆѰצƏλശΝƺχڧݟܙ௭ڦΦݙƸܣȥƮਉཫগरɽυ౸ӈԗܐजਇe2
```

## TODO OLDER

- Issues with "full-stack" encrypted messaging platforms.
  - Heavily depends on auditing.
  - Difficult to prove reproducible builds on closed App platforms.
  - Rarely have 3rd-party implementations.
  - "Trust me bro" for message deletion.
- PGP was nice, but...
  - *Old*
  - "specified in RFC 9580 (which obsoletes RFC 4880)". 17 years between RFC updates.
  - Custom binary format specs.
  - Made for emails, not *tiny* messages, doesn't support fragments.
- S/MIME:
  - Niche, if not abandoned at this point.
  - X.509 and its ASN.1 encoding *sucks*.
  - Very few implementations. Complexity created only a handful of full-stack TLS implementations that can properly support it, with subtle differences.
- JOSE:
  - Almost what I want, but JSON is *big*.
- COSE:
  - Always was a fan of CBOR.
  - Smaller than JOSE.
  - Fewer implementations that JOSE, but then re-implementation is simple enough (really!).
- Idea:
  - Use micro-blogging platforms as an "untrusted substrate" to exchange messages.
  - Key exchange P-256 COSE_Key . Fingerprint / trust may be out-of-band exchange.
  - CBOR payload, COSE_Sign1, COSE_Encrypt with Ephemeral P-256 and IV, HKDF with SHA-256, encrypt with AES 256 GCM
  - For encoding binary CBOR messages: Base64, split in fragments to fix in max message size, add headers to each fragment
  - Should be secure, prefer standards over custom specs. (Header format is custom, rest is standards.)
  - Should take < $10 USD to implement with AI. My prototype, up to self-contained HTML page, cost me about $15 using GPT 6.1 Sol.
