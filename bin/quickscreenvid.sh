#!/usr/bin/env bash

BLACKLIST=""
DEBUG=0
USESLURP=0
FILENAME=""

USAGE="usage:\n\
        $(basename "$0") [-d] [-b <blacklist-regex-string>] [-f <filename-to-save-to>]\n\
        -d: Print debugging output.\n\
        -s: Use \`slurp\` to select subsection of screen.\n\
        -f: Filename to save to.\n\
                An example regex string which MAY NOT BE SUITABLE FOR YOU is \`-f \$(date +\"/home/$(whoami)/Videos/cameras/screenvid_${HOSTNAME}/%Y-%m-%dT%H:%M:%S.mp4\")\`.\n\
        -b: Specify a regex string for sources to exclude, you can view your sources via \`pattl list sources | grep Name\`.\n\
                An example regex string which MAY NOT BE SUITABLE FOR YOU is \`-b \'^alsa_(input\.pci-0000|output).*?$\'\`.\n\
        -h: displays help message.\n\
PLEASE REMEMBER to run \`quickscreenvid_kill\` when you are finished recording!
"

while getopts ":b:f:dsh" flag
do
        case "$flag" in
                b)
                        BLACKLIST="$OPTARG"
                        ;;
                f)
                        FILENAME="$OPTARG"
                        ;;
                s)
                        USESLURP=1
                        ;;
                d)
                        DEBUG=1
                        ;;
                h)
                        echo -e "$USAGE"
                        exit 0
                        ;;
                \?)
                        echo "Invalid option: -$OPTARG" >&2
                        exit 1
                        ;;
                :)
                        echo "Option -$OPTARG requires an argument." >&2
                        exit 1
                        ;;
        esac
done

if ((DEBUG)); then
	echo "These are the pactl sources before we set up the Combined sink:"
	pactl list sources | grep Name
fi

pactl load-module module-null-sink sink_name=Combined

SOURCE_CANDIDATES=$(pactl list sources | grep Name)
for SOURCE_CANDIDATE in $SOURCE_CANDIDATES; do
	if [ $SOURCE_CANDIDATE != "Name:" ]; then
		if [ $SOURCE_CANDIDATE != "Combined.monitor" ]; then
			if ! [[ $SOURCE_CANDIDATE =~ $BLACKLIST ]]; then
                                if ((DEBUG)); then
					echo "\"pactl load-module module-loopback sink=$SOURCE_CANDIDATE\""
				fi
				pactl load-module module-loopback sink=Combined source=$SOURCE_CANDIDATE
                                if ((DEBUG)); then
					echo "$SOURCE_CANDIDATE loading succeeded."
				fi
			fi
		fi
	fi
done

if ((DEBUG)); then
	echo "These are the pactl sources before wf-recorder is started:"
	pactl list sources | grep Name
fi

WF_OPTIONS=(
        --audio="Combined.monitor"
        -t
        )

if ((USESLURP)); then
        WF_OPTIONS+=("-g $(slurp)")
fi

if [[ "$FILENAME" ]]; then
        WF_OPTIONS+=("-f $FILENAME")
fi

if ((DEBUG)); then
	echo "This is the \`wf-recorder\` command we'll be running:"
	echo "wf-recorder ${WF_OPTIONS[@]}"
fi

wf-recorder "${WF_OPTIONS[@]}"
