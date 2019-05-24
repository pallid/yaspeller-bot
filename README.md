
### yaspeller-bot

Сервис возвращает вариант текста сообщения, если он был написан не правельно

Запрос:
```json
{
    "text":"Ghbdtn rfr nfv Gtnz", 
    "username": "id пользователя", 
    "display_name": "Bubbbu"	
}
```

Ответ:
```json
{
    "text": "@Bubbbu хотел сказать:\nПривет как там Петя",
    "bot": "yaspeller-bot"
}
```

Пример запуска:
```bash
set LOGGING_CONSOLE=true
set LOGGING_LEVEL=DEBUG
set PORT=8085
cd /d "F:\projects\yaspeller-bot\src"
"C:\OneScript.Web\OneScript.WebHost.exe" --urls http://*:%PORT%
```