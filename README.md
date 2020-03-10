gpCatFile

An awk utility used to analize ascii file with records new line delimited

This program is used to visualize record (new line delimited) and its fields
using a file structure

Running GPef with these parameter :

 cat 'Input File' | awk -f gpCatFile.awk 'Name Structure File'

Format Structure File (fields separated by ;) :
- Field Name
- Start Byte
- Length Field
- Function 
    - V : To Show field