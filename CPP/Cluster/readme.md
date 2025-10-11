<h1>CLUSTERF*CK Project</h1>
<h2>Yes, that's the official name.<h2>

This is project repository of the most random project ever.
It's a cluster build, that is composed solely of laptop mainboards and components. 

All software in this repo is written by me, mostly in C++ as the individual cluster nodes run on Linux. It's really simple stuff as I'm no cluster engineer, but feel free to take some inspiration from it.

The individual nodes of the cluster communicate via internal LAN managed by an ethernet switch. The slave/master programs make sure that communication works and that they can share jobs.

I also made some other stuff like autodiscover to make sure I can update the cluster configuration when I plug in new node and a cluster-wide system monitor so I can keep track of the individual nodes and their stats.

<h3>Current Clusters</h3>
There are multiple configurations of cluster systems we plan on running this software on. Our main goal right now is to run it on notebook mainboards. This configuration bears the name *NoteFrame* and there will be a lot more about it here soon. It's a scrap-based minimalistic design, but we'll make a proper ATX-based cluster later on as well. However the software should run on any given device as long as it has Unix OS and ethernet port.
<br>
<br>
<br>
<br>

**DISCLAIMER:**

This is purely a fun project and it's not meant to be on a proffesional level. If you find it to be too simple, flawed or not secure, you're right. We're not intending to use this in any public way, so don't worry. 
<br>
<br>
<br>
**In case of any cool ideas, recommendations or comments, feel free to contact me via anything you like or drop an issue/merge here on git.**