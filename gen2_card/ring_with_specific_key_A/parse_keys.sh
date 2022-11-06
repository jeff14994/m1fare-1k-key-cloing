#!/bin/sh
# parse the keys
cat find_keys | cut -d "|" -f3 | tail -n +4 | head -n 16 > parsed_keys_middle 
# duplicate the key wtih 4 times
# see this command: https://stackoverflow.com/a/32001256
sed -r 's/(.*)/\1\n\1\n\1\n\1/' parsed_keys_middle > parsed_keys
echo "Parsing keys completed"


