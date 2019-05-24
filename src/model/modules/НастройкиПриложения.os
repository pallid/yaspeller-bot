#Использовать logos

Перем Лог Экспорт;

Перем Версия Экспорт;
Перем ИмяПриложения Экспорт;

Перем ИмяЛогаПриложения;
Перем ПутьКФайлуЖурналаПриложения;

Функция Иницилизация() Экспорт

	пИмяПриложения = "yaspeller-bot";
	
	ИмяПриложения = пИмяПриложения;
	ПутьКФайлуЖурналаПриложения = СтрШаблон("./wwwroot/logs/webapp.%1.log", ИмяПриложения);
	ИмяЛогаПриложения = СтрШаблон("oscript.webapp.%1", ИмяПриложения);

	ВыполнитьНастройкиЛогированияПриложения();
	Лог.Информация("/// - ЗАПУСК ПРИЛОЖЕНИЯ - ///");

	ПолучитьВерсиюПриложения();

	Лог.Информация("ИМЯ ПРИЛОЖЕНИЯ - %1", пИмяПриложения);

КонецФункции

Функция ВыполнитьНастройкиЛогированияПриложения()

	Лог = Логирование.ПолучитьЛог(ИмяЛогаПриложения);

	ФайлЖурнала = Новый ВыводЛогаВФайл;
	ФайлЖурнала.ОткрытьФайл(ПутьКФайлуЖурналаПриложения);
	Лог.ДобавитьСпособВывода(ФайлЖурнала);

	пВыводитьЛогВКонсоль = ПолучитьПеременнуюСреды("LOGGING_CONSOLE");
	Если пВыводитьЛогВКонсоль = Неопределено Тогда
		пВыводитьЛогВКонсоль = Ложь;
	КонецЕсли;

	Если пВыводитьЛогВКонсоль Тогда
		ВыводЛогаВКонсоль = Новый ВыводЛогаВКонсоль;
		Лог.ДобавитьСпособВывода(ВыводЛогаВКонсоль);
	КонецЕсли;	

	пУровеньЛогирования = ПолучитьУровеньЛогированияПриложения();
	Сообщить("Уровень логирования - "+пУровеньЛогирования, СтатусСообщения.Информация);

	Лог.УстановитьУровень(пУровеньЛогирования);

	Лог.УстановитьРаскладку(ЭтотОбъект);

КонецФункции	

Функция ПолучитьУровеньЛогированияПриложения()

	УровниЛогирования = Новый Соответствие;
	УровниЛогирования.Вставить("DEBUG", 		 УровниЛога.Отладка);
	УровниЛогирования.Вставить("INFO", 			 УровниЛога.Информация);
	УровниЛогирования.Вставить("WARNING", 		 УровниЛога.Предупреждение);
	УровниЛогирования.Вставить("ERROR", 		 УровниЛога.Ошибка);
	УровниЛогирования.Вставить("CRITICAL_ERROR", УровниЛога.КритичнаяОшибка);

	пУровеньЛогирования = ПолучитьПеременнуюСреды("LOGGING_LEVEL");

	Если пУровеньЛогирования = Неопределено Тогда
		пУровеньЛогирования = "INFO";
	КонецЕсли;	

	пУровеньЛогирования = УровниЛогирования[пУровеньЛогирования];

	Если пУровеньЛогирования = Неопределено Тогда
		ВызватьИсключение "Не установлен уровень логирования приложения";
	КонецЕсли;

	Возврат пУровеньЛогирования;

КонецФункции

Функция Форматировать(Знач Уровень, Знач Сообщение) Экспорт

    Возврат СтрШаблон("%1: %2 - %3", ТекущаяДата(), УровниЛога.НаименованиеУровня(Уровень), Сообщение);

КонецФункции

Процедура ПолучитьВерсиюПриложения()

	АдресФайла = "./packagedef";
	Чтение = Новый ЧтениеТекста(АдресФайла, КодировкаТекста.UTF8);
	Текст = Чтение.Прочитать();
	Чтение.Закрыть();
	Версия = ВыделитьВерсию(Текст);

	Лог.Информация("ВЕРСИЯ ПРИЛОЖЕНИЯ - %1", Версия);

КонецПроцедуры	

Функция ВыделитьВерсию(Знач Данные)
	
	Лог.Отладка("Применяю регулярку к %1", Данные);
	РЕ = Новый РегулярноеВыражение("(\d{1,3}\.(\d{1,3}\.)*\d{1,3})");
	Совпадения = РЕ.НайтиСовпадения(Данные);
	Если Совпадения.Количество() = 0 Тогда
		Возврат Неопределено;
	КонецЕсли;

	Совпадение = Совпадения[0].Группы[1];
	Возврат Совпадение.Значение;

КонецФункции

