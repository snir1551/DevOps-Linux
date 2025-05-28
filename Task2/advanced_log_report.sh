#!/bin/bash

KEYWORDS=(ERROR WARNING CRITICAL)
LOG_DIR=""
CSV_REPORT_FILE="report.csv"
REPORT_FILE="report.txt"
IS_INTERACTIVE=false
USE_COLOR=true

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
NC="\033[0m"



# ============================================
# count_keywords
# Parameters: $1 - Path to a log file
# Description: Counts occurrences of each keyword in a single log file.
#              Appends results to a human-readable report (.txt) and a CSV report.
# ============================================
function count_keywords() {

	local file="$1"
	echo "Log File: $file" | tee -a "$REPORT_FILE"
	printf "%-10s | %-10s\n" "Keyword" "Occurrences" | tee -a "$REPORT_FILE"
	echo "------------------------" | tee -a "$REPORT_FILE"
	echo "File,Keyword,Occurrences" >> "$CSV_REPORT_FILE"

	for keyword in "${KEYWORDS[@]}"; do
		count=$(grep -o "$keyword" "$file" | wc -l)
		printf "%-10s | %-10d\n" "$keyword" "$count" | tee -a "$REPORT_FILE"
		echo "$file,$keyword,$count" >> "$CSV_REPORT_FILE"
    	done

    	echo "" | tee -a "$REPORT_FILE"
}

# ============================================
# print_help
# Description: Prints usage instructions and CLI options for the script.
#              Called when --help is passed.
# ============================================
function print_help() {

	echo "Usage:"
	echo "  $0 --keywords <KEY1> <KEY2> ... --logdir <log_directory>"
	echo ""
	echo "Options:"
	printf "  %-15s %s\n" "--keywords" "List of keywords to count in log files."
	printf "  %-15s %s\n" "--logdir"   "Directory containing .log files to analyze."
	printf "  %-15s %s\n" "--help"     "Show this help message and exit."
	printf "  %-15s %s\n" "--interactive"     "Ask for inputs step-by-step instead of using command-line flags."
	printf "  %-15s %s\n" "--no-color" "Disable color output for cleaner logs or scripting."

	echo ""
	echo "Example:"
	echo "  $0 --keywords ERROR WARNING CRITICAL --logdir /log_directory"
	echo ""
	exit 0
}

# ============================================
# validate_input
# Description: Verifies that required inputs were provided:
#              - A valid directory path in LOG_DIR
#              - At least one keyword in KEYWORDS array
#              If not, prints an error and exits.
# ============================================
function validate_input() {

	if [ ! -d "$LOG_DIR" ]; then
		echo -e "${RED}Error:${NC} Invalid or missing log directory."
		echo -e "Use ${YELLOW}--help${NC} to see usage instructions."
		exit 1
	fi

    	if [ ${#KEYWORDS[@]} -eq 0 ]; then
		echo -e "${RED}Error:${NC} No keywords provided."
		echo -e "Use ${YELLOW}--help${NC} to see usage instructions."
        	exit 1
    	fi
}

# ============================================
# generate_report
# Description: Initializes the report files and processes each .log file
#              in the specified LOG_DIR by calling count_keywords.
# ============================================
function generate_report() {

	echo "LOG REPORT" | tee "$REPORT_FILE"
    	echo "Directory: $LOG_DIR" | tee -a "$REPORT_FILE"
    	echo "Keywords: ${KEYWORDS[*]}" | tee -a "$REPORT_FILE"
    	echo "Generated at: $(date)" | tee -a "$REPORT_FILE"
    	echo "" | tee -a "$REPORT_FILE"

    	find "$LOG_DIR" -type f -name "*.log" | while read -r file; do
        	count_keywords "$file"
    	done

	echo -e "${GREEN}Report generated successfully!${NC}"
}

# ============================================
# parse_arguments
# Description: Parses command-line arguments for:
#              --keywords, --logdir, --interactive, and --help.
#              Updates global variables accordingly.
# ============================================
function parse_arguments() {


	while [[ $# -gt 0 ]]; do
		case "$1" in 
			--keywords)
				shift
				while [[ $# -gt 0 && "$1" != --* ]]; do
					KEYWORDS+=("$1")
					shift
				done
                		;;
			--logdir)
                		shift
                		LOG_DIR="$1"
                		shift
                		;;
	    		--interactive)
                		IS_INTERACTIVE=true
                		shift
                		;;
			--no-color)
                		USE_COLOR=false
                		shift
                		;;
            		--help)
                		print_help
                		;;
            		*)
                		echo "Unknown option: $1"
                		echo "Use --help to see usage."
                		exit 1
                		;;
		esac
	done
}

# ============================================
# prompt_for_inputs
# Description: Prompts the user to enter log directory and keywords interactively.
#              Used when the --interactive flag is set.
# ============================================
function prompt_for_inputs() {
	echo ""
    	read -p "Enter log directory path: " LOG_DIR

    	echo ""
    	echo "Enter keywords to search for (separated by space):"
    	read -a KEYWORDS

    	echo ""
}

function setup_colors() {
    if [ "$USE_COLOR" = false ]; then
        RED=""
        GREEN=""
        YELLOW=""
        NC=""
    else
        RED="\033[0;31m"
        GREEN="\033[0;32m"
        YELLOW="\033[1;33m"
        NC="\033[0m"
    fi
}

# ============================================
# AdvancedLogReportAutomation
# Description: Main function.
#              - Starts timer
#              - Parses arguments
#              - Optionally prompts user
#              - Validates input
#              - Generates report
#              - Displays execution time
# ============================================
function AdvancedLogReportAutomation() {
	START_TIME=$(date +%s.%N)

	parse_arguments $@

	if [ "$IS_INTERACTIVE" = true ]; then
        	prompt_for_inputs
    	fi

	validate_input
	generate_report

	END_TIME=$(date +%s.%N)
  	RUNTIME=$(echo "$END_TIME - $START_TIME" | bc | awk '{ printf "%.3f", $0 }') 

	

    	printf "Total Execution Time: %.3f seconds\n" "$RUNTIME" | tee -a "$REPORT_FILE"   
}

AdvancedLogReportAutomation $@


