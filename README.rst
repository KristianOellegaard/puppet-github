puppet-github
-------------
A very simple report for puppet that creates a github issue if a run fails. It should probably be optimized, so that it doesn't post the same issue twice, if it occurs twice.

Heavily inspired by the different reports made by James Turnbull (@jamtur01).

Requirements
------------
ruby-json
puppet

Install
-------

Add to ``modules`` folder and add  ``reports=github`` to your puppet configuration, then add your github username/password using the bundled class. Check vagrant.pp

Testing
-------

There is a bundled Vagrantfile that will make an error. You can add your username/password in vagrant.pp and test it.
