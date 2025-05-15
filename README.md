# DevOps-Linux
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
<summary>Week 2 Task – Log Analysis Report Generator</summary>
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


### 🧠 Simple Command Explanations

Each command below was used in the log report script. Here’s what it does — in simple terms:

| Command | Description |
|--------|-------------|
| `#!/bin/bash` | Declares that the script is written for the Bash shell. |
| `read -p "..." VAR` | Asks the user a question and saves the input to `VAR`. |
| `read -a ARRAY` | Reads multiple words (space-separated) into an array. |
| `KEYWORDS=()` | Initializes an empty array called `KEYWORDS`. |
| `if [ ! -d "$LOG_DIR" ]` | Checks if the directory in `LOG_DIR` does **not** exist. |
| `${#ARRAY[@]}` | Returns the number of elements in an array. |
| `exit 1` | Stops the script with an error status (non-zero). |
| `echo "text"` | Prints text to the screen or appends to a file. |
| `grep -o "word" file` | Finds every match of `"word"` in `file`, one per line. |
| `wc -l` | Counts how many lines are in the input (used to count matches). |
| `>>` | Appends output to a file (without deleting its content). |
| `>` | Overwrites a file with new content (clears existing content). |
| `find DIR -type f -name "*.log"` | Finds all `.log` files inside `DIR` (recursively). |
| `while read -r file; do ... done` | Loops over each file found by `find`. |
| `date +%s` | Returns the current time in seconds (used for timing). |
| `date +"%Y-%m-%d %H:%M:%S.%3N"` | Prints full date & time with milliseconds. |
| `$(( expression ))` | Performs math (e.g., subtracting start time from end time). |
| `function name() { ... }` | Defines a reusable block of code (function). |
| `"$@"` | Represents **all arguments** passed to the script. |
| `case "$1" in ...)` | Used to handle flags like `--help`, `--logdir`, etc. |


## 🧪 Example Usages

### Non-interactive:

bash
./advanced_log_report.sh --keywords ERROR WARNING CRITICAL --logdir your_directory_name

