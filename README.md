Docker file need to build [Peridigm](http://peridigm.sandia.gov) from [johntfoster/trilinos](https://registry.hub.docker.com/u/johntfoster/trilinos/) base image.  

**PLEASE NOTE**: The *Peridigm* repo I am pulling from in the Dockerfile is private, therefore this repo is missing a few critical files.  Namely, the ssh_rsa files needed to SSH into Github and then from a running Docker image to another one (needed for MPI processes).  If you utilize your own source repo for *Peridigm*, this Dockerfile could be easily modified to work.
