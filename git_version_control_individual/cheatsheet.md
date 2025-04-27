## Cheatsheet: git

### How to read this cheatsheet

Word in CAPITAL LETTERS are placeholders, replace them with values appropriate to your case. 

## One-time setup

### Git configuration

Once per user per computer.

```bash
git config --global user.name "FIRST LAST"
git config --global user.email EMAIL
```

### Initialise a repository

From an existing local directory:

```bash
# set the working directory to your local repository:
cd /path/to/directory
# initialise a git repository in that directory:
git init
# optionally, add link to remote:
# Note: the repository must be manually created on GitHub!
git remote add origin git@github.com:USER/REPOSITORY.git
```

From a GitHub repository:

```bash
# set the working directory to the parent directory where your repository will be created:
cd /path/to/parent/directory
# clone the (existing!) repository from GitHub:
git clone git@github.com:USER/REPOSITORY.git
```

## Daily routine

### Working with remotes

```bash
# pull any remote update:
git pull
# ... edit files, i.e. do you work ...
# add the files to the staging area for the next commit:
git add FILE1 FILE2 ...
# commit the contents of the staging area:
git commit -m "MESSAGE"
# push the commit(s) remotely (usually GitHub)
git push
```
