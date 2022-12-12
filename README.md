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

## Usage

```console
myuser@myhost ~ $ quickscreenvid.sh -h
        quickscreenvid.sh [-d] [-b <blacklist-regex-string>] [-f <filename-to-save-to>]
        -d: Print debugging output.
        -s: Use `slurp` to select subsection of screen.
        -f: Filename to save to.
                An example filename which MAY NOT BE SUITABLE FOR YOU is `-f $(date +"/home/$(whoami)/Videos/cameras/screenvid_${HOSTNAME}/%Y-%m-%dT%H:%M:%S.mp4")`.
        -b: Specify a regex string for sources to exclude, you can view your sources via `pattl list sources | grep Name`.
                An example regex string which MAY NOT BE SUITABLE FOR YOU is `-b '^alsa_(input\.pci-0000|output).*?$'`.
        -h: displays help message.
PLEASE REMEMBER to run \`quickscreenvid_kill.sh\` when you are finished recording!
```
