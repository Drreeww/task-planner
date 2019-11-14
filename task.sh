#!/bin/bash

# MIT License
#
# Copyright (c) 2019 Yannick Kirschen
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# "Task" is a simple task-planning tool for the shell.



# The file to store/get the tasks in/from
FILE=tasks

if [ ! -f $FILE]
then
    touch $FILE
fi

# Add a new task
# Arguments: task, priority
add_task() {
    if [[ $PRIORITY -eq 0  ]]
    then
        PRIORITY=0
    fi

    sequence

    echo $SEQUENCE::$TASK_ADD::$PRIORITY >> $FILE
    echo Added task with ID $SEQUENCE.
}

# Deletes a task with a specific ID
delete_task() {
    grep '^[^'$TASK_DELETE']::' tasks > $FILE.tmp
    mv $FILE.tmp $FILE
    echo Deleted task $TASK_DELETE.
}

# Calculates the next ID. When there are no tasks, the ID will be 1
sequence() {
    SEQUENCE=$(awk -F:: '
    BEGIN {max=0}
    { if(($1)>max)  max=($1) }
    END {print max + 1}' $FILE)
}

# Prints out all tasks in a list
print_tasks() {
    sequence
    id_length=$(echo -n "${SEQUENCE}" | wc -c)
    awk -F:: '
    BEGIN {
        print "ID     Task                                             Priority"
        print "----------------------------------------------------------------"
    }

    {
        if (NF == 3) {
            id_padding=""
            task_padding=""

            for (i = 1; i <= 7-id; i++)
                id_padding=id_padding " "

            for (i = 1; i <= 49-length($2); i++)
                task_padding=task_padding " "

            print $1 id_padding $2 task_padding $3
        }
    }
    ' id="${id_length}" $FILE
    exit 0
}

# Check command line arguments
while getopts "a:p:d:" opt
do
    case $opt in
        p) PRIORITY=$OPTARG;;
        a) TASK_ADD=$OPTARG;;
        d) TASK_DELETE=$OPTARG;;
    esac
done

if [[ $TASK_ADD ]]
then
    add_task
elif [[ $TASK_DELETE ]]
then
    delete_task
else
    print_tasks
fi
