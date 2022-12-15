# Fusion 360 mac cleanup script

This script cleans up all the garbage fusion360's auto-updater leaves behind in your Library/Application Support

It's not written by me (tho I've tweaked it a little) - it's originally by user [stephen.greensides on the fusion 360 forums](https://forums.autodesk.com/t5/fusion-360-support/reclaim-fusion-360-disk-space/td-p/9888870).

This deletes older versions, trims the log file, and removes non-english languages. If you use 360 in a non-english language, you'll definitely want to remove the `deleteNonEnglish` bit from this script.

## To use it:

1. download or clone this repo.
2. unzip it if needed, put it somewhere that it can stay forever.
3. figure out the absolute path to the script, based on where you put it. For me it's `/Users/cory/.fusioncleanup/cleanup.sh`
4. open the terminal and run: `chmod 755 /Users/cory/.fusioncleanup/cleanup.sh` with the path you found in step 3.
5. run the script in the terminal:
	- `cd /Users/cory/.fusioncleanup/`
	- `./cleanup`

## Scheduling it to run regularly

If your script is in place and runs well, you can run it manually whenever you want, or set it up to run it on a schedule using crontab

1. in terminal: `crontab -e`
2. press `i` to enter insert mode
3. paste this line into the crontab file: `40 * * * * /Users/cory/.fusioncleanup/cleanup.sh`, and edit it to point the path from install step 3
4. press the escape key, then type `wq` to write the changes and exit the editor.

Crontab uses the following format, which you can use to run it more or less often, or at a different time:

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


