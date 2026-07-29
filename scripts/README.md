```sh
#!/bin/sh # shebang (#!) tells the kernel to pass this file to the /bin/sh interpreter program when running  this file directly (e.g. `./script.sh`)

set -eu # -e: error on non-zero exits (if a program exits with exit code 0, then it was successful); -u: error if the program uses unset variables
```
