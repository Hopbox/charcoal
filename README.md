charcoal
========

Copyright Unmukti Technology Pvt Ltd. All rights reserved.
Licensed under GPL. See LICENSE file for more details.

Web API based Squid URL Redirector

1. Why the name charcoal?
=========================
Charcoal is used as sediment filter for water. Internet data is water for users, while Network Administrators would like to 
filter out the sediments that use up the bandwidth unnecessarily.

2. Why a web API based filter?
==============================
To make lives of adminstrators a bit easy. Instead of spending time and energy on periodically updating the blacklists from 
multiple sources, maintaining them, they should focus on getting things done. While we manage the blacklists.

It also helps a great deal if you have to manage 10s or 100s of locations. Managing blacklists and policies across them is a 
real pain. 

Charcoal helps you create and implement policies across distributed networks in a jiffy.

3. How does it all fit together?
================================

Charcoal has 2 components
* _Server_

	+ *WebGUI* for creating policies
	+ *API Server* for enforcing the rules
* _Client_

It is a squid helper which runs on your squid server. It receives requests from squid and consults with the API server for the
policy to be applied. If the API server tells it to let the request pass, it is ALLOWED. And if API server finds that this user
is not allowed to access this destination at this hour with this User-Agent while trying to use the method POST to upload a file
of type audio/mp3, it tells the helper to redirect the user to a block page.

All this happens within a few milliseconds.

4. System requirements
======================

* Client

Squid helper is written in Perl and is currently running on following systems:
	+ OpenWRT on
		- ALIX (http://pcengines.ch/alix.htm)
		- APU and APU2 (http://pcengines.ch/apu.htm and http://pcengines.ch/apu2.htm)
		- Routerboard RB951Ui-2HnD
	+ PfSense on x86 (ALIX included)
	
It can run on any Unix system which has:
	+ Perl > 5.14.x
		- IO::Socket

* Server

Server hardware sizing depends on the size of the deployment and number of requests per second.

5. Squid Versions supported
===========================
Squid-2.x is supported in compatibility mode with *-c* argument to the helper. While Squid-3.x is supported natively.
We will add support for Squid-4.x soon.

6. Setup and configuration
==========================
