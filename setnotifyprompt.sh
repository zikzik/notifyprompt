

function notify_on_finish {
	NOTIFY_ON_FINISH=1
}

function notification_on_finish {
	STATUS=$?
	if [ "$NOTIFY_ON_FINISH" == "2" ]; then
		LASTCMD=`history 1 | cut -d' ' -f 4-`
		if [ $STATUS -gt 0 ]; then
			# fail
			ICON=/usr/share/icons/gnome/16x16/status/dialog-error.png
		else
			# success
			ICON=/usr/share/icons/gnome/16x16/status/mail-signed-verified.png
		fi
		#notify-send -i $ICON -t 10000 finished "${HOSTNAME}:${PWD}\n$LASTCMD"
		notify-send -i $ICON -t 10000 FINISHED "${HOSTNAME}:${PWD}\n$LASTCMD"
		NOTIFY_ON_FINISH=0
	else
		# Incerement (notify on next invocation)
		if [ "$NOTIFY_ON_FINISH" == "1" ]; then
			NOTIFY_ON_FINISH=2
		fi
	fi
}


# Attempt at preserving previous PROMPT_COMMAND(s)
echo $PROMPT_COMMAND | grep -v notification_on_finish > /dev/null && export PROMPT_COMMAND="notification_on_finish;$PROMPT_COMMAND"


