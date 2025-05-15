#!/bin/bash

# ===========================
#  Main Menu Function
# ===========================

function MenuFunctions() {

	while true; do
	
		echo "====MENU==="
		echo "1) Hello DevOps Script"
		echo "2) File & Directory Checker"
		echo "3) List Files with Sizes"
		echo "4) Search for ERROR Logs (in access.log file)"
		echo "5) AWK Column Extractor"
	        echo "press 'q' to exit"

		read -p "Enter number (1,5): " num

		case "$num" in
			1)
				PrintHelloDevops
				;;
			2)
				read -p "Enter filename or directory name: " filename
				FileDirectoryChecker $filename
				;;
			3)
				ListFilesSize
				;;
			4)
                                SearchErrors
                                ;;
			5)
				read -p "Enter your csv filename: " filename 
				ColumnExtractor $filename
				;;
			q)
				break
				;;
			*)
				echo "Invalid input"
				;;

		esac
	done
}

# ===========================
#  Option 1 – Print Hello
# ===========================

function PrintHelloDevops() {
	echo "Hello DevOps"
}

# ===========================
#  Option 2 – Check File or Directory
# ===========================

function FileDirectoryChecker() {

	filename="$1"
PrintHelloDevops
	if [ -z $filename ]; then
		echo "Please provide a filename"
		return 1
	fi


	if [ -f $filename ]; then
		echo "$filename is a file"
	elif [ -d $filename ]; then
		echo "$filename is a directory"
	else
		echo "$filename does not exist"
	fi

}

# ===========================
#  Option 3 – List Files with Sizes
# ===========================

function ListFilesSize() {
	printf "%-30s %10s\n" "Filename" "Size (KB)"
	printf "%-30s %10s\n" "--------" "---------"
	
	ls -l | grep '^-' | awk '{ print $9  }' | xargs du -k | awk '{ printf "%-30s %10s\n", $2, $1 }'
	
}

# ===========================
#  Option 4 – Search for ERROR Logs
# ===========================

function SearchErrors() {
	grep -n "ERROR" access.log
	echo ""
	echo "Total ERRORS: $(grep -o "ERROR" access.log | wc -l)"
}

# ===========================
#  Option 5 – AWK Column Extractor
# ===========================

function ColumnExtractor() {
	awk -F ',' '{ print $2 }' $1
}


MenuFunctions
