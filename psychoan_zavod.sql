-- phpMyAdmin SQL Dump
-- version 4.7.3
-- https://www.phpmyadmin.net/
--
-- Хост: localhost:3306
-- Время создания: Фев 01 2018 г., 22:30
-- Версия сервера: 5.5.58-cll
-- Версия PHP: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `psychoan_zavod`
--

-- --------------------------------------------------------

--
-- Структура таблицы `access`
--

CREATE TABLE `access` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'id',
  `dataBaseTable` varchar(255) NOT NULL COMMENT 'Таблица',
  `userRole` int(2) NOT NULL COMMENT 'Роль',
  `actionCreate` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Создание',
  `actionRead` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Чтение',
  `actionUpdate` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Редактирование',
  `actionDelete` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Удаление'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Доступ' ROW_FORMAT=COMPACT;

--
-- Дамп данных таблицы `access`
--

INSERT INTO `access` (`id`, `dataBaseTable`, `userRole`, `actionCreate`, `actionRead`, `actionUpdate`, `actionDelete`) VALUES
(1, 'access', 15, 1, 1, 1, 1),
(2, 'buildings', 15, 1, 1, 1, 1),
(3, 'calculation_table', 15, 1, 1, 1, 1),
(4, 'components', 15, 1, 1, 1, 1),
(5, 'consumption', 15, 1, 1, 1, 1),
(6, 'details', 15, 1, 1, 1, 1),
(7, 'log', 15, 1, 1, 1, 1),
(8, 'machine', 15, 1, 1, 1, 1),
(9, 'month_and_hours', 15, 1, 1, 1, 1),
(10, 'positions', 15, 1, 1, 1, 1),
(11, 'users', 15, 1, 1, 1, 1),
(12, 'workers', 15, 1, 1, 1, 1),
(13, 'zp', 15, 1, 1, 1, 1),
(14, 'access', 1, 0, 0, 0, 0),
(15, 'buildings', 1, 0, 0, 0, 0),
(16, 'calculation_table', 1, 0, 0, 0, 0),
(17, 'components', 1, 1, 1, 0, 0),
(18, 'consumption', 1, 0, 0, 0, 0),
(19, 'details', 1, 1, 1, 0, 0),
(20, 'log', 1, 0, 0, 0, 0),
(21, 'machine', 1, 0, 0, 0, 0),
(22, 'month_and_hours', 1, 0, 0, 0, 0),
(23, 'positions', 1, 0, 0, 0, 0),
(24, 'users', 1, 0, 0, 0, 0),
(25, 'workers', 1, 1, 1, 1, 1),
(28, 'zp', 1, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `buildings`
--

CREATE TABLE `buildings` (
  `id` int(10) UNSIGNED NOT NULL COMMENT 'id',
  `title` varchar(30) DEFAULT NULL COMMENT 'Название',
  `norma_chas` int(11) DEFAULT NULL COMMENT 'Норма час ',
  `building_cost` int(11) DEFAULT NULL COMMENT 'Стоимость здания',
  `ustanovochnaya_moshchnost` int(11) DEFAULT NULL COMMENT 'Установочная мощность',
  `consume_power` int(11) DEFAULT NULL COMMENT 'Потребляемая энергия',
  `recoupment` int(11) DEFAULT NULL COMMENT 'Окупаемость',
  `electricity_per_hour_cost` int(11) DEFAULT NULL COMMENT 'Электр. в час ',
  `amortization` int(11) DEFAULT NULL COMMENT 'Амортизация ',
  `repair_pay` int(11) DEFAULT NULL COMMENT 'Цена ремонта'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Строения' ROW_FORMAT=COMPACT;

--
-- Дамп данных таблицы `buildings`
--

INSERT INTO `buildings` (`id`, `title`, `norma_chas`, `building_cost`, `ustanovochnaya_moshchnost`, `consume_power`, `recoupment`, `electricity_per_hour_cost`, `amortization`, `repair_pay`) VALUES
(2, 'Здание № 2', 456, 456, 0, 0, 0, 0, 0, 0),
(3, 'Здание № 1', 15, 45500, 35, 10, 0, 35, 12, 7);

-- --------------------------------------------------------

--
-- Структура таблицы `calculation_table`
--

CREATE TABLE `calculation_table` (
  `id` int(11) NOT NULL,
  `course` double NOT NULL COMMENT 'курс у.е.',
  `electricity` double NOT NULL COMMENT 'стоимость электричества',
  `salary_tax` float DEFAULT NULL COMMENT 'налог на зарплату',
  `days_per_month` int(10) UNSIGNED NOT NULL COMMENT 'дней в месяце',
  `hours_per_month` int(10) UNSIGNED NOT NULL COMMENT 'часов в месяце',
  `hours_per_day` int(11) NOT NULL COMMENT 'количество рабочих часов в день',
  `working_machines` int(11) DEFAULT NULL COMMENT 'количество рабочих станков'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Расчётная таблица ' ROW_FORMAT=COMPACT;

--
-- Дамп данных таблицы `calculation_table`
--

INSERT INTO `calculation_table` (`id`, `course`, `electricity`, `salary_tax`, `days_per_month`, `hours_per_month`, `hours_per_day`, `working_machines`) VALUES
(1, 0, 0, 50, 0, 10, 0, 0),
(3, 2, 1.67, 45, 30, 100, 20, 4),
(4, 0, 0, 0, 0, 0, 0, 0);

--
-- Триггеры `calculation_table`
--
DELIMITER $$
CREATE TRIGGER `calculation_delete` BEFORE DELETE ON `calculation_table` FOR EACH ROW begin
insert into log set title='????????',id_log=old.id, date_and_time= now();

end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `calculation_insert` AFTER INSERT ON `calculation_table` FOR EACH ROW begin
insert into log set title='??????????',id_log=new.id, date_and_time= now();

end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `calculation_update` AFTER UPDATE ON `calculation_table` FOR EACH ROW begin
insert into log set title='?????????',id_log=new.id, date_and_time= now();

end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `components`
--

CREATE TABLE `components` (
  `id` int(10) UNSIGNED NOT NULL COMMENT 'id',
  `title` varchar(50) DEFAULT NULL COMMENT 'Название',
  `count` int(11) DEFAULT NULL COMMENT 'Количество'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Компоненты' ROW_FORMAT=COMPACT;

--
-- Дамп данных таблицы `components`
--

INSERT INTO `components` (`id`, `title`, `count`) VALUES
(14, 'Стаканы', 456),
(17, 'Шестерни', 7788),
(20, 'Пластик', 111),
(27, 'Краска', 123);

-- --------------------------------------------------------

--
-- Структура таблицы `consumption`
--

CREATE TABLE `consumption` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(50) NOT NULL,
  `sum` int(11) DEFAULT NULL COMMENT 'сумма расходов',
  `consumption_per_month` int(11) DEFAULT NULL COMMENT 'расход денег в месяц',
  `consumption_per_hour` int(11) DEFAULT NULL COMMENT 'расход денег в час'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Расходы' ROW_FORMAT=COMPACT;

--
-- Дамп данных таблицы `consumption`
--

INSERT INTO `consumption` (`id`, `title`, `sum`, `consumption_per_month`, `consumption_per_hour`) VALUES
(1, '', 0, 0, 0),
(2, '', 0, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `details`
--

CREATE TABLE `details` (
  `id` int(10) UNSIGNED NOT NULL COMMENT 'id',
  `title` varchar(20) DEFAULT NULL COMMENT 'название',
  `cost1` varchar(20) DEFAULT NULL COMMENT 'Цена 1',
  `cost2` varchar(20) DEFAULT NULL COMMENT 'цена 2',
  `form_number` int(11) DEFAULT NULL COMMENT '№ формы',
  `specs` varchar(100) DEFAULT NULL COMMENT 'свойства',
  `time_for_one_detail` time DEFAULT NULL COMMENT 'время на деталь',
  `meterials` varchar(100) DEFAULT NULL COMMENT 'материалы',
  `mass1` int(11) DEFAULT NULL COMMENT 'масса 1',
  `mass2` int(11) DEFAULT NULL COMMENT 'масса2',
  `complexity` int(11) DEFAULT NULL COMMENT 'сложность',
  `amortization` int(11) DEFAULT NULL COMMENT 'амортизация',
  `final_cost` int(11) DEFAULT NULL COMMENT 'ИТОГО'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Детали' ROW_FORMAT=COMPACT;

--
-- Дамп данных таблицы `details`
--

INSERT INTO `details` (`id`, `title`, `cost1`, `cost2`, `form_number`, `specs`, `time_for_one_detail`, `meterials`, `mass1`, `mass2`, `complexity`, `amortization`, `final_cost`) VALUES
(1, 'подставки', '1', '3', 5, 'подставка чёрная', '00:00:42', 'пластик', 2, 3, 1, 51, 6);

-- --------------------------------------------------------

--
-- Структура таблицы `log`
--

CREATE TABLE `log` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(15) DEFAULT NULL COMMENT 'название операции',
  `id_log` int(11) DEFAULT NULL COMMENT 'id логгированного поля',
  `date_and_time` datetime DEFAULT NULL COMMENT 'време изменения'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Логи' ROW_FORMAT=COMPACT;

--
-- Дамп данных таблицы `log`
--

INSERT INTO `log` (`id`, `title`, `id_log`, `date_and_time`) VALUES
(1, 'добавление', 1, '2017-12-12 15:50:16'),
(2, 'добавление', 2, '2017-12-12 20:44:28'),
(3, 'изменение', 1, '2017-12-12 20:45:14'),
(4, 'удаление', 2, '2017-12-12 20:45:40'),
(5, 'добавление', 3, '2017-12-12 20:46:08');

-- --------------------------------------------------------

--
-- Структура таблицы `machine`
--

CREATE TABLE `machine` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(30) DEFAULT NULL,
  `norma_chas` int(11) DEFAULT NULL,
  `machine_cost` int(11) DEFAULT NULL,
  `ustanovochnaya_moshchnost` int(11) DEFAULT NULL,
  `consume_power` int(11) DEFAULT NULL,
  `recoupment` int(11) DEFAULT NULL,
  `electricity_per_hour_cost` int(11) DEFAULT NULL,
  `amortization` int(11) DEFAULT NULL,
  `repair_pay` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Станки' ROW_FORMAT=COMPACT;

--
-- Дамп данных таблицы `machine`
--

INSERT INTO `machine` (`id`, `title`, `norma_chas`, `machine_cost`, `ustanovochnaya_moshchnost`, `consume_power`, `recoupment`, `electricity_per_hour_cost`, `amortization`, `repair_pay`) VALUES
(0, '', 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `month_and_hours`
--

CREATE TABLE `month_and_hours` (
  `day_in_month` int(11) NOT NULL,
  `hours_per_day` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='месяцы и часы' ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Структура таблицы `positions`
--

CREATE TABLE `positions` (
  `id` int(11) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Должности' ROW_FORMAT=COMPACT;

--
-- Дамп данных таблицы `positions`
--

INSERT INTO `positions` (`id`, `title`) VALUES
(NULL, ''),
(NULL, '');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `login` varchar(255) NOT NULL COMMENT 'Логин',
  `passwd` varchar(32) NOT NULL COMMENT 'Пароль',
  `role` int(2) NOT NULL DEFAULT '15' COMMENT 'Уровень привилегий '
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Пользователи' ROW_FORMAT=COMPACT;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `login`, `passwd`, `role`) VALUES
(1, 'admin', '098f6bcd4621d373cade4e832627b4f6', 15),
(3, 'worker', 'b61822e8357dcaff77eaaccf348d9134', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `workers`
--

CREATE TABLE `workers` (
  `id` int(10) UNSIGNED NOT NULL,
  `f_name` varchar(20) DEFAULT NULL,
  `l_name` varchar(20) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Работники' ROW_FORMAT=COMPACT;

--
-- Дамп данных таблицы `workers`
--

INSERT INTO `workers` (`id`, `f_name`, `l_name`, `position`) VALUES
(0, '', '', '');

-- --------------------------------------------------------

--
-- Структура таблицы `zp`
--

CREATE TABLE `zp` (
  `id` int(10) UNSIGNED NOT NULL,
  `position` varchar(30) DEFAULT NULL,
  `number_of` int(11) DEFAULT NULL,
  `zp_in_month` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Зарплата' ROW_FORMAT=COMPACT;

--
-- Дамп данных таблицы `zp`
--

INSERT INTO `zp` (`id`, `position`, `number_of`, `zp_in_month`) VALUES
(0, '', 0, 0),
(4, '', 0, 0);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `access`
--
ALTER TABLE `access`
  ADD UNIQUE KEY `id` (`id`);

--
-- Индексы таблицы `buildings`
--
ALTER TABLE `buildings`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `calculation_table`
--
ALTER TABLE `calculation_table`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `components`
--
ALTER TABLE `components`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `consumption`
--
ALTER TABLE `consumption`
  ADD UNIQUE KEY `id` (`id`);

--
-- Индексы таблицы `details`
--
ALTER TABLE `details`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `machine`
--
ALTER TABLE `machine`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `login` (`login`);

--
-- Индексы таблицы `workers`
--
ALTER TABLE `workers`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `zp`
--
ALTER TABLE `zp`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `access`
--
ALTER TABLE `access`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id', AUTO_INCREMENT=29;
--
-- AUTO_INCREMENT для таблицы `buildings`
--
ALTER TABLE `buildings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id', AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `calculation_table`
--
ALTER TABLE `calculation_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT для таблицы `components`
--
ALTER TABLE `components`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id', AUTO_INCREMENT=28;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
