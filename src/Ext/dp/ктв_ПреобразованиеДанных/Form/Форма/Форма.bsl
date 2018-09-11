﻿#Область СлужебныеПроцедуры

&НаКлиенте
Процедура ПутьКФайлуНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	Диалог.Фильтр = "Файл выгрузки / загрузки (*.txt)|*.txt";
	Диалог.Заголовок = "Файл выгрузки / загрузки";

	Если Диалог.Выбрать() Тогда
		ПутьКФайлу = Диалог.ПолноеИмяФайла;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработкаКоманд

// Процедура - добавляет в описание ссылки наименование
//
// Параметры:
//  ОписаниеЗначения       - Структура      - Структура значения для дополнения
//  Значение               - Произвольный   - Преобразуемое значение
//
Процедура ДобавитьНаименованиеОбъекта(ОписаниеЗначения, Значение) Экспорт
	
	ОписаниеЗначения.Вставить("Наименование", СокрЛП(Значение));
	
КонецПроцедуры //ДобавитьНаименованиеОбъекта()

&НаСервере
Процедура ТестНаСервере()
	
	Библиотека = РеквизитФормыВЗначение("Объект");
	
	Первые = " ПЕРВЫЕ 1";
	
	НачВремя = ТекущаяДата();
	
	й = 0;
	
	Для Каждого ТекМетаОбъект Из Метаданные.Справочники Цикл
		
		Если ТекМетаОбъект.Иерархический И ТекМетаОбъект.ВидИерархии = Метаданные.СвойстваОбъектов.ВидИерархии.ИерархияГруппИЭлементов Тогда
			Запрос = Новый Запрос("ВЫБРАТЬ" + Первые + " ТекТаб.Ссылка ИЗ Справочник." + ТекМетаОбъект.Имя + " КАК ТекТаб ГДЕ ТекТаб.ЭтоГруппа");
			Результат = Запрос.Выполнить();
			Выборка = Результат.Выбрать();
			Пока Выборка.Следующий() Цикл
				Библиотека.ДобавитьПравилоВыгрузкиТипа(ТекМетаОбъект.ПолноеИмя(), "ДобавитьНаименованиеОбъекта", ЭтаФорма);
				Представление = Библиотека.ОбъектВСтруктуру(Выборка.Ссылка);
				ТекстОбъекта = Библиотека.ЗаписатьОписаниеОбъектаВJSON(Представление);
				Представление = Библиотека.ПрочитатьОписаниеОбъектаИзJSON(ТекстОбъекта);
				НовыйЭлемент = Библиотека.СоздатьОбъектИзСтруктуры(Представление);
				й = й + 1;
			КонецЦикла;
			Запрос = Новый Запрос("ВЫБРАТЬ" + Первые + " ТекТаб.Ссылка ИЗ Справочник." + ТекМетаОбъект.Имя + " КАК ТекТаб ГДЕ НЕ ТекТаб.ЭтоГруппа");
		Иначе
			Запрос = Новый Запрос("ВЫБРАТЬ" + Первые + " ТекТаб.Ссылка ИЗ Справочник." + ТекМетаОбъект.Имя + " КАК ТекТаб");
		КонецЕсли;
		Результат = Запрос.Выполнить();
		Выборка = Результат.Выбрать();
		Пока Выборка.Следующий() Цикл
			Библиотека.ДобавитьПравилоВыгрузкиТипа(ТекМетаОбъект.ПолноеИмя(), "ДобавитьНаименованиеОбъекта", ЭтаФорма);
			Представление = Библиотека.ОбъектВСтруктуру(Выборка.Ссылка);
			ТекстОбъекта = Библиотека.ЗаписатьОписаниеОбъектаВJSON(Представление);
			Представление = Библиотека.ПрочитатьОписаниеОбъектаИзJSON(ТекстОбъекта);
			НовыйЭлемент = Библиотека.СоздатьОбъектИзСтруктуры(Представление);
			й = й + 1;
		КонецЦикла;
	КонецЦикла;
	
	Для Каждого ТекМетаОбъект Из Метаданные.ПланыВидовХарактеристик Цикл
		
		Если ТекМетаОбъект.Иерархический Тогда
			Запрос = Новый Запрос("ВЫБРАТЬ" + Первые + " ТекТаб.Ссылка ИЗ ПланВидовХарактеристик." + ТекМетаОбъект.Имя + " КАК ТекТаб ГДЕ ТекТаб.ЭтоГруппа");
			Результат = Запрос.Выполнить();
			Выборка = Результат.Выбрать();
			Пока Выборка.Следующий() Цикл
				Представление = Библиотека.ОбъектВСтруктуру(Выборка.Ссылка);
				ТекстОбъекта = Библиотека.ЗаписатьОписаниеОбъектаВJSON(Представление);
				Представление = Библиотека.ПрочитатьОписаниеОбъектаИзJSON(ТекстОбъекта);
				НовыйЭлемент = Библиотека.СоздатьОбъектИзСтруктуры(Представление);
				й = й + 1;
			КонецЦикла;
			Запрос = Новый Запрос("ВЫБРАТЬ" + Первые + " ТекТаб.Ссылка ИЗ ПланВидовХарактеристик." + ТекМетаОбъект.Имя + " КАК ТекТаб ГДЕ НЕ ТекТаб.ЭтоГруппа");
		Иначе
			Запрос = Новый Запрос("ВЫБРАТЬ" + Первые + " ТекТаб.Ссылка ИЗ ПланВидовХарактеристик." + ТекМетаОбъект.Имя + " КАК ТекТаб");
		КонецЕсли;
		Результат = Запрос.Выполнить();
		Выборка = Результат.Выбрать();
		Пока Выборка.Следующий() Цикл
			Представление = Библиотека.ОбъектВСтруктуру(Выборка.Ссылка);
			ТекстОбъекта = Библиотека.ЗаписатьОписаниеОбъектаВJSON(Представление);
			Представление = Библиотека.ПрочитатьОписаниеОбъектаИзJSON(ТекстОбъекта);
			НовыйЭлемент = Библиотека.СоздатьОбъектИзСтруктуры(Представление);
			й = й + 1;
		КонецЦикла;
	КонецЦикла;
	
	Для Каждого ТекМетаОбъект Из Метаданные.ПланыВидовРасчета Цикл
		
		Запрос = Новый Запрос("ВЫБРАТЬ" + Первые + " ТекТаб.Ссылка ИЗ ПланВидовРасчета." + ТекМетаОбъект.Имя + " КАК ТекТаб");
		
		Результат = Запрос.Выполнить();
		Выборка = Результат.Выбрать();
		Пока Выборка.Следующий() Цикл
			Представление = Библиотека.ОбъектВСтруктуру(Выборка.Ссылка);
			ТекстОбъекта = Библиотека.ЗаписатьОписаниеОбъектаВJSON(Представление);
			Представление = Библиотека.ПрочитатьОписаниеОбъектаИзJSON(ТекстОбъекта);
			НовыйЭлемент = Библиотека.СоздатьОбъектИзСтруктуры(Представление);
			й = й + 1;
		КонецЦикла;
	КонецЦикла;
	
	Для Каждого ТекМетаОбъект Из Метаданные.ПланыСчетов Цикл
		
		Запрос = Новый Запрос("ВЫБРАТЬ" + Первые + " ТекТаб.Ссылка ИЗ ПланСчетов." + ТекМетаОбъект.Имя + " КАК ТекТаб");
		
		Результат = Запрос.Выполнить();
		Выборка = Результат.Выбрать();
		Пока Выборка.Следующий() Цикл
			Представление = Библиотека.ОбъектВСтруктуру(Выборка.Ссылка);
			ТекстОбъекта = Библиотека.ЗаписатьОписаниеОбъектаВJSON(Представление);
			Представление = Библиотека.ПрочитатьОписаниеОбъектаИзJSON(ТекстОбъекта);
			НовыйЭлемент = Библиотека.СоздатьОбъектИзСтруктуры(Представление);
			й = й + 1;
		КонецЦикла;
	КонецЦикла;
	
	Для Каждого ТекМетаОбъект Из Метаданные.ПланыОбмена Цикл
		
		Запрос = Новый Запрос("ВЫБРАТЬ" + Первые + " ТекТаб.Ссылка ИЗ ПланОбмена." + ТекМетаОбъект.Имя + " КАК ТекТаб");
		
		Результат = Запрос.Выполнить();
		Выборка = Результат.Выбрать();
		Пока Выборка.Следующий() Цикл
			Представление = Библиотека.ОбъектВСтруктуру(Выборка.Ссылка);
			ТекстОбъекта = Библиотека.ЗаписатьОписаниеОбъектаВJSON(Представление);
			Представление = Библиотека.ПрочитатьОписаниеОбъектаИзJSON(ТекстОбъекта);
			НовыйЭлемент = Библиотека.СоздатьОбъектИзСтруктуры(Представление);
			й = й + 1;
		КонецЦикла;
	КонецЦикла;
	
	НачДок = ТекущаяДата();
	
	Док = 0;
	
	Для Каждого ТекМетаОбъект Из Метаданные.Документы Цикл
		
		Запрос = Новый Запрос("ВЫБРАТЬ" + Первые + " ТекТаб.Ссылка ИЗ Документ." + ТекМетаОбъект.Имя + " КАК ТекТаб");
		
		Результат = Запрос.Выполнить();
		Выборка = Результат.Выбрать();
		Пока Выборка.Следующий() Цикл
			Представление = Библиотека.ОбъектВСтруктуру(Выборка.Ссылка);
			ТекстОбъекта = Библиотека.ЗаписатьОписаниеОбъектаВJSON(Представление);
			Представление = Библиотека.ПрочитатьОписаниеОбъектаИзJSON(ТекстОбъекта);
			НовыйЭлемент = Библиотека.СоздатьОбъектИзСтруктуры(Представление);
			й = й + 1;
			Док = Док + 1;
		КонецЦикла;
	КонецЦикла;
	
	КонВремя = ТекущаяДата();
	
	Сообщить("Всего объектов:" + Формат(й, "ЧН=; ЧГ="));
	Сообщить("Всего документов:" + Формат(Док, "ЧН=; ЧГ="));
	Сообщить("Начало выполнения:" + Формат(НачВремя, "ЧН=; ЧГ="));
	Сообщить("Начало обработки документов: " + Формат(НачДок, "ЧН=; ЧГ="));
	Сообщить("Окончание выполнения: " + Формат(КонВремя, "ЧН=; ЧГ="));
	Сообщить("Время выполнения: " + Формат(КонВремя - НачВремя, "ЧН=; ЧГ=") + "с.");
	Сообщить("Время обработки документов: " + Формат(КонВремя - НачДок, "ЧН=; ЧГ=") + "с.");
	Сообщить("Скорость всего: " +  Формат(й / (КонВремя - НачВремя), "ЧН=; ЧГ=") + "об./с.");
	Сообщить("Скорость документов: " + Формат(Док / (КонВремя - НачДок), "ЧН=; ЧГ=") + "об./с.");
	
КонецПроцедуры

&НаКлиенте
Процедура Тест(Команда)
	ТестНаСервере();
КонецПроцедуры

#КонецОбласти
