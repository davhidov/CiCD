TELEGRAM_USER_ID=353762687
TELEGRAM_BOT_TOKEN=5803570664:AAEPQSw2llif4yXXUQ-nD6mwzGeFgP1RJ10
TIME="10"
URL="https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage"
TEXT="CI/CD status: $1%0ASTAGE:+$CI_JOB_STAGE%0AProject:+$CI_PROJECT_NAME%0AURL:+$CI_PROJECT_URL/pipelines/$CI_PIPELINE_ID/%0ABranch:+$CI_COMMIT_REF_SLUG"

curl -s --max-time $TIME -d "chat_id=$TELEGRAM_USER_ID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null

