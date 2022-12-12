# quickscreenvid

This is a simple bash script (hopefully) allowing you to easily record your screen as well as all audio inputs and outputs with `wf-recorder`.

It's basically a programmatic implementation of the [wf-recorder wiki guide](https://github.com/ammen99/wf-recorder/wiki#recording-both-mic-input-and-application-sounds) alongside some debugging support which might help.

PLEASE REMEMBER to always run `quickscreenvid_kill.sh` when you're done recording.
Not doing so will cause you to have a dangling sink which might end up playing your microphone back to you, and it will also confuse subsequent executions of the script.
