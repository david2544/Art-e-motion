# Art-e-motion

Combining Processing animations and Kinect to create pretty art.

## How to run it

- Clone this project
- run `cd Art-e-motion`
- run `make`

  - If you get the following error:

    `xcrun: error: invalid active developer path (/Library/Developer/CommandLineTools), missing xcrun at: /Library/Developer/CommandLineTools/usr/bin/xcrun`

  - then run `xcode-select --install` and wait for it to finish then try to run `make` again.

- run `cd main`
- run `code .` (If you get "command not found: code" , open VsCode, run `command + shift + p` search for "code" and
  choose `Shell Command: Install 'code' command in PATH`, return to terminal and run the command again)
  Or simply open the `main` folder manually in VSCode :D
- open the `main.pde` file and `command + shift + b`
