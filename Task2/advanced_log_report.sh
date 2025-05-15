#!/bin/bash

KEYWORDS=(ERROR WARNING CRITICAL)
LOG_DIR=""
CSV_REPORT_FILE="report.csv"
REPORT_FILE="report.txt"
IS_INTERACTIVE=false

function count_keywords() {

	local file="$1"
	echo "Log File: $file" >> "$REPORT_FILE"
	printf "%-10s | %-10s\n" "Keyword" "Occurrences" >> "$REPORT_FILE"
	echo "------------------------" >> "$REPORT_FILE"
	echo "File,Keyword,Occurrences" >> "$CSV_REPORT_FILE"

	for keyword in "${KEYWORDS[@]}"; do
		count=$(grep -o "$keyword" "$file" | wc -l)
		printf "%-10s | %-10d\n" "$keyword" "$count" >> "$REPORT_FILE"
		echo "$file,$keyword,$count" >> "$CSV_REPORT_FILE"
    	done

    	echo "" >> "$REPORT_FILE"
}

function print_help() {

	echo "Usage:"
	echo "  $0 --keywords <KEY1> <KEY2> ... --logdir <log_directory>"
	echo ""
	echo "Options:"
	printf "  %-15s %s\n" "--keywords" "List of keywords to count in log files."
	printf "  %-15s %s\n" "--logdir"   "Directory containing .log files to analyze."
	printf "  %-15s %s\n" "--help"     "Show this help message and exit."
	printf "  %-15s %s\n" "--interactive"     "Ask for inputs step-by-step instead of using command-line flags."

	echo ""
	echo "Example:"
	echo "  $0 --keywords ERROR WARNING CRITICAL --logdir /log_directory"
	echo ""
	exit 0
}

function validate_input() {

	if [ ! -d "$LOG_DIR" ]; then
		echo "Error: '$LOG_DIR' is not a valid directory."
		exit 1
	fi

    	if [ ${#KEYWORDS[@]} -eq 0 ]; then
        	echo "Error: No keywords provided. Use --keywords ERROR WARN ..."
        	exit 1
    	fi
}

function generate_report() {

	echo "LOG REPORT" > "$REPORT_FILE"
    	echo "Directory: $LOG_DIR" >> "$REPORT_FILE"
    	echo "Keywords: ${KEYWORDS[*]}" >> "$REPORT_FILE"
    	echo "Generated at: $(date)" >> "$REPORT_FILE"
    	echo "" >> "$REPORT_FILE"

    	find "$LOG_DIR" -type f -name "*.log" | while read -r file; do
        	count_keywords "$file"
    	done
}


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


function prompt_for_inputs() {
	echo ""
    	read -p "Enter log directory path: " LOG_DIR

    	echo ""
    	echo "Enter keywords to search for (separated by space):"
    	read -a KEYWORDS

    	echo ""
}


function AdvancedLogReportAutomation() {
	START_TIME=$(date +%s.%N)

	parse_arguments $@

	if [ "$IS_INTERACTIVE" = true ]; then
        	prompt_for_inputs
    	fi

	validate_input
	generate_report

	END_TIME=$(date +%s.%N)
  	RUNTIME=$(echo "$END_TIME - $START_TIME" | bc) 
    	printf "Total Execution Time: %.3fs\n" "$RUNTIME" >> "$REPORT_FILE"    
}

AdvancedLogReportAutomation $@


