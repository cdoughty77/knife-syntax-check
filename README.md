knife-syntax-check
==============

A small knife plugin to allow you to easily syntax check your ruby and/or json code for your cookbooks, roles, environments, databags, and nodes. 

Usage
=====

<pre>
$ knife syntax-check --help
knife syntax-check
    -a, --all                        Test syntax of all roles, environments, nodes, databags and cookbooks
    -c, --cookbooks                  Test only cookbook syntax
    -D, --databags                   Test only databag syntax
    -e, --environments               Test only environment syntax
    -n, --nodes                      Test only node syntax
    -r, --roles                      Test only role syntax
</pre>

Installation
============

Simply copy the syntax-check.rb [script to your .chef/plugins/knife/ folder](http://wiki.opscode.com/display/chef/Knife+Plugins).
Depends on the ['yajl-ruby' gem](https://github.com/brianmario/yajl-ruby) for json syntax checking.

How it works
============

Basically this plugin just piggy backs on existing knife commands when checking cookbooks.

However for nodes, environments, roles, and databags, syntax is checked as follows:
* JSON - checked using the yajl-ruby gem
* Ruby - checked using the 'ruby -c' command

Disclaimer
==========

This has ONLY been tested against hosted chef.  Bugs may and probably do exist.  If you find a bug or want a feature, please feel free to contact me or fork the repo, fix it yourself and issue a pull request.

License
=======

MIT

Copyright (C) 2013 Chris Doughty cdoughty77@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
