cat ./dump/dump_data | cut -d "|" -f2 | tr -d " " | tail -n +4 | head -n 64 > parse_dump
