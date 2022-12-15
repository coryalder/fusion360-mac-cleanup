#######################################################
## Clean up after AutoDesk's Fusion 360
##
## Overnight job that runs regularly in the early hours
##
#######################################################

#######################################################
## Trim the Log File
## set limit of 10000 lines
##
## if more, then delete the first 10 percent
#######################################################

function trimLogFile () {
  local COMMAND=""
  local LOG_FILE="/Users/""$USER""/Library/Application Support/Autodesk/Web Services/Log/WebServices.log"
  local LOG_FILE_LENGTH=0
  local MAX_LINES=10000
  local TEN_PERCENT=0
  local THE_DIFF=0
  echo "Log file is '""$LOG_FILE""'"

  ##
  ## count the number of lines and convert to integer
  ##

  LOG_FILE_LENGTH=$(cat "$LOG_FILE" | wc -l)
  LOG_FILE_LENGTH=$(expr "$LOG_FILE_LENGTH")
  LOG_FILE_LENGTH="$( echo $LOG_FILE_LENGTH)"

  ##
  ## do we need to do anything?
  ##

  if [[ "$LOG_FILE_LENGTH" -gt "$MAX_LINES" ]]; then
    echo "Log file too long at ""$LOG_FILE_LENGTH"" lines"
    THE_DIFF=$(expr "$LOG_FILE_LENGTH" "-" "$MAX_LINES")
    TEN_PERCENT=$(expr "$THE_DIFF" "/" "10")
    ##
    ## build up command
    ##

    COMMAND="1,""$TEN_PERCENT""d"
    sed -in "$COMMAND" "$LOG_FILE"
    echo "$TEN_PERCENT"" lines trimed"
  else
    echo "Log file length ok"
  fi;
    echo "Log file trim step complete"
}

###################################################
## clean out older Fusion 360 installations
## if more than 2, then delete the oldest directory
###################################################

function deleteOldestInstall () {
  local dir2delete=""
  local targetDirectory="/Users/""$USER""/Library/Application Support/Autodesk/webdeploy/production"
  echo "Target Directory is '""$targetDirectory""'"

  if [[ $(ls -ltr "$targetDirectory" | grep ^d | wc -l) -gt 2 ]]; then
    dir2delete=$(ls -ltr "$targetDirectory" | grep ^d | head -1 | rev | cut -d " " -f1 | rev)
    echo "Directory to delete='""$targetDirectory""/""$dir2delete""'"
    rm -vrf "$targetDirectory""/""$file2delete"
  else
    echo "Only found directories = "$(ls -ltr "$targetDirectory" | grep ^d | wc -l)
  fi;
  echo "delete older installs step complete"
}

######################################################
## remove the first found none English project library
## as we only use English
######################################################

function deleteNonEnglish () {
  echo "Checking for Non-english projects"
  local dir2delete=$(find "/Users/""$USER""/Library/Application Support/Autodesk" -type d -name "*.lproj" ! -name "Base.lproj" ! -name "English.lproj" ! -name "en.lproj" -print | head -1)

  if [[ ! -z "$dir2delete" ]]; then
    rm -frv "$dir2delete"
    echo "\n"
    echo "$dir2delete"" Deleted"
  else
    echo "No Non-English Projects"
  fi;
  echo "languge cleanup step complete"
}

#######

## main

#######

echo "\n"
deleteNonEnglish
deleteOldestInstall
trimLogFile

##
## unwanted files
##

find "/Users/""$USER""/Library/Application Support/Autodesk" -type f -name ".DS_Store" -print -delete
echo "Unwanted files deleted"

##
## unwanted empty directories
##

find "/Users/""$USER""/Library/Application Support/Autodesk" -type d -empty -atime +100d -mindepth 1  -print -delete
echo "Old empty directories deleted"

####
# end
#####

exit
