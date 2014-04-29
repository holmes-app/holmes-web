Contributing
============

Installation
------------

Installation instructions for development enviroments.

### Requirements

The holmes-web requires the following tools to work:

* [ruby](https://www.ruby-lang.org/)
* [rvm](https://rvm.io/)
* [node](http://nodejs.org/)
* [npm](http://nodejs.org/)
* bower `npm install -g bower`
* grunt `npm install grunt`
* grunt-cli `npm install -g grunt-cli`

### Installation

Add in your `/etc/hosts`:

    127.0.0.1   local.holmes.com

To install just type:

    make setup

To run:

    make run

To test:

    make unit
