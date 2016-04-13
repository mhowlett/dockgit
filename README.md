
# dockgit

A remote git server docker image.

Instructions:

 1. Clone this git repo on the computer you would like to set up as a remote git server:

```bash
 git clone https://github.com/mhowlett/dockgit.git
```

 2. Create an authorized_keys file by concatenating any number of public keys together:

```bash
 cd dockgit
 cat ~/.ssh/id_rsa.pub >> authorized_keys
 cat [some other public key] >> authorized_keys
 ...
```

 3. Build the docker image with:

```bash
 docker build -t dockgit .
```

 4. Create a data directory 

```bash
 mkdir /data
```

 note that the folder /data/dockgit/repos will be created when you bring the container up.
 
 5. bring up the container:

```bash
 ./docker-up.sh
```

 6. to make new repo:

log in as git:

```bash
  ssh -p 2332 git@localhost
  cd /repos
  mkdir example.git
  cd example.git
  git --bare init
```

 7. to push to the new repo:

on your local machine:

```bash
  mkdir example
  cd example
  git init
  touch README
  git add README
  git commit -m 'first commit'
  git remote add origin ssh://git@<server>:2332/repos/example.git
  git push origin master
```

to clone an existing repo:

```bash
  git clone ssh://git@globalonset.com:2332/repos/example.git
```

