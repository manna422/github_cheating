#!/bin/bash

TARGET_DIR=output

HELLO_WORLD_PYTHON="if __name__ == '__main__':\n    print \"Hello World\""
DAYS_HACKED=300

SECS_PER_DAY=86400
RUNNING_TIME=$((`date +%s` - (${DAYS_HACKED} * ${SECS_PER_DAY} )))
ENDING_TIME=`date +%s`

reinitialize_git_dir ()
{
   # Delete old repo
    if [ -d ${TARGET_DIR} ]; then
       rm -rf ${TARGET_DIR}
    fi

    # create initial repo commit
    mkdir ${TARGET_DIR}
    pushd ${TARGET_DIR}
    echo -e ${HELLO_WORLD_PYTHON} >> main.py
    git init
    git add main.py
    git commit -m "Hello World" --date="@${RUNNING_TIME}"
}

iterate_over_days ()
{
    while [ ${RUNNING_TIME} -lt ${ENDING_TIME} ]; do
        # add random time (0 - 32767 seconds) between commits
        CURRENT_STRING="current_time=$RUNNING_TIME"
        echo ${CURRENT_STRING} > time.py
        git add time.py
        git commit -m "${CURRENT_STRING}" --date="@${RUNNING_TIME}"
        RUNNING_TIME=$(( ${RUNNING_TIME} + ${RANDOM} ))
    done
}

reinitialize_git_dir
iterate_over_days
popd

exit 0
