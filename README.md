# Fusion 360 mac cleanup script

This script cleans up all the garbage fusion360's auto-updater leaves behind in your Library/Application Support

It's not written by me (tho I've tweaked it a little) - it's originally by user [stephen.greensides on the fusion 360 forums](https://forums.autodesk.com/t5/fusion-360-support/reclaim-fusion-360-disk-space/td-p/9888870).

To use it:

1. download or clone this repo.
2. unzip it if needed, put it somewhere that it can stay forever.
3. figure out the absolute path to the script, based on where you put it. For me it's `/Users/cory/.fusioncleanup/cleanup.sh`
4. open the terminal and run: `chmod 755 /Users/cory/.fusioncleanup/cleanup.sh` with the path you found in step 3.
5. test the script by running in the terminal:
	- `cd /Users/cory/.fusioncleanup/`
	- `./cleanup`
6. if the output of that looks good, run it on a schedule using crontab:
    - in terminal: `crontab -e`
    - press `i` to enter insert mode
    - paste this line into the crontab file: `40 * * * * /Users/cory/.fusioncleanup/cleanup.sh`, and edit it to point the path from step 3
    - press the escape key, then type `wq` to write the changes and exit the editor.

Crontab format is the following:

```
# * * * * *  command to execute
# ┬ ┬ ┬ ┬ ┬
# │ │ │ │ │
# │ │ │ │ │
# │ │ │ │ └───── day of week (0 - 7) (0 to 6 are Sunday to Saturday, or use names; 7 is Sunday, the same as 0)
# │ │ │ └────────── month (1 - 12)
# │ │ └─────────────── day of month (1 - 31)
# │ └──────────────────── hour (0 - 23)
# └───────────────────────── min (0 - 59)
```

Hope this helps you save some precious disk space.


