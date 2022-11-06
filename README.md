# Write data to blocks based on the key provided
# How to distinguish if the card is either gen1 or gen2?
Use this command to check if it's a gen1 card
This could be a gen2 card if cgetblk command is not working
	- [usb] pm3 --> hf mf cgetblk --blk 0
	- Result: [#] wupC1 error
			  [!!] 🚨 Can't read block. error=-1
Double check with the following command, if it works it's a gen2 card:
	- [usb] pm3 --> hf mf rdbl --blk 0 -k FFFFFFFFFFFF
## This is the code for gen2 card (if you are using gen1 bascially csetuid will work)
## Two important files needed to be acquired
1. the find_keys -> can get it by pm3 `hf mf autopwn`
	- the find_keys format should be something like [this](./example/find_keys)
	and use key A to read and write the data to specific block
		- e.g key A at Sec 000 is to unlock block0-3
		- commands: 
			- READ: hf mf rdbl --blk 0 -k ffffffffffff ~ hf mf rdbl --blk 3 -k ffffffffffff
			- WRITE: hf mf wrbl --blk 0 -k ffffffffffff -d 0102030405 ~ hf mf wrbl --blk 3 -k ffffffffffff -d 0102030405
2. the parse_dump -> can get it by dumping from the key fob you want to clone`hf mf dump`
## Troublshooting
if the key fob is not able to unlock the door(and the reader show yellow light), the block0 is probably wrong (SAK)
	- Mediation: change from SAK 88 to SAK 08
		- commands: hf mf wrbl --blk 0 -k 6b44622f3515 -d 745C5F5C2B080400C814002000000020
## How to use?
- Connect with pm3
- parse_dump
	- parse the data dumped from pm3 
- parse_keys.sh
	- Input the **idential** format of find_keys mentioned above 
- gen2card_clone_key_fob.sh
	- run this command

