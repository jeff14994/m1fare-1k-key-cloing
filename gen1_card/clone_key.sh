#! /bin/bash
# XXXXXXXX is the uid you dumped from the pm3 (using hf mf dump)
payload1="hf mf cload -f ./hf-mf-XXXXXXXX-dump.bin"
payload2="hf mf csetuid -u XXXXXXXX --atqa 0004 --sak 08"
payload="$payload1;$payload2"
echo $payload | pm3
echo "New key fob cloned... Go and Try!"
