#!/bin/bash
# Version 1.0
# Created by lrvt
# 
# https://blog.lrvt.de/securing-vaultwarden-with-fail2ban/
# 
# Send Fail2ban notifications using a Telegram Bot
# Add to the /etc/fail2ban/jail.conf:
# [sshd]
# ***
# action  = iptables[name=SSH, port=22, protocol=tcp]
#           telegram
# Create a new file in /etc/fail2ban/action.d with the following information:
# [Definition]
# actionstart = /etc/fail2ban/scripts/send_telegram_notif.sh -a start 
# actionstop = /etc/fail2ban/scripts/send_telegram_notif.sh -a stop
# actioncheck = 
# actionban = /etc/fail2ban/scripts/send_telegram_notif.sh -b <ip>
# actionunban = /etc/fail2ban/scripts/send_telegram_notif.sh -u <ip>
# 
# [Init]
# init = 123

####################################
### Telgram Intrgration Settings ###
####################################
# On Telegram message @BotFather with /newbot to create a bot and generate the API Token
# Telegram BOT API Token 
telegramBotToken='outputFrom@BotFather'
# On Telegram message @getmyid_bot with /start to get your current user ID and chat ID, of which the chat ID is used below
# Telegram Chat ID
telegramChatID='outputFrom@getmyid_bot'

function talkToBot() {
    message=$1
    curl -s -X POST https://api.telegram.org/bot${telegramBotToken}/sendMessage -d text="${message}" -d chat_id=${telegramChatID} > /dev/null 2>&1
}
if [ $# -eq 0 ]; then
    echo "Usage $0 -a ( start || stop ) || -b $IP || -u $IP || -r $REASON"
    exit 1;
fi
while getopts "a:b:u:r:" opt; do
    case "$opt" in
        a)
            action=$OPTARG
        ;;
        b)
            ban=y
            ip_add_ban=$OPTARG
        ;;
        u)
            unban=y
            ip_add_unban=$OPTARG
        ;;
        r)
            reason=$OPTARG
        ;;
        ?) 
            echo "Invalid option. -$OPTARG"
            exit 1
        ;;
    esac
done
if [[ ! -z ${action} ]]; then
    case "${action}" in
        start)
            talkToBot "Fail2ban has been started"
        ;;
        stop)
            talkToBot "Fail2ban has been stopped"
        ;;
        *)
            echo "Incorrect option"
            exit 1;
        ;;
    esac
elif [[ ${ban} == "y" ]]; then
    talkToBot "The IP ${ip_add_ban} has been banned due to ${reason}. https://ipinfo.io/${ip_add_ban}"
    exit 0;
elif [[ ${unban} == "y" ]]; then
    talkToBot "The IP: ${ip_add_unban} has been unbanned."
    exit 0;
else
    info
fi
