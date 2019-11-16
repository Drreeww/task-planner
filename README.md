# Task

## Overview

*Task* is a task planning tool for the command line.

## Command reference

```
usage: ./task.py [] [order] [add] [priority] [do] [done]

View all tasks:
./task.py
./task.py order <task|priority|status>

Add a task:
./task.py add "<name>"
./task.py add "<name>" priority <priority>

Set the priority of an existing task:
./task.py priority <priority> for <task id>

Set a task to doing:
./task.py do <task id>

Delete a task:
./task.py done <task id>
```

## License

Copyright (c) 2019, Yannick Kirschen, All rights reserved.
Licensed under the [MIT License](https://github.com/yannickkirschen/task/blob/master/LICENSE).
Happy forking :fork_and_knife:
