<div align="center" id="top">
  <img src="./.github/frida4burp.jpg" width=50% alt="Frida4burp" />

  &#xa0;


</div>

<h1 align="center">Frida4burp</h1>

<p align="center">
  <img alt="Github top language" src="https://img.shields.io/github/languages/top/y0k4i-1337/frida4burp?color=56BEB8">

  <img alt="Github language count" src="https://img.shields.io/github/languages/count/y0k4i-1337/frida4burp?color=56BEB8">

  <img alt="Repository size" src="https://img.shields.io/github/repo-size/y0k4i-1337/frida4burp?color=56BEB8">

  <img alt="License" src="https://img.shields.io/github/license/y0k4i-1337/frida4burp?color=56BEB8">

  <!-- <img alt="Github issues" src="https://img.shields.io/github/issues/y0k4i-1337/frida4burp?color=56BEB8" /> -->

  <!-- <img alt="Github forks" src="https://img.shields.io/github/forks/y0k4i-1337/frida4burp?color=56BEB8" /> -->

  <!-- <img alt="Github stars" src="https://img.shields.io/github/stars/y0k4i-1337/frida4burp?color=56BEB8" /> -->
</p>

<!-- Status -->

<hr>

<p align="center">
  <a href="#dart-about">About</a> &#xa0; | &#xa0;
  <a href="#sparkles-features">Features</a> &#xa0; | &#xa0;
  <a href="#rocket-technologies">Technologies</a> &#xa0; | &#xa0;
  <a href="#white_check_mark-requirements">Requirements</a> &#xa0; | &#xa0;
  <a href="#checkered_flag-starting">Starting</a> &#xa0; | &#xa0;
  <a href="#snowman-disclaimer">Disclaimer</a> &#xa0; | &#xa0;
  <a href="#memo-license">License</a> &#xa0; | &#xa0;
  <a href="https://github.com/y0k4i-1337" target="_blank">Author</a>
</p>

<br>

## :dart: About ##

A set of scripts to facilitate HTTP interception on mobile apps using Frida and Burp.

## :sparkles: Features ##

:heavy_check_mark: Update third-party scripts;\
:heavy_check_mark: Generate Burp CA certificate in proper format to be used by scripts;\
:heavy_check_mark: Bypass SSL unpinning;\
:heavy_check_mark: Bypass anti-root;\
:heavy_check_mark: Any other script compatible with Frida.

## :rocket: Technologies ##

The following tools were used in this project:

- [Frida Mobile Interception Scripts](https://github.com/httptoolkit/frida-interception-and-unpinning)
- [Frida CodeShare](https://codeshare.frida.re/)
- [Frida](https://frida.re/)
- [Burp Suite](https://portswigger.net/burp)

## :white_check_mark: Requirements ##

Before starting :checkered_flag:, you need to have
[Burp](https://portswigger.net/burp) and [Frida](https://frida.re/) installed
and properly configured.

## :checkered_flag: Starting ##

```bash
# Clone this project
$ git clone https://github.com/y0k4i-1337/frida4burp

# Access
$ cd frida4burp

# Open Burp and run the script to get your certificate in PEM format
$ ./getburpcert.sh

# Copy the content of ./certs/cacert.pem into the marked location at `config.js`

# Update `config.js` according to your needs

# Use Frida to launch the app you're interested in with the scripts injected (starting with config.js). Which scripts to use is up to you, but for Android a good command to start with is:
$ frida -U \
    -l ./config.js \
    -l ./android/android-antiroot.js \
    .l ./android/fridantiroot.js \
    -l ./native-connect-hook.js \
    -l ./android/android-certificate-unpinning.js \
    -l ./android/android-certificate-unpinning-fallback.js \
    -l ./android/android-proxy-override.js \
    -l ./android/android-system-certificate-injection.js \
    -f $PACKAGE_ID

# You can, optionally, build all the scripts into a single one for convenience
$ ./build.sh

# In this case, you just need to run:
$ frida -U -l ./build/android-frida-single-script.js -f $PACKAGE_ID
```

## :snowman: Disclaimer ##

This repository is basically a collection of third-party scripts that I found
useful for instrumenting mobile applications, specially for intercepting
HTTP requests in Burp. Almost all the scripts stored here were simply copied from
[@httptoolkit/frida-interception-and-unpinning](https://github.com/httptoolkit/frida-interception-and-unpinning).

For now, I have just added some custom scripts to make this process easier.

## :memo: License ##

This project is under license from GNU Affero. For more details, see the [LICENSE](LICENSE) file.


Made with :heart: by <a href="https://github.com/y0k4i-1337" target="_blank">y0k4i</a>

&#xa0;

<a href="#top">Back to top</a>
