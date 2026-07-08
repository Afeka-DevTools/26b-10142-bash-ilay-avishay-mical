# DevTools HW1 – Bash Scripts, Git & GitHub

## Team Members

| Name    | Scripts Written                                                             |
|---------|------------------------------------------------------------------------------|
| Eli     | backup_folder.sh, check_internet.sh, disk_usage_report.sh, show_uptime.sh, battery_status.sh |
| Avishai | generate_password.sh, countdown_timer.sh, ascii_clock.sh, reminder.sh, show_env_vars.sh |
| Mical   | count_lines_words_chars.sh, summarize_directory.sh, find_recent_files.sh, count_files_by_extension.sh, sort_file_lines.sh |

All scripts live in the `/scripts` folder at the root of this repository.

## Getting Started (for anyone running these scripts)

1. Clone the repository:
   ```bash
   git clone <repository-address>
   cd <repository-folder>
   ```
2. Give the scripts execute permission (only needs to be done once):
   ```bash
   chmod +x scripts/*.sh
   ```
3. Run any script as described below.

---

## Scripts by Eli

### `backup_folder.sh`
Backs up a folder into a timestamped `.tar.gz` archive.
```bash
./scripts/backup_folder.sh <folder_to_backup> [destination_folder]
```
- `folder_to_backup` (required): path to the folder to archive
- `destination_folder` (optional): where to save the archive, defaults to current directory

### `check_internet.sh`
Pings a reliable host to check internet connectivity and prints a timestamped log line.
```bash
./scripts/check_internet.sh [log_file]
```
- `log_file` (optional): also appends the result line to this file

### `disk_usage_report.sh`
Shows disk usage for each subfolder of a directory, largest first.
```bash
./scripts/disk_usage_report.sh [target_directory]
```
- `target_directory` (optional): defaults to current directory

### `show_uptime.sh`
Displays how long the system has been running.
```bash
./scripts/show_uptime.sh
```
- No input required

### `battery_status.sh`
Displays battery charge percentage and charging state.
```bash
./scripts/battery_status.sh
```
- No input required (prints a message if no battery is found, e.g. on a desktop/VM)

---

## Scripts by Avishai

### `generate_password.sh`
Generates a random 10-character password with at least one uppercase letter, one lowercase letter, one digit, and one symbol.
```bash
./scripts/generate_password.sh
```
- No input required

### `countdown_timer.sh`
Counts down from a given duration and announces when time is up.
```bash
./scripts/countdown_timer.sh <HH:MM:SS>
```
- `HH:MM:SS` (required): duration to count down from, e.g. `00:01:30`

### `ascii_clock.sh`
Displays a live, updating clock in large ASCII art (via `figlet`). Press `Ctrl+C` to stop.
```bash
./scripts/ascii_clock.sh
```
- No input required

### `reminder.sh`
Waits a given number of seconds, then displays a reminder message.
```bash
./scripts/reminder.sh <seconds> "<message>"
```
- `seconds` (required): how long to wait
- `message` (optional): reminder text, defaults to "Reminder!"

### `show_env_vars.sh`
Displays a curated list of important environment variables (USER, HOME, SHELL, PATH, etc.).
```bash
./scripts/show_env_vars.sh
```
- No input required

---

## Scripts by Mical

### `count_lines_words_chars.sh`
Counts lines, words, and characters for every file in a directory and prints a table.
```bash
./scripts/count_lines_words_chars.sh [target_directory]
```
- `target_directory` (optional): defaults to current directory

### `summarize_directory.sh`
Summarizes the number of files, subdirectories, and symlinks in a directory.
```bash
./scripts/summarize_directory.sh [target_directory]
```
- `target_directory` (optional): defaults to current directory

### `find_recent_files.sh`
Finds all files modified within the last N days.
```bash
./scripts/find_recent_files.sh <target_directory> <N>
```
- `target_directory` (required): directory to search recursively
- `N` (required): number of days

### `count_files_by_extension.sh`
Counts files by extension in a directory, sorted from most to least common.
```bash
./scripts/count_files_by_extension.sh [target_directory]
```
- `target_directory` (optional): defaults to current directory

### `sort_file_lines.sh`
Sorts the lines of a text file alphabetically.
```bash
./scripts/sort_file_lines.sh <input_file> [output_file]
```
- `input_file` (required): file whose lines should be sorted
- `output_file` (optional): if given, writes sorted output here instead of printing to screen
