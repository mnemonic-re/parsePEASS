#!/bin/bash

# -------------------------------------------------------------------
# sh = PEASS_ng Output file Parser and Converter
# v = 1.2
# id = malloc84 || mnemonic-re @ github
# -------------------------------------------------------------------

title="PEASS_ng Output file Converter (HTML, PDF, JSON)"
prompt="Select option: "

NO='\033[0m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'

ARG=$1

echo "$title"
PS3="$prompt "

parsepeassinfo()
{
    echo ''
    echo -e "${BLUE}Output file conversion options: ${NO}"
    echo -e "${GREEN}1 - Convert ${YELLOW}"${file[$input]}" ${GREEN}to readable HTML file."
    echo -e "${GREEN}2 - Convert ${YELLOW}"${file[$input]}" ${GREEN}to readable PDF file."
    echo -e "${GREEN}3 - Convert ${YELLOW}"${file[$input]}" ${GREEN}to parsable JSON file."
    echo -e "${BLUE}4 - Restart Conversion script to process another file.${NO}"
    echo -e "${RED}5 - Exit Conversion script.${NO}"
    echo ''    
}

# debug KEKW
if [[ $ARG == info ]]; then
    parsepeassinfo
    exit 1
fi

echo -e "${GREEN}Convert PEASS_ng (linpeas or winpeas) output file to HTML or PDF readable format${NO}"
echo -e "${GREEN}About: ./parsePEASS info${NO}"
echo -e "Select the ${YELLOW}*.out ${NO}PEASS output file to process."
echo ''

files=$(ls *.out)
i=1
echo "Found outputs:"
for j in $files
do
echo "$i.$j"
file[i]=$j
i=$(( i + 1 ))
done

echo ''
read -p "Select *.out file to process (number): " input 
echo -e "File to process: "${YELLOW}"${file[$input]}"${NO}""



options=("HTML" "PDF" "JSON" "RESTART" "EXIT")
select opt in "${options[@]}"
do
    case $opt in
        "HTML")
            echo -e "${GREEN}[+] Converting RAW output to readable HTML..."
            if [[ -f peass.json ]]
            then
                rm peass.json
            fi
            sleep 1
            echo -e "${GREEN}[+] RAW output to JSON..."
            python3 parsers/peas2json.py ${file[$input]} peass.json
            if [[ -f peass.json ]]
            then
                echo -e "${GREEN}[+] Searching and Fixing BAD characters..."
                sed -i 's/S<s/Ss/g' peass.json
                sleep 3
            fi
            echo -e "${GREEN}[+] JSON to HTML..."
            python3 parsers/json2html.py peass.json ${file[$input]}.html
            sleep 3
            if [[ ! -f ${file[$input]}.html ]]
            then
                echo -e "${RED}[-] Failed to convert to HTML!${NO}"
            fi

            if [[ -f ${file[$input]}.html ]]
            then
                rm peass.json
                echo -e "${GREEN}[+] Conversion to ${BLUE}HTML ${GREEN}Finished.${NO}"
                echo -e "${GREEN}[+] Created:"${YELLOW} ${file[$input]}.html"${NO}"
            fi
            ;;
        "PDF")
            echo -e "${GREEN}[+] Converting RAW output to readable PDF..."
            if [[ -f peass.json ]]
            then
                rm peass.json
            fi
            sleep 1
            echo -e "${GREEN}[+] RAW output to JSON..."
            python3 parsers/peas2json.py ${file[$input]} peass.json
            if [[ -f peass.json ]]
            then
                echo -e "${GREEN}[+] Searching and Fixing BAD characters..."
                sed -i 's/S<s/Ss/g' peass.json
                sleep 3
            fi
            echo -e "${GREEN}[+] JSON to PDF... (might take a while)"
            python3 parsers/json2pdf.py peass.json ${file[$input]}.pdf
            sleep 3
            if [[ ! -f ${file[$input]}.pdf ]]
            then
                echo -e "${RED}[-] Failed to convert to PDF!${NO}"
            fi
            if [[ -f ${file[$input]}.pdf ]]
            then
                rm peass.json
                echo -e "${GREEN}[+] Conversion to ${BLUE}PDF ${GREEN}Finished.${NO}"
                echo -e "${GREEN}[+] Created:"${YELLOW} ${file[$input]}.pdf"${NO}"
            fi
            ;;
        "JSON")
            echo -e "${GREEN}[+] Converting RAW output to parsable JSON..."
            sleep 1
            if [[ -f peass.json ]]
            then
                rm peass.json
            fi
            echo -e "${GREEN}[+] RAW output to JSON..."
            python3 parsers/peas2json.py ${file[$input]} peass.json
            if [[ -f peass.json ]]
            then
                echo -e "${GREEN}[+] Searching and Fixing BAD characters..."
                sed -i 's/S<s/Ss/g' peass.json
                sleep 3
            fi
            sleep 3
            if [[ ! -f peass.json ]]
            then
                echo -e "${RED}[-] Failed to convert to JSON!${NO}"
            fi
            if [[ -f peass.json ]]
            then
                echo -e "${GREEN}[+] Conversion to ${BLUE}JSON ${GREEN}Finished.${NO}" 
                echo -e "${GREEN}[+] Created: "${YELLOW}'peass.json'"${NO}"
            fi
            ;;
        "RESTART")
            exec "./parsePEASS.sh"
            ;;
        "EXIT")
            echo -e "${BLUE}[+] Bye!${NO}"
            break
            ;;
        *) echo -e "${RED}Non existing option.${NO} $REPLY"
            ;;
    esac
done
