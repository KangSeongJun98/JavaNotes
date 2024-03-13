API_KEY = "6706025088:AAEz3MdRbqEWGG381kyl3Jc67v_H-EtLNWo"
from telegram.ext import Updater
from telegram.ext import MessageHandler, Filters, CommandHandler
updater = Updater(token=API_KEY, use_context=True)


def echo(update, context):
    user_id = update.effective_chat.id
    user_msg = update.message.text
    context.bot.send_message(chat_id = user_id, text= user_msg)

def my_diary(update, context):
    user_id = update.effective_chat.id
    user_msg = update.message.text
    if '종료' in user_msg:
        global f #전역변수
        if f:
            f.close()
        context.bot.send.message(chat_id=user_id, text='다이어리 종료')
    else:
        f = open("my_diary.txt", 'a', encoding='utf-8')
        f.write(user_msg.replace('/diary','').strip())
        f.writelines("\n")
        context.bot.send_message(chat_id=user_id, text="작성중..")
        print("메모장")

echo_handler = MessageHandler(Filters.text & (~Filters.command), echo)
updater.dispatcher.add_handler(echo_handler)
#다이어리 기능 추가
diary_handler = CommandHandler('diary', my_diary)
updater.dispatcher.add_handler(diary_handler)

updater.start_polling()
updater.idle()