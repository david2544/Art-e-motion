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
- open the `main.pde`.
- if its the first time, make sure you have the "Processing Language" extension installed in VSCode and the processing IDE (https://processing.org/download/), open the processing IDE, go to `tools/install "Processing-java"` then return to VSCode and run `command + shift + p`, search for "task" and choose `Processing: Create Task File`.
- run `command + shift + b` and enjoy!


Credits to Killeroo for the ColorGenenrator class (https://www.openprocessing.org/sketch/504589)
Source for the Git hook to prevent pushes to master: https://blog.ghost.org/prevent-master-push/
