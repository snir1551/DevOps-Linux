#!/bin/bash

SSH_USER_HOST="$1"
KEY_FILE="Linux-VM01_key.pem"
LOCAL_DIR="./downloaded_logs"
REPORT_FILE="remote_report.txt"
CSV_FILE="remote_report.csv"
YELLOW="\033[1;33m"
NC="\033[0m"

# === Display help message ===
print_help() {
    echo ""
    echo "Usage:"
    echo "  $0 user@host [--all] [--email]"
    echo ""
    echo "Options:"
    echo "  --all        Download all logs, not just those modified in the last 24 hours"
    echo "  --email      Automatically send the final report to your email (will prompt for address)"
    echo "  --help       Show this help message and exit"
    echo ""
    echo "Examples:"
    echo "  # Download only logs from the last 24 hours (default)"
    echo "  $0 snir1551@20.217.201.167"
    echo ""
    echo "  # Download all logs and send report via email"
    echo "  $0 snir1551@20.217.201.167 --all --email"
    echo ""
    exit 0
}

# === Parse command-line arguments ===
parse_arguments() {
	if [[ "$1" == "--help" || $# -eq 0 ]]; then
		print_help
	fi
	
	SSH_USER_HOST="$1"
	shift
	
	while [[ $# -gt 0 ]]; do
		case "$1" in
			--all)
				INCLUDE_ALL=true
				shift
				;;
			--email)
				SEND_EMAIL=true
				shift
				;;
			*)
				echo "Unknown option: $1"
				print_help
				;;
		esac
    	done
}

# === Validate required inputs and files ===
validate_input() {
	if [[ -z "$SSH_USER_HOST" ]]; then
		echo "Missing SSH user@host."
        	exit 1
    	fi

    	if [ ! -f "$KEY_FILE" ]; then
        	echo "Missing SSH key file: $KEY_FILE"
        	exit 1
    	fi

    	if [ ! -f "./advanced_log_report.sh" ]; then
        	echo "Missing script: advanced_log_report.sh"
        	exit 1
    	fi
}

# === Download logs from the remote server ===
download_logs() {

	read -p "Enter the remote log directory path: " REMOTE_LOG_DIR

    	mkdir -p "$LOCAL_DIR"

    	if $INCLUDE_ALL; then
        	echo "Downloading ALL logs from $SSH_USER_HOST:$REMOTE_LOG_DIR..."
        	scp -i "$KEY_FILE" -r "$SSH_USER_HOST:$REMOTE_LOG_DIR"/* "$LOCAL_DIR/" || {
            	echo "Failed to download logs."
            	exit 1
        }
    	else
                echo "Downloading ONLY logs modified in the last 24 hours..."

                ssh -i "$KEY_FILE" "$SSH_USER_HOST" "find $REMOTE_LOG_DIR -type f -mtime -1" > recent_logs.txt

                while read -r file; do
                [ -n "$file" ] && scp -i "$KEY_FILE" "$SSH_USER_HOST:$file" "$LOCAL_DIR/"
                done < recent_logs.txt

                rm -f recent_logs.txt
        fi
}

# === Extract .zip/.tar/.tar.gz archives ===
extract_archives() {
	echo "Extracting archives..."

    
    	find "$LOCAL_DIR" -name "*.zip" | while read -r zipfile; do
        	zipdir=$(dirname "$zipfile")
        	unzip -o "$zipfile" -d "$zipdir"
    	done

    
    	find "$LOCAL_DIR" -name "*.tar.gz" | while read -r tgzfile; do
        	tgzdir=$(dirname "$tgzfile")
        	tar -xzf "$tgzfile" -C "$tgzdir"
    	done

    	
    	find "$LOCAL_DIR" -name "*.tar" | while read -r tarfile; do
        	tardir=$(dirname "$tarfile")
        	tar -xf "$tarfile" -C "$tardir"
    	done
}

# === Run local analysis using advanced_log_report.sh ===
run_analysis() {
    	chmod +x ./advanced_log_report.sh
 	LOG_DIR="$LOCAL_DIR" \
    	./advanced_log_report.sh --interactive 
}

# === Rename report files and add metadata ===
finalize_report() {
    mv report.txt remote_report.txt
    mv report.csv remote_report.csv
    sed -i "1iRemote Server: $SSH_USER_HOST\nAnalyzed Directory: $REMOTE_LOG_DIR\n" remote_report.txt

}

# === Optionally send email with the report ===
send_email() {
    read -p "Would you like to send the report via email? (yes/no): " ANSWER

    if [[ "$ANSWER" == "yes" ]]; then
        read -p "Enter your email address: " TO
        SUBJECT="Remote Log Report from $SSH_USER_HOST"

        if [ -f "$REPORT_FILE" ]; then
            mail -s "$SUBJECT" "$TO" < "$REPORT_FILE"
            echo "Email sent to $TO with full report."
        else
            echo "Report file not found: $REPORT_FILE"
        fi
    else
        echo "Skipped email sending."
    fi
}

# === Main function that executes the full flow ===
remote_log_analyzer() {
    parse_arguments "$@"
    validate_input

    START=$(date +%s.%N)

    download_logs
    extract_archives
    run_analysis
    finalize_report
    send_email
    END=$(date +%s.%N)
    RUNTIME=$(echo "$END - $START" | bc | awk '{ printf "%.3f", $0 }')

    echo ""
    echo "Done. Total Execution Time: $RUNTIME seconds"
    echo "Report: $REPORT_FILE"
    echo "CSV: $CSV_FILE"
}

remote_log_analyzer "$@"
