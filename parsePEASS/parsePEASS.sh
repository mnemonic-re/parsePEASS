#!/bin/bash

# -------------------------------------------------------------------
# sh = PEASS_ng Output file Parser and Converter
# v = 1.0
# id = malloc84 || mnemonic-re @ github
# -------------------------------------------------------------------

title="PEASS_ng Output file Converter (HTML, PDF, JSON)"
prompt="Select option: "

NO='\033[0m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'

echo "$title"
PS3="$prompt "

echo -e "Convert PEASS-ng (winpeas or linpeas) output file to HTML or PDF readable format"
echo ''
echo -e "${RED}DevNote: PDF conversion might have some issues with python reportlab library.${NO}"
echo ''
echo -e "Select the ${YELLOW}*.out ${NO}PEASS output file to process."
echo ''

files=$(ls *.out)
i=1
for j in $files
do
echo "$i.$j"
file[i]=$j
i=$(( i + 1 ))
done

echo ''
read -p "Select *.out file to process (number): " input 
echo -e "File to process: "${YELLOW}"${file[$input]}"${NO}""

echo ''
echo -e "${BLUE}Output file conversion options: ${NO}"
echo -e "${GREEN}1 - Convert ${YELLOW}"${file[$input]}" ${GREEN}file to readable HTML file."
echo -e "${GREEN}2 - Convert ${YELLOW}"${file[$input]}" ${GREEN}file to readable PDF file."
echo -e "${GREEN}3 - Convert ${YELLOW}"${file[$input]}" ${GREEN}file to parsable JSON file."
echo -e "${BLUE}4 - Restart Conversion script to process another file.${NO}"
echo -e "${RED}5 - Exit Conversion script.${NO}"
echo ''

options=("HTML" "PDF" "JSON" "RESTART" "EXIT")
select opt in "${options[@]}"
do
    case $opt in
        "HTML")
            echo -e "${GREEN}[+] Converting RAW output to readable HTML..."
            sleep 1
            echo -e "${GREEN}[+] RAW output to JSON..."
            python3 parsers/peas2json.py ${file[$input]} peass.json
            sleep 5
            echo -e "${GREEN}[+] JSON to HTML..."
            python3 parsers/json2html.py peass.json ${file[$input]}.html
            sleep 5
            if [[ ! -f ${file[$input]}.html ]]
            then
                echo -e "${RED}[-] Failed to convert to HTML!${NO}"
            fi
            rm peass.json
            if [[ -f ${file[$input]}.html ]]
            then
                echo -e "${GREEN}[+] Conversion to ${BLUE}HTML ${GREEN}Finished.${NO}"
                echo -e "${GREEN}[+] Created:"${YELLOW} ${file[$input]}.html"${NO}"
            fi
            ;;
        "PDF")
            echo -e "${GREEN}[+] Converting RAW output to readable PDF..."
            sleep 1
            echo -e "${GREEN}[+] RAW output to JSON..."
            python3 parsers/peas2json.py ${file[$input]} peass.json
            sleep 5
            echo -e "${GREEN}[+] JSON to PDF..."
            python3 parsers/json2pdf.py peass.json ${file[$input]}.pdf
            sleep 5
            if [[ ! -f ${file[$input]}.pdf ]]
            then
                echo -e "${RED}[-] Failed to convert to PDF!${NO}"
            fi
            rm peass.json
            if [[ -f ${file[$input]}.pdf ]]
            then
                echo -e "${GREEN}[+] Conversion to ${BLUE}PDF ${GREEN}Finished.${NO}"
                echo -e "${GREEN}[+] Created:"${YELLOW} ${file[$input]}.pdf"${NO}"
            fi
            ;;
        "JSON")
            echo -e "${GREEN}[+] Converting RAW output to parsable JSON..."
            sleep 1
            echo -e "${GREEN}[+] RAW output to JSON..."
            python3 parsers/peas2json.py ${file[$input]} peass.json
            sleep 3
            if [[ ! -f peass.json ]]
            then
                echo -e "${RED}[-] Failed to convert to JSON!${NO}"
            fi
            if [[ -f peass.json ]]
            then
                echo -e "${GREEN}[+] Conversion to ${BLUE}JSON ${GREEN}Finished.${NO}" 
                echo -e "${GREEN}[+] Created:"${YELLOW} ${file[$input]}.json"${NO}"
            fi
            ;;
        "RESTART")
            exec "./parsePEASS.sh"
            ;;
        "EXIT")
            echo -e "${BLUE}[+] Bye!${NO}"
            break
            ;;
        *) echo -e "${RED}Non existing option.${NO} $REPLY";;
    esac
done
