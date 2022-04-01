# Install using PEASS_ng
- Clone https://github.com/carlospolop/PEASS-ng repository
- Create a new directory (/opt/parsePEASS or such)
- Copy "parsers" directory from PEASS_ng into /opt/parsePEASS/parsers
- Copy 'parsePEASS.sh' into /opt/parsePEASS/parsePEASS.sh
- This way you have a clean surface with folder parsers and script outside.
- Put raw output file inside /opt/parsePEASS for parsing and creating HTML or PDF files. 
- chmod +x parsePEASS.sh
- Should look like this:

![install](https://user-images.githubusercontent.com/41833021/161233942-1aa6a5f5-1102-4619-a1d1-3b5e664bbd9b.png)

# Install without PEASS_ng
- PEASS_ng python parsers are included and you can download them from here
- I however suggest you go to PEASS_ng repo and use theirs.
-
- Clone the repo or download files
- Create a new directory (/opt/parsePEASS or such)
- Copy "parsers" folder and "parsePEASS.sh" into /opt/parsePEASS/
- This way you have a clean surface with folder parsers and script outside
- Put raw output file inside /opt/parsePEASS for parsing and creating HTML or PDF files. 
- chmod +x parsePEASS.sh
- Should look same as picture above. 

