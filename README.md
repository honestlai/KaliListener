# Kali Linux 2022.4 Docker Container with XFCE Desktop w/ VNC/noVNC & optional Meshagent

Welcome to my first docker container build. This is a full Kali Linux container environment with the the desktop experience, a few customizations, and scripts I created while pentesting.

This container instance comes with a reverse shell listener that listens on port 465 for unencrypted tcp traffic using socat to establish it's connection. All sessions captured are automatically moved over to a screen session that can be viewed and grabbed when connecting to the cli of this container.

**IMPORTANT:** This image is for testing purposes only. Do not run it on any production systems or for any productive purposes. Feel free to modify it as you like

... more details, screenshots, and instruction to come.# KaliListener
