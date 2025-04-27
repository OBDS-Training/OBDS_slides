## Cheatsheet: git

### How to read this cheatsheet

Words in CAPITAL LETTERS are placeholders, replace them with values appropriate to your case. 

## One-time setup

### Git configuration

Once per user per computer.

```bash
git config --global user.name "NAME"
git config --global user.email EMAIL
```

Note:

- Quotation marks are crucial for values that contain space characters (typically your name).

### Creating a repository

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
# set the working directory to the parent directory in which you want your repository to be created:
cd /path/to/parent/directory
# clone the repository from GitHub:
git clone git@github.com:USER/REPOSITORY.git
```

## Daily routine

### Status

The status of you repository may highlight untracked files, changes to be committed, etc.

```bash
git status
```

### Tracking changes

Add files to the staging area after editing them to record their changes in the next commit.

```bash
git add FILE
```

### Recording changes

Commit the changes in the staging area to record them in the repository.
This automatically clears the staging area, ready for the next set of changes.

```bash
git commit -m "MESSAGE"
```

### Pull remote changes

Bring in any change that is recorded in the remote copy of your repository (i.e. on GitHub) which your local copy may be missing.

```bash
git pull
```

### Push changes remotely

Send changes you have made locally to the remote copy of your repository (i.e. on GitHub).

```bash
git push
```

### Putting it all together

```bash
git pull
# ... edit files, i.e. do you work ...
git add FILE1 FILE2 ...
git commit -m "MESSAGE"
git push
```

## Extras

Display the history of commits.

```bash
# verbose
git log
# summarise each commit in a single line
git log --oneline
```

List remote repositories configured for this local repository.

```bash
git remote
git remote -v
```

Create a new commit that reverses changes made in a given commit.

```bash
git revert COMMIT
```

Delete commits after a given commit (DESTRUCTIVE ACTION!)

```bash
# destroy all changes after that commit
git reset --hard COMMIT
# destroy following commits but keep files in their current state
git reset --soft COMMIT
```
