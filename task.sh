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

# Check command line arguments
while getopts at:p: opt
do
    case $opt in
        a) WHAT_TO_DO=ADD;;
        t) TASK=$OPTARG;;
        p) PRIORITY=$OPTARG;;
    esac
done

# The file to store/get the tasks in/from
FILE=tasks

# Add a new task
# Arguments: task, priority
add_task() {
    if [[ $PRIORITY -eq 0  ]]
    then
        PRIORITY=0
    fi

    echo $(date)::$TASK::$PRIORITY >> $FILE
    echo Added task "$TASK" with priority $PRIORITY.
}

# Choose what to do
if [[ $WHAT_TO_DO -eq ADD  ]]
then
    if [ -z ${TASK+x} ] # Check why this evaluates to true, even if the task is set
    then
        echo You must set a task [-t "Your task"]
        exit -1
    else
        add_task $TASK $PRIORITY
    fi
fi

