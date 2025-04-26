## Exercise 1: Setting up a repo on GitHub

- Create a GitHub account.

> Navigate to <https://github.com/>.
> 
> Click on the button 'Sign up'.
> 
> Fill the form.
> 
> NOTE: We recommend using your personal email address when signing up to ensure continuity between jobs.
> You can always add work emails to your account after it is created.
> Associating at least one academic email to your account qualifies you to apply for benefits via [GitHub Education](https://github.com/education).
> 
> Pick a unique username.
> 
> Click on the 'Continue' button and complete the process (e.g. verifying your email address) until you are logged in to your account.

- Create an SSH key on the cluster and upload it to your GitHub account.

> ```bash
> ssh-keygen -t ecdsa -b 521
> # we recommend setting a passphrase to protect your SSH key pair
> cat .ssh/id_ecdsa.pub
> ```
> 
> Copy the public key printed by the last command above.
> 
> Navigate to <https://github.com/settings/ssh/new>.
> 
> Paste the public key in the field 'Key'.
> 
> Copy the last portion of the key (that looks like `username@host`) in the field 'Title'.
> 
> Click the green button 'Add SSH key'.

- On GitHub, create a new repository called `obds_linux`.
  - In the form, tick the box to add a README file in this repository.
    This creates a markdown file `README.md` prefilled with some basic information about the repository.

> On the GitHub website, click on the `+` icon in the navigation bar at the top of the website.
>
> Click on 'New repository'.
>
> In the field 'Repository name', type `obds_linux`.
>
> Tick the check box that states "Add a README file".
>
> Click the green button 'Create repository'.

- Edit this `README.md` file to include the name and date of the course.

> The `README.md` file is automatically displayed on the main page of your repository on GitHub.
>
> Click on the pencil icon in the top right corner of the file view.
>
> Edit the file as needed.
>
> NOTE: A useful guide to the Markdown syntax is available [here](https://www.markdownguide.org/basic-syntax/).

- Commit the changes with a suitable commit message.

> Click the button 'Commit changes...'.
>
> In the pop-up window, replace the default commit message by something more appropriate.
>
> When ready, click the button 'Commit changes'.

## Exercise 2: Adding and committing files

- Create a folder called `git` in your course folder `/project/<sso>`.

> ```bash
> mkdir /project/$USER/git
> ```

- Clone your new GitHub repository into this folder.

> ```bash
> cd /project/$USER/git
> git clone git@github.com:USERNAME/obds_linux.git
> ```

- Copy your `downloads.txt` file to this folder.

> ```bash
> cd /project/$USER/git/obds_linux
> cp /PATH/TO/downloads.txt .
> ```

- Check the status od the repository.

> ```bash
> git status
> ```

- Add the `downloads.txt` file to the staging area.

> ```bash
> git add downloads.txt
> ```

- Commit the changes with a suitable commit message.

> ```bash
> git commit -m "add file downloads.txt"
> ```

## Exercise 3: Pushing and Pulling

- Check the list of remote repositories for your local repository.

> ``` bash
> git remote -v
> ```

- Push your local changes to to GitHub.

> ``` bash
> git push
> ```

- Edit the `downloads.txt` file on GitHub.

> Navigate to the file on GitHub.
>
> Click on the pencil icon in the top right corner of the file view.
>
> Edit the file as needed.
>
> Click the button 'Commit changes...'.
>
> In the pop-up window, replace the default commit message by something more appropriate.
>
> When ready, click the button 'Commit changes'. 

- Pull your changes from GitHub.

> ``` bash
> git pull
> ```

## Exercise 4: Viewing version history

- Use `git log`.

> ```bash
> git log
> git log --oneline
> git show COMMIT
> ```

- Navigate the repository history on GitHub.

> Towards the top of the web page, click on the 'Insights' tab.
>
> On the left of the web page, click on the 'Network' tab.
>
> Hover over the nodes in the timeline and wait to see tooltips appear.
>
> Click on the nodes in the timeline to view the changes in that commit.

## Optional Exercise 5: Branching

- Create a new branch and switch to it.

> ```bash
> git checkout -b BRANCH
> # OR
> git branch BRANCH
> git checkout BRANCH
> ```

- List the branches in your repository.

> ```bash
> git branch
> ```

- Edit a file, add the changes to the staging area, and commit (with a message!).

> ```bash
> nano FILE
> # edit as needed
> # Control-X
> # Y
> # Return
> git add FILE
> git commit -m "edited FILE"
> ```

- Merge the new branch into your main branch.

> ```bash
> git checkout main
> git merge BRANCH
> ```

- Inspect the history of your repository to visualise the recent branching and merging events.

> ```bash
> git log --oneline
> ```

- What should you do now? Why?

> You should push the merge commit to GitHub
> because the commit and the merge happened on the cluster
> and pushing to GitHub would backup your work in the cloud in case something happens to the cluster.
> 
> ```bash
> git push
> ```
