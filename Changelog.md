# parsePEASS Changelog

# 1.2
- reduced screen clutter
- use: .\parsePEASS info to get option overview
- fixed a small issue with PDF processing

# 1.1
- small redesign, added check for bad characters and few fixups
- added a bad character check from piped outputs (running linpeas on target and piping the result to host which writes the output file)
- Changed parser code - peas2json.py to ignore 'infos' in final output. It is a dirty fix but it allows creation of winpeas HTML\PDF files.<br/>
Proper fix is on the way.

# 1.0
- Initial Release
