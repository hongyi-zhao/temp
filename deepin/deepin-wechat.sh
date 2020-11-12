#!/usr/bin/env bash
# When invoking the script from desktop file, only the following functions are available.
# So, run the script directly instead of calling it from a Desktop file.

#$ declare -F
#declare -f clearLmod
#declare -f clearMT
#declare -fx ml
#declare -fx module
#declare -f xSetTitleLmod

# When sourcing the script from ~/.profile, 
# "${0}" has the following value: /etc/gdm3/Xsession
script_init=_bash_custom_lib_script_init
$script_init "${BASH_SOURCE[0]}" "${0}"

# Execute the judgemant logic for using the self-defined git function when the corresponding git repo exists.
if [[ "$(declare -pF git 2>/dev/null)" =~ ' -fx ' ]] && [[ "${BASH_SOURCE[0]}" = "${0}" ]] && [ -d "$topdir/$script_basename/.git" ]; then
  prepare_repo () {
    git clean -xdf
    git reset --hard
    git pull
  }
fi 

#$script_dirname is equivalent to $topdir.

#https://github.com/mviereck/dockerfile-x11docker-deepin/issues/21
#$ x11docker -h | egrep -A 5 -- '--home |--share '
# -m, --home [=ARG]     Create a persistant HOME folder for data storage.
#                       Default: Uses ~/.local/share/x11docker/IMAGENAME.
#                       ARG can be another host folder or a Docker volume.
#                       (~/.local/share/x11docker has a softlink to ~/x11docker.)
#                       (Use --homebasedir to change this base storage folder.)
#     --share ARG       Share host file or folder ARG. Read-only with ARG:ro
#                       Device files in /dev can be shared, too.
#                       ARG can also be a Docker volume instead of a host folder.

#https://github.com/mviereck/dockerfile-x11docker-deepin/issues/22


#https://github.com/mviereck/dockerfile-x11docker-deepin/issues/21#issuecomment-725443453

#As a rule of thumb, I'd say:

#    Use --home if you want to store configurations of applications.
#    Use --share ~/sharefolder to share data between host and container.

#For example, I run my firefox container with --home --share=~/Downloads. So firefox configuration like bookmarks is stored with --home, but Downloads are directly accessible in my host Download folder.

#https://github.com/mviereck/dockerfile-x11docker-deepin/issues/20#issuecomment-725433348
#    Can I let x11docker work with a normal way which respects the stuff resides in /etc/sudoers.d/ and don't change the default /etc/sudoers?
#    In addition, can I create the corresponding /etc/sudoers.d/nopasswd with Dockerfile during running the docker build command?

#This is possible with --user=RETAIN.

#    BTW, how to set an empty password for sudo via x11docker's option?

#There is no direct option because I discourage passwordless sudo. However, you could execute the two commands with option --runasroot. Example:

#x11docker --sudouser --desktop \
#  --runasroot 'echo x11docker | sudo --stdin su -c "echo \"$USER ALL=(ALL) NOPASSWD:ALL\"  > /etc/sudoers"'  \
#  --runasroot 'echo x11docker | sudo --stdin su -c "echo \"root ALL=(ALL) ALL\" >> /etc/sudoers"' \
#  x11docker/xfce 

#You can make a shortcut of this with option --preset.



#https://github.com/mviereck/dockerfile-x11docker-deepin/issues/20#issuecomment-725508790

#    What content for this example should I use to obtain the predefined options stored in a file named as FILE?

#Example:

#lauscher@debianlaptop:~/.config/x11docker/preset$ cat nopasswd 
#--runasroot 'echo x11docker | sudo --stdin su -c "echo \"$USER ALL=(ALL) NOPASSWD:ALL\"  > /etc/sudoers"'  
#--runasroot 'echo x11docker | sudo --stdin su -c "echo \"root ALL=(ALL) ALL\" >> /etc/sudoers"' 

#Please update x11docker first, just found a parsing bug in --preset. Is fixed now.

#Use e.g. as

