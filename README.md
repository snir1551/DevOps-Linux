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

project-folder/
├── remote_log_analyzer.sh
├── advanced_log_report.sh
├── Linux-VM01_key.pem
├── README.md
└── downloaded_logs/
    ├── *.log
    ├── *.zip
    └── *.tar.gz

🧠 Skills Demonstrated

- SSH key-based access and file transfers (scp, ssh)

- Conditional logic for date-based filtering using mtime -1

- File extraction automation

- Modular scripting and function reuse

- Email automation using mail and msmtp

- Real-time prompting and error handling

</details>



