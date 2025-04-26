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
- Commit the changes with a suitable commit message.

## Exercise 2: Adding and committing files

- Create a folder called `git` in your course folder `/project/<sso>`.
- Clone your new GitHub repository into this folder.
- Copy your downloads.txt file to this folder.
- Check the status od the repository.
- Add the downloads.txt file to the staging area.
- Commit the changes with a suitable commit message.

## Exercise 3: Pushing and Pulling

- Check the remote repository for your local repository.
- Push your local changes to to GitHub.
- Edit the downloads.txt file on GitHub.
- Pull your changes from GitHub.

## Exercise 4: Viewing version history

- Use `git log`.
- View log on GitHub.

## Optional Exercise 5: Branching

- Create a new branch and switch to it.
- List the branches in your repository.
- Edit a file, add the changes to the staging area, and commit (with a message!).
- Switch back to the main branch of your repository.
- Merge the new branch with your main branch.
- Inspect the history of your repository to visualise the recent branching and merging events.