#x11docker --sudouser --preset nopasswd --desktop x11docker/xfce

#https://github.com/mviereck/dockerfile-x11docker-deepin/issues/20#issuecomment-725391462


#    x11docker sets up a new /etc/sudoers and /etc/sudoers.d/* will not be used.

#Why is it designed with this working mode? Can I let x11docker work with a normal way which respects the stuff resides in /etc/sudoers.d/ and don't change the default /etc/sudoers?

#https://github.com/mviereck/dockerfile-x11docker-deepin/issues/20#issuecomment-725433348
#    Why is it designed with this working mode?

#This is part of the security concept of x11docker.
#https://github.com/mviereck/x11docker#security

#https://github.com/mviereck/dockerfile-x11docker-deepin/issues/20#issuecomment-725526075


#    --runasroot 'echo x11docker | sudo --stdin su -c "echo "$USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers"'
#    --runasroot 'echo x11docker | sudo --stdin su -c "echo "root ALL=(ALL) ALL" >> /etc/sudoers"'

#Do you think the above two lines are enough? See for my case, I've the following contents in /etc/sudoers shipped with Ubuntu 20.04:

#werner@X10DAi:~$ sudo grep -Ev '^[ ]*(#|$)' /etc/sudoers  
#Defaults	env_reset
#Defaults	mail_badpass
#Defaults	secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
#root	ALL=(ALL:ALL) ALL
#%admin ALL=(ALL) ALL
#%sudo	ALL=(ALL:ALL) ALL

#https://github.com/mviereck/dockerfile-x11docker-deepin/issues/22#issuecomment-725773807
#Based on my tries, this problem will happen for any of the following cases:

#    Use the --home option
#    Use the share folder not directly/immediately located under $HOME, say, --share ~/Documents/x11docker

#To be simple, only the usage similar to the following can fix the problem:

#--share ~/x11docker-share-folder-name

#I really can't figure out the reason. It maybe a bug of x11docker.



x11docker_share=$HOME/x11docker-share
if [ ! -d $x11docker_share ]; then
  mkdir -p $x11docker_share
fi


#https://github.com/mviereck/dockerfile-x11docker-deepin/issues/16#issuecomment-725624403

#Surprisingly I got wechat running:

#x11docker  --hostdisplay --clipboard -- wechatimage sh -c '/opt/deepinwine/apps/Deepin-WeChat/run.sh ; sleep 5; while pgrep WeChat; do sleep 1; done'

#It fails with other X servers, and it takes a very long time until the window with QR-code appears.

#(The additional pgrep/sleep loop is needed because the WeChat process moves itself to run in background. A foreground process is needed to keep the container running.)

#https://github.com/mviereck/dockerfile-x11docker-deepin/issues/16#issuecomment-725740401
#Tricky and wonderful. I confirm that your conclusion is correct with the following command:

#$ x11docker --hostdisplay --clipboard -- hongyi-zhao/deepin-wine sh -c '/opt/deepinwine/apps/Deepin-WeChat/run.sh ; sleep 5; while pgrep WeChat; do sleep 1; done'

#https://github.com/mviereck/dockerfile-x11docker-deepin/issues/20#issuecomment-725993250
x11docker --runasroot 'cat <<-EOF > /etc/sudoers
#$ sudo grep -Ev '\''^[ ]*(#|$)'\'' /etc/sudoers  
Defaults	env_reset
Defaults	mail_badpass
Defaults	secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
root	ALL=(ALL:ALL) ALL
%admin ALL=(ALL) ALL
%sudo	ALL=(ALL:ALL) ALL

$USER ALL=(ALL) NOPASSWD:ALL
EOF' --share=$x11docker_share --sudouser -c --hostdisplay --init=systemd -- --cap-add=ALL --security-opt seccomp=unconfined -- hongyi-zhao/deepin-wine sh -c '/opt/deepinwine/apps/Deepin-WeChat/run.sh; sleep 5; while pgrep WeChat; do sleep 1; done'







