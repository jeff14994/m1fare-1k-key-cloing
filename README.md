# Clone data to either gen1 or gen2 devices 
This project is to clone data to either gen1 or gen2 devices.
## How to distinguish if the device to be written is either gen1 or gen2?
```
# In pm3, Use this command to check if it's a gen1 card
# This could be a gen2 card if cgetblk command is not working
[usb] pm3 --> hf mf cgetblk --blk 0
[#] wupC1 error
[!!] 🚨 Can't read block. error=-1

# Double check with the following command, if it works it's a gen2 card:
[usb] pm3 --> hf mf rdbl --blk 0 -k FFFFFFFFFFFF
```
## gen1 device is relatively easy to clone (compared to gen2 device)
### How to use?
1. Dump the file from the the key fob you want to clone by pm3
2. [Run this command](./gen1_card/clone_key.sh)
## gen2 device (if you are using gen1 bascially csetuid will work)
### There are two situations you might meet in gen2 device
1. key A is all `FFFFFFFFFFFF`
	- [Run this command](./gen1_card/clone_key.sh)
		- the filename: `/hf-mf-XXXXXXXX-dump.bin` is the dump binary from pm3 using command `hf mf dump`
		- `XXXXXXXX` is the uid you can get it when dumping data with pm3
2. key A is random in each sector, follow the instructions below
### key A is random in each sector
#### Two important files needed to be created
1. The filename: `find_keys` -> can get it by pm3 with command `hf mf autopwn`
	- the `find_keys` format should be similar as [this example](./examples/find_keys.md). We are using key A to read and write the data to specific block
		- e.g key A at `Sec 000` is to unlock `block0-3` and so on
		- command examples: 
			- READ: `hf mf rdbl --blk 0 -k ffffffffffff` ~ `hf mf rdbl --blk 3 -k ffffffffffff`
			- WRITE: `hf mf wrbl --blk 0 -k ffffffffffff -d 0102030405` ~ `hf mf wrbl --blk 3 -k ffffffffffff -d 0102030405`
2. The filename: `dump_data` -> we can get it by dumping from the key fob you want to clone with `hf mf dump`. And the format should be similar as [this example](./examples/dump_data.md)
#### How to use?
1. Connect with pm3
2. `parse_dump.sh`
	- parse the [data](./examples/dump_data.md) dumped from pm3 
	- Input: `dump_data`, output: `parse_dump`
3. `parse_keys.sh`
	- Input the **idential format** of find_keys mentioned [above](./examples/find_keys.md) 
	- Input: `find_keys`, outpus: `parsed_keys`
4. `gen2card_clone_key_fob.sh`
	- Clone the key fob
	- Input: `dump_data` and `parsed_keys`, no output
## Troublshooting
If the key fob is not able to unlock the door (and the reader shows yellow light), the block0 is probably wrong (SAK)
- Mediation: change from `SAK 88` to `SAK 08`
	- Change from `XXXXXXXXXX88XXXXXXXXXXXXXXXXXXXX` to `XXXXXXXXXX08XXXXXXXXXXXXXXXXXXXX` and write it with commands: `hf mf wrbl --blk 0 -k ffffffffffff -d XXXXXXXXXX08XXXXXXXXXXXXXXXXXXXX` 

