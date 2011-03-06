# Rekon
## Scout into your riak cluster

### About
Pronounced |ˈrēˌkän; riˈkän| (like recon)

**WARNING** This is alpha software, I had pretty much no idea what was going
to come out of 48 hours of me frantically prototyping this app.  I built it to
help train people on riak in a visual style.  As it turns out, its been pretty
useful so my goals are to test the crap out of it and continue to add
features.

Rekon is a data visualization utility inspired by Briak.  I have been waiting for
basho to release a list buckets feature, which is here in 0.14. 
[`http://127.0.0.1:8098/riak?buckets=true`](http://127.0.0.1:8098/riak?buckets=true)

Rekon will support earlier (though not well tested) versions of riak at current.  
Nodes that do not have the ability to list their buckets will require buckets to
be entered manually.

### To Do:
* Put some tests in here foo
* Get riak in memory test harness setup.
* Test connection to primary configured riak server
* add http authentication
* editing of per bucket parameters
* setting key content type
* editing links between keys
* add help links to basho wiki for stats and bucket properties


### Goals
Provide better visibility into riak nodes individually and as a cluster. 

### Prerequisites
1. A riak node to install on (to keep track of settings and cache buckets).

### Recommended
DejaVu Sans Mono font [http://dejavu-fonts.org/wiki/Main_Page](http://dejavu-fonts.org/wiki/Main_Page)

### Installation
`gem install rekon`

### Usage
`rekon` or `rekon path\to\ripple.yml`

### Credits
* Ripple by Sean Cribbs
* Briak by John Lynch
* Icons by [http://p.yusukekamiyamane.com/](http://p.yusukekamiyamane.com/)
