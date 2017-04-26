# Deploy Scripts

This repository contains a set of scripts, for continuous integration purposes.

# Generic Instructions
* Install this repository as submodule of your (web?) application
* Configure your Continuous Integration service (example: Jenkins, Bitbucket Pipelines) to connect through SSH to your server
* Customize some environment variables in the Continuous Integration service o make a custom "trigger" script (in Bitbucket Pipelines use bitbucket-pipelines-yml). 
* In the "trigger" script, call through SSH the scripts as you need. Be careful with the parameters.
