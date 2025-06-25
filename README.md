# DevOps-Linux

<br />
<details>
    
<summary>Study</summary>
<br />

<details> 
<summary>Theory</summary>
<br />


<details> 
<summary>What is DevOps & Agile methodology</summary>

[DevOps & Agile methodology](https://github.com/snir1551/DevOps-Linux/wiki/What-is-DevOps-and-Agile-methodology)

</details>

----------------------------------------------------------------------------------------------------------------------------

<details>
<summary>The Hierarchical Tree Structure in Linux File System</summary>
	
[The Hierarchical Tree Structure in Linux File System](https://github.com/snir1551/DevOps-Linux/wiki/The-Hierarchical-Tree-Structure-in-Linux-File-System)

</details>

----------------------------------------------------------------------------------------------------------------------------

<details> 
<summary>inode in Linux</summary>

[inode in Linux](https://github.com/snir1551/DevOps-Linux/wiki/inode-in-Linux)

</details>	


----------------------------------------------------------------------------------------------------------------------------


<details> 
<summary>File Permissions in Linux</summary>

[File Permissions in Linux](https://github.com/snir1551/DevOps-Linux/wiki/File-Permissions-in-Linux)

</details>

----------------------------------------------------------------------------------------------------------------------------

<details> 
<summary>Special Permissions in Linux</summary>

[Special Permissions in Linux](https://github.com/snir1551/DevOps-Linux/wiki/Special-Permissions-in-Linux)

</details>

----------------------------------------------------------------------------------------------------------------------------

</details>
<details> 
<summary>Linux Commands</summary>

[Linux Commands](https://github.com/snir1551/DevOps-Linux/wiki/Linux-Commands)

</details>

----------------------------------------------------------------------------------------------------------------------------

</details>


<details>
<summary>Tasks</summary>
<br />

<details>
<summary>Week 1 Tasks – Intro to DevOps & Linux</summary>
<br />

## 1. Basic Linux Commands

```bash
# Basic commands to Navigate and manage directories

pwd                   # Print current directory
ls                    # List contents of the directory
mkdir devops_test     # Create new directory
cd devops_test        # Change to that directory
touch testfile.txt    # Create a test file
rm testfile.txt       # Delete the test file
cd ..                 # Go back one directory (can also do cd ../../ and etc)
rm -r devops_test     # Delete the directory
```

## 2. Create Users and Assign to Custom Group

```bash
# Create a new group
sudo groupadd devopsteam

# Create users and assign them to the group
sudo useradd -m -G devopsteam user1
sudo useradd -m -G devopsteam user2

# Verify group membership
groups user1
groups user2
```


## 3. Change File and Directory Permissions

```bash
# Create a directory and a file
mkdir /tmp/secure_folder
touch /tmp/secure_folder/groupfile.txt

# Change ownership to a user and group
sudo chown user1:devopsteam /tmp/secure_folder/groupfile.txt

# Change permissions to allow group read/write
sudo chmod 660 /tmp/secure_folder/groupfile.txt

# Verify permissions
ls -l /tmp/secure_folder/groupfile.txt
```

</details>

******


<details>
<summary>Week 1 Summary Task – DevOps & Linux Basics</summary>
<br />

## Part 1: Creating Directory Structure & Permissions

```bash
# Create base project directory in user's home directory
mkdir -p ~/project1/docs ~/project1/scripts

# Set permissions
chmod 744 ~/project1/scripts  # Owner: rwx, Group/Others: r--
chmod 777 ~/project1/docs     # Everyone: rwx (write access for all users)
```

## Part 2: User & Group Management

```bash
# Create user and group
sudo groupadd devteam
sudo useradd -g devteam devuser

# Set 'project1' ownership to your user and give group read-only access
sudo chown $USER:devteam ~/project1
chmod 740 ~/project1  # Owner: rwx, Group: r--, Others: ---
```

## Part 3: Verification Commands

```bash
# Show final directory structure and permissions
ls -lR ~/project1

# Show group membership for devuser
groups devuser
```
Screenshot of the outcome:  
![alt text](./Task1/Task1.png)
## Command Explanations

- `mkdir -p`: Creates directories; `-p` ensures parent directories are made as needed.
- `chmod 744`: Sets file/directory permissions (`7`=rwx, `4`=r--).
- `chmod 777`: Gives full read/write/execute permissions to all.
- `groupadd`: Adds a new group to the system.
- `useradd -m -g`: Creates a user and assigns him to a primary group.
- `chown`: Changes ownership of a file or directory.
- `ls -lR`: Recursively lists directory contents with permissions.
- `groups`: Shows all groups a user belongs to.


</details>

******



<details>
<summary>Week 2 Task – Advanced Log Report Automation</summary>
<br />

## 🧠 Task Overview

Develop a Bash script that:

- Accepts a log directory path
- Accepts one or more keywords to search for
- Counts keyword occurrences in .log files
- Generates reports in both .txt and .csv formats
- Supports both interactive and argument-based usage

---


### ✅ CLI Options

| Flag           | Description                                                  |
|----------------|--------------------------------------------------------------|
| --keywords     | Space-separated list of keywords to search in .log files     |
| --logdir       | Directory containing the log files                           |
| --interactive  | Run in interactive mode (ask for directory & keywords)       |
| --help         | Show help message                                            |

### 📄 Output

- report.txt – Human-readable report in tabular format
- report.csv – CSV file for spreadsheet or script integration

---


### 🐚 Bash Script Commands Reference

This document provides a categorized reference of Bash commands, operators, and syntax elements used in the script.

---

#### 🧠 General Bash Concepts

| Command | Description |
|--------|-------------|
| `#!/bin/bash` | Declares that the script is written for the Bash shell. |
| `function name() { ... }` | Defines a reusable block of code (function). |
| `local file` | Declares a local variable named `file` that is only accessible within the current function. |
| `exit 1` | Stops the script with an error status (non-zero). |

---

#### 📥 Arguments and Parameters

| Command | Description |
|--------|-------------|
| `$0` | Represents the name of the script or function being executed. |
| `$1` | Refers to the first positional argument passed to the script or function. |
| `$#` | Represents the number of positional arguments passed to a script or function. |
| `"$@"` | Represents **all arguments** passed to the script. |

---

#### 🔁 Loops and Conditions

| Command | Description |
|--------|-------------|
| `if [ condition ]; then ... fi` | Basic conditional structure used to execute code based on a condition. |
| `while read -r file; do ... done` | Loops over each line or file passed through the pipe safely. |
| `for var in list; do ... done` | Loops over each item in a list or array and performs commands for each. |
| `case "$1" in ...)` | Used to handle multiple options or flags like `--help`, `--logdir`, etc. |
| `if [ ! -d "$LOG_DIR" ]` | Checks if the directory in `LOG_DIR` does **not** exist. |

---

#### 🧮 Arithmetic Operators

| Command | Description |
|--------|-------------|
| `-eq` | Returns true if two numbers are equal. |
| `-ne` | Returns true if two numbers are not equal. |
| `-gt` | Returns true if the first number is greater than the second. |
| `-lt` | Returns true if the first number is less than the second. |
| `-ge` | Returns true if the first number is greater than or equal to the second. |
| `-le` | Returns true if the first number is less than or equal to the second. |
| `$(( expression ))` | Performs arithmetic operations like addition, subtraction, etc. |

---

#### 📋 Variables and Arrays

| Command | Description |
|--------|-------------|
| `KEYWORDS=()` | Initializes an empty array called `KEYWORDS`. |
| `KEYWORDS=(ERROR WARNING CRITICAL)` | Declares an array with values. |
| `KEYWORDS[@]` | Expands to all elements of the array (each element quoted separately). |
| `KEYWORDS[*]` | Expands to all elements as a single word (joined by IFS). |
| `${#ARRAY[@]}` | Returns the number of elements in an array. |

---

#### ⌨️ Input

| Command | Description |
|--------|-------------|
| `read -p "..." VAR` | Prompts the user for input and stores it in `VAR`. |
| `read -a ARRAY` | Reads multiple words into an array. |

---

#### 🖨️ Output and Formatting

| Command | Description |
|--------|-------------|
| `echo` / `echo "text"` | Prints text or variables to the terminal. |
| `printf` | Formats and prints text with fine control (padding, precision, etc.). |
| `%-10s` | A `printf` format specifier: left-aligns string in a 10-character width. |

---

#### 📁 Files and Redirection

| Command | Description |
|--------|-------------|
| `>` | Overwrites a file with new content. |
| `>>` | Appends output to a file without overwriting. |

---

#### 🔍 File Searching & Reading

| Command | Description |
|--------|-------------|
| `find` | Searches files and directories recursively. |
| `find DIR -type f -name "*.log"` | Finds all `.log` files inside `DIR` and its subdirectories. |

---

#### 🔎 Text Processing

| Command | Description |
|--------|-------------|
| `grep -o` | Prints only the matched parts of each line. |
| `grep -o "word" file` | Finds and prints each match of `"word"` in the file, one per line. |
| `wc -l` | Counts the number of lines in input. Often used to count matches. |
| `sed` | A stream editor used to perform basic text transformations on input. Example: `sed 's/old/new/'` replaces the first occurrence of `old` with `new`. |
| `awk` | A powerful text-processing tool. Example: `awk '{ print $1 }'` prints the first word of each line. |

---

#### ⏱️ Time & Date

| Command | Description |
|--------|-------------|
| `date` | Displays the current date and time. |
| `date +%s` | Returns the current time in seconds since epoch (used for timing). |
| `date +%s.%N` | Returns time in seconds with nanosecond precision. |
| `date +"%Y-%m-%d %H:%M:%S.%3N"` | Prints the full date and time with milliseconds. |


</details>

---


<details>
<summary>Week 3 Task – Remote Log Monitoring with SSH & VM</summary>
<br />

## 🧠 Task Overview

Create a modular Bash script that:

- Connects to a remote Linux VM over SSH using a `.pem` key
- Downloads `.log` files (either all, or only those modified in the last 24 hours)
- Automatically extracts `.zip`, `.tar`, or `.tar.gz` files
- Passes logs to a secondary script (`advanced_log_report.sh`) for keyword analysis
- Generates `remote_report.txt` and `remote_report.csv`
- Adds metadata (remote server, path) to the report
- Optionally sends the report to your email

---

## ✅ CLI Options

| Flag       | Description                                                                 |
|------------|-----------------------------------------------------------------------------|
| `--all`    | Download all logs, not just recent ones                                     |
| `--email`  | Automatically prompt for email address and send the report after analysis   |
| `--help`   | Display the help message and exit                                           |

---

## 🧪 Sample Execution

```
# Basic usage: downloads recent logs, prompts interactively
./remote_log_analyzer.sh snir1551@20.217.201.167

# Download all logs from the directory
./remote_log_analyzer.sh snir1551@20.217.201.167 --all

# Download all logs and email the report automatically
./remote_log_analyzer.sh snir1551@20.217.201.167 --all --email

```

## 🧪 Example: Full Execution Output

```
$ ./remote_log_analyzer.sh snir1551@20.217.201.167

- Enter the remote log directory path: /home/snir1551/logs

Downloading ALL logs from snir1551@20.217.201.167:/home/snir1551/logs...
logs/app.log                           100%   14KB 140.5KB/s   00:00
logs/errors.zip                        100%   10KB 122.3KB/s   00:00

Extracting archives...
Archive extracted: logs/errors.zip → logs/errors/

- Using provided log directory: ./downloaded_logs

- Enter keywords to search for (separated by space): ERROR WARNING CRITICAL

LOG REPORT
Directory: ./downloaded_logs
Keywords: ERROR WARNING CRITICAL
Generated at: Thu May 22 04:43:11 IDT 2025

Log File: app.log
Keyword     | Occurrences
-------------------------
ERROR       | 14
WARNING     | 3
CRITICAL    | 0

Report generated successfully!

- Would you like to send the report via email? (yes/no): yes
Enter your email address: snir@example.com
📧 Email sent to snir@example.com with full report.

✅ Done. Total Execution Time: 5.284 seconds
📝 Report: remote_report.txt
📊 CSV: remote_report.csv

```

## 📂 Generated Output Example

📄 Output

| File                | Description                                  |
| ------------------- | -------------------------------------------- |
| `remote_report.txt` | Human-readable summary with metadata         |
| `remote_report.csv` | Structured CSV format for Excel or scripting |


```
remote_report.txt:

Remote Server: snir1551@20.217.201.167
Analyzed Directory: /home/snir1551/logs

LOG REPORT
Directory: ./downloaded_logs
Keywords: ERROR WARNING CRITICAL
Generated at: Thu May 22 04:43:11 IDT 2025

Log File: app.log
Keyword     | Occurrences
-------------------------
ERROR       | 14
WARNING     | 3
CRITICAL    | 0

...
```

```
remote_report.csv:

File,Keyword,Occurrences
app.log,ERROR,14
app.log,WARNING,3
app.log,CRITICAL,0
...


```

## 🧪 What This Demonstrates
✅ SSH download using .pem key

✅ Download of full log directory (--all)

✅ Extraction of .zip archive

✅ Interactive keyword input (unless passed as environment variable)

✅ Report generation in .txt and .csv

✅ Automatic email sending (--email flag)


📁 Project Structure
```
project-folder/
├── remote_log_analyzer.sh
├── advanced_log_report.sh
├── Linux-VM01_key.pem
├── README.md
└── downloaded_logs/
    ├── *.log
    ├── *.zip
    └── *.tar.gz
```

🧠 Skills Demonstrated

- SSH key-based access and file transfers (scp, ssh)

- Conditional logic for date-based filtering using mtime -1

- File extraction automation

- Modular scripting and function reuse

- Email automation using mail and msmtp

- Real-time prompting and error handling

</details>

******

<details>
<summary>Week 4 Task – Daily Practice Tasks</summary>
<br />

## Task 1: Branching & Switching

Steps:

- Create a new local Git repository:

```
mkdir my-git-project
cd my-git-project
git init
```

- Create main branch:

```
git branch -M main
echo "Initial content" > README.md
git add README.md
git commit -m "Initial commit"
```

- Create two branches:

```
git branch feature-a
git branch feature-b
```

- show the branches that you have:

```
git branch
```
you need see: main, feature-a, feature-b

- Switch between branches:

```
git switch feature-a
git switch feature-b
```

- Add a simple change and commit it in each branch:

In feature-a:
```
git switch feature-a
echo "Hello from feature-a" > greetings.txt
git add greetings.txt
git commit -m "Add greetings.txt in feature-a"
```

In feature-b:
```
git switch feature-b
echo "Hello from feature-b" > greetings.txt
git add greetings.txt
git commit -m "Add greetings.txt in feature-b"
```


## Task 2: Simulate and Resolve Merge Conflicts

- Modify the same line in a file on both feature-a and feature-b

```
git switch feature-a
echo "Hello from feature-a" > greetings.txt
git add greetings.txt
git commit -m "Update greetings.txt in feature-a"
```

```
git switch feature-b
echo "Hello from feature-b" > greetings.txt
git add greetings.txt
git commit -m "Update greetings.txt in feature-b"
```

Now both branches have different changes in the same file (greetings.txt).

- Merge one branch into the other and observe the conflict

For example, merge feature-b into feature-a:

```
git switch feature-a
git merge feature-b
```

You will see a conflict like this:

```
Auto-merging greetings.txt
CONFLICT (add/add): Merge conflict in greetings.txt
Automatic merge failed; fix conflicts and then commit the result.
```

- Resolve the conflict using either command-line or VS Code

To view the conflict markers in the file, run:
```
cat greetings.txt
```

This will display something like:

![image](https://github.com/user-attachments/assets/ebf70b30-38f1-4efe-bc2e-3801f8c8572c)

To edit the file and resolve the conflict, open it with Vim:
```
vim greetings.txt
```
![image](https://github.com/user-attachments/assets/7f5b6b2d-4a18-4007-a9b0-c235a571a845)

After editing the file, the conflict is resolved like this:
![image](https://github.com/user-attachments/assets/8e9c7113-495f-44d5-a3d4-2d0b3f30413d)

after saved greetings.txt file

```
git add greetings.txt
git commit -m "merged feature-b into feature-a"
```


## Task 3: Rebase and Cherry-Pick

- Use git rebase to reapply commits from feature-a onto main

  view the graph of the commits, we want that will be linear
  ```
  git log --oneline --graph --all
  ```
  ![image](https://github.com/user-attachments/assets/61eb9f89-e6e6-49d4-9b8e-fa706549b775)


  Switch to feature-a:
  ```
  git switch feature-a
  ```
  Rebase onto main:
  ```
  git rebase main
  ```

- Document what happens to the commit history
  - Rebase moves the commits from feature-a and reapplies them on top of main.
  - The commits from feature-a get new commit hashes, because Git is creating new commits during the rebase.
  - The commit history becomes linear: It looks as if the feature-a changes were made after the latest commit on main.

- Use git cherry-pick to apply a single commit from feature-b to main

  First, find the commit hash in feature-b:
  ```
  git log feature-b --oneline
  ```

  Switch to main:
  ```
  git switch main
  ```

  Apply the commit:
  ```
  git cherry-pick yourcommit
  ```

- Explain the difference between rebase and merge in your own words

| Rebase                                                               | Merge                                                                 |
| -------------------------------------------------------------------- | --------------------------------------------------------------------- |
| Moves commits from one branch onto another, creating **new** commits | Combines changes from both branches into a new **merge commit**       |
| Creates a **linear** history (no merge commits)                      | Keeps the full **branching** history (shows splits and merges)        |
| Commit hashes change                                                 | Commit hashes stay the same                                           |
| Ideal for **cleaning up** a feature branch before merging            | Ideal for **combining work** from different branches                  |
| Can cause conflicts that need to be resolved per-commit              | Can cause conflicts but usually resolved all at once during the merge |

## Create a new GitHub repository & Set the remote in your local repository

- Go to https://github.com/new.
- Give your repository a name (e.g., MyProject).
- Keep it empty (do not add README, .gitignore, or license for now).
- git remote set-url origin git@github.com:your-username/your-repository.git

- Set the remote in your local repository
- In your local Git project folder, connect your local repository to the GitHub repository via SSH

## GitHub Pull Requests & Code Review

- Push both branches (feature-a, feature-b) to your GitHub repository

  Push feature-a:
  ```
  git push -u origin feature-a
  ```

  Push feature-b:
  ```
  git push -u origin feature-b
  ```

- Create a pull request from one branch into main
  - Go to your GitHub repository.
  - Click on the "Compare & pull request" button for feature-a (or feature-b).
  - Set the base branch to main and the compare branch to feature-a.
  - Click "Create pull request".
  - Add a meaningful title and description explaining your changes.
 
- Request a review from a classmate or mentor
  - On your pull request page, click "Reviewers" in the sidebar.
  - Select a classmate or mentor from the list to request their review.
 
- Write at least one constructive code comment in someone else's pull request
  - Go to a classmate’s pull request on GitHub.
  - Click on "Files changed".
  - Add a comment on a specific line of code (click the + icon).
  - Your comment should be constructive
 

## Task 5: Stash, Amend, and Cleanup

- Make local changes and store them using git stash

  Make a change to a file, for example:
  ```
  echo "Temporary changes" >> greetings.txt
  ```
  
  Check the change:
  ```
  git status
  ```

  Stash the changes:
  ```
  git stash
  ```

  our working directory is now clean again.
  You can view your stash with:

  git stash list

- Restore the changes using git stash pop
  
  To bring your stashed changes back:
  ```
  git stash pop
  ```
  
  This restores the latest stashed changes and removes them from the stash stack.

- Amend your last commit using git commit --amend

  Make a small additional change:
  ```
  echo "Fix bug and change commit" >> greetings.txt
  git add notes.txt
  ```
  
  Amend the last commit:
  ```
  git commit --amend
  ```

  You’ll enter your editor to modify the commit message (or keep it the same and save). <br />
  This replaces the last commit with a new one that includes the updated changes.
  
</details>


******

<details>
<summary>Week 4 Summary Task – GitHub Collaboration Simulation </summary>
<br />

## Overview

### https://github.com/snir1551/week4-collaboration

This repository demonstrates a real-world collaborative Git workflow with a focus on:
- Branching and feature development.
- Conflict simulation and resolution.
- Using `rebase` and `cherry-pick` .
- Clean commit history and code review.
- Automations: GitHub Actions for linting and logging (permission given through the Settings in github).


## Repository & Branch Setup
```bash
gh repo create week4-collaboration --public --source=. --remote=origin --push
# or via GitHub UI

git branch feature-a
git branch feature-b
```

## Simulate a Merge Conflict
Edit the same line in a shared file (e.g., main.py) on both feature-a and feature-b.
```bash
git checkout feature-a
nano main.py # and write the below, and then alt+o , enter , alt+x
print("Hello from feature-a")
git add main.py
git commit -m "update main.py from feature-a"
git push -u origin feature-a

git checkout feature-b
nano main.py # and write the below, and then alt+o , enter , alt+x
print("Hello from feature-b")
git add main.py
git commit -m "update main.py from feature-b"
git push -u origin feature-b
```

## Open PR on first branch 'feature-a' and Merge to main
```bash
gh pr create --base main --head feature-a --title "Merge feature-a" --body "Add feature-a changes"
```
- Snir assigned me as reviewer and used labels for PR.  
- PR Approved and merged to main.

## Rebase feature-b branch based on new main (after merged the feature-a)
```bash
git checkout main
git pull
git checkout feature-b
git rebase main
# Resolve conflicts if any, (for example we edited the main.py)
# and then we did `git rebase --continue` to continue.
git push
```

## Open PR on second branch 'feature-b' and Merge to main
```bash
gh pr create --base main --head feature-b --title "Merge feature-b" --body "Add feature-b changes"
```
Assigned Snir as reviewer and used labels for PR.  
PR Approved and merged to main.


## added third branch to simulate cherry-pick:
we used cherry-pick to get some 'bug fix' from a branch with multiple commits: git cherry-pick bffbf23
```bash
git checkout main
git log --oneline --graph --all # used to see all the commit hash's
git cherry-pick <commit-hash> # git cherry-pick bffbf23 
git push
```
- https://github.com/snir1551/week4-collaboration/commit/7af83de4809c3ea30554f017959b2a48ada57473


## git log graph
![alt text](images/gitLogGraph.png)

## Added `REFLECTION.md`:
- What was the most challenging Git concept this week?
	1. the most challenging concept was understanding the Rebase concept and when its best to use it and how exactly.


- What did you learn about collaboration? 
	1. we learned that we need to have good communication in order to not cause conflict by working on same files or branchs,
and also make the work faster and more efficient by allowing each of the collaborator to work on different feature.
	2. that we should create issue before creating a pull request.


- What mistakes did you make and how did you fix them? 
	1. we didnt pull the recent changes from main before trying to apply changes from new branchs, which made problems

	2. we accidently commited and pushed to the wrong branch, and we fixed it by using git reset --hard HEAD~1


</details>


******

<details>
<summary>Week 5 – Daily Practice Tasks (CI/CD with GitHub Actions)</summary>
<br />
https://github.com/snir1551/DevOps-Linux/wiki/Week-5-%E2%80%93-Daily-Practice-Tasks-(CI-CD-with-GitHub-Actions)
</details>

******

<details>
<summary>Week 5 – Summary Task: GitHub Actions and CI/CD</summary>
<br />
	
[week5-ci-cd](https://github.com/snir1551/week5-ci-cd/tree/dockercompose)

</details>

******

<details>
<summary>Week 6 – Docker & Containers: Daily Practice Tasks</summary>
<br />

https://github.com/snir1551/DevOps-Linux/wiki/Week-6-%E2%80%93-Docker-&-Containers:-Daily-Practice--Tasks

</details>

******

<details>
<summary>Week 6 – Summary Task: Docker & Containerization </summary>
<br />

[week6-Docker-Containerization](https://github.com/snir1551/week5-ci-cd/)

</details>

******

<details>
<summary>Week 7 – Daily Practice Tasks - Docker Compose & Azure + VM  </summary>
<br />

[week7-Docker Compose & Azure + VM](https://github.com/snir1551/DevOps-Linux/wiki/Week-7-%E2%80%93-Daily-Practice-Tasks-%E2%80%90-Docker-Compose-&-Azure---VM)

</details>

******

<details>
<summary>Week 7 Summary Task: Docker Compose & Azure + VM</summary>
<br />

[week7-Docker Compose & Azure + VM](https://github.com/Avichai98/Task7_Snir_Avichai)

</details>

******

<details>
<summary>WEEK 8 – Daily Practice Tasks: Azure Infrastructure</summary>
<br />

[week8-Azure Infrastructure](https://github.com/snir1551/DevOps-Linux/wiki/WEEK-8-%E2%80%93-Daily-Practice-Tasks:-Azure-Infrastructure)

</details>

******

<details>
<summary>WEEK 8 – Summary Task: Azure Infrastructure</summary>
<br />

[week8-Azure Infrastructure](https://github.com/snir1551/DevOps-Linux/wiki/WEEK-8-%E2%80%93-Summary-Task:-Azure-Infrastructure)

</details>

******

</details>


