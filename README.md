android-autoget-makefile
========================

If you've ever tried to install the android SDK automatically, then you know that
there are tons of user agreements and other things that prevent you from doing a
fully automated build. Because of this, I've put together a small makefile that
automatically accepts all the license agreements for you and completely updates 
the SDK.

Please note that this is not meant to bypass the legal restrictions you have with
the licences. You are still bound to whatever licenses the Android SDK requires.
Because of this, it is important that you understand that this script is merely
for fully automated builds(eg: Jenkins builds). Every developer should know and
understand the licenses required by the SDK, but if you have any questions, then
feel free to ask someone else other then me(I'm not a lawyer).

Installation
========================

Just place this file somewhere in your build path and call "make" and it will
install the Android SDK and Android NDK.

It downloads the SDK and NDK to the "downloads" folder and then unzips the 
packages. After unzipping the packages, it then fires off the android script
which then grabs all the packages it can find. On a fast internet connection, you 
can expect it to take 30-40 minutes to complete. Go grab a cup of coffee, check 
your email, read up on the awesomeness of Android, etc. When you come back, 
everything is installed and ready to go.

Only tested on Ubuntu 13.04

Uses "wget" and "expect"

Future Work
========================

It sure would be nice to have a fully automated Windows version, but hey, at 
least this is a start.

Bugs & Patches
========================

If any of the resources become unavailable(eg: the download link stops working)
then please send me a message and I'll get it up to date. 

Patches are very welcome! Thank you!


