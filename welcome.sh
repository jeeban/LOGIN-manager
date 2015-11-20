#PICTURE_LOG="/home/miku/.my_utilities/login/log/picture/"
WELCOME_TEXT="/home/miku/.my_utilities/login/.welcome_text"
LOGIN_ATTEMPT="/home/miku/.my_utilities/login/log/.login_attempt"

#streamer -o "$PICTURE_LOG`date`.jpeg"
zenity --text-info --filename=$WELCOME_TEXT --ok-label="Verify" --cancel-label="No Thanks" --height=350 --width=350 --title="TECHBOX user verification" --timeout=20
if [ "$?" = "0" ]
then
	for count in 1 2 3
	do
		if [ "$count" -le "4" ]
		then
			ID=$(zenity --username --password --title="TECHBOX login attempt $count" --timeout=10)
			#streamer -o "$PICTURE_LOG`date`.jpeg"			
			if test "$ID" == "miku|123"
			then
				zenity --text-info --filename=$LOGIN_ATTEMPT --ok-label="Continue" --cancel-label="Clear log" --title="login_attempt log"
				if [ "$?" = "1" ]
				then
					echo > $LOGIN_ATTEMPT
				else
					echo '------------------------------------' >> $LOGIN_ATTEMPT
				fi
				zenity --notification --text="Welcome to the techbox" --timeout=5
				exit 0
			else
				echo $ID >> $LOGIN_ATTEMPT
				echo `date` >> $LOGIN_ATTEMPT
				echo >> $LOGIN_ATTEMPT
			fi
		fi
	done
	echo '------------------------------------' >> $LOGIN_ATTEMPT
fi

#killing all processes
zenity --warning --text="\tINVALID USER       \nkilling all processes..." --timeout=3
#kill -9 -1
exit 0
