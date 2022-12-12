# quickscreenvid

This is a simple bash script (hopefully) allowing you to easily record your screen as well as all audio inputs and outputs with `wf-recorder`.

It's basically a programmatic implementation of the [wf-recorder wiki guide](https://github.com/ammen99/wf-recorder/wiki#recording-both-mic-input-and-application-sounds) alongside some debugging support which might help.
I actually don't think this is that great as a standalone tool, since it obsucres a lot of arguments from the underlying `wf-recorder` and if it's to be reliably distributed, it would need a bunch of dependency management which I think is overkill for a simple bash script.
Ideally this could be integrated somehow with `wf-recorder` upstream.
See discussion: https://github.com/ammen99/wf-recorder/issues/194
Until then, or if that never happens, feel free to use and report issues here.
I use it regularly so I'm happy to improve it.


**PLEASE REMEMBER** to always run `quickscreenvid_kill.sh` when you're done recording.
Not doing so will cause you to have a dangling sink which might end up playing your microphone back to you, and it will also confuse subsequent executions of the script.
