/*
    Возвращает записи лога доступов
    по заданным параметрам,
    отсортированные в порядке попадания в лог (обратном)
*/
EXEC [dbo].[GET_ACCESS_LOG]
      @id2_id = NULL -- идентификатор аккаунта (часть Id2)
    , @xss_id = NULL -- идентификатор аккаунта (часть xSS)
    , @xss_access_record_id = NULL -- ID записи доступа xSS
    , @id2_access_record_id = NULL -- ID записи доступа Id2
    , @sender = NULL -- отправитель (XSS ID2 Apress CRM_DIGITAL)
    , @top_records = NULL -- максимальное количество возвращаемых записей (если не задано = 100)
    -- период времени
    , @period_start_date= NULL -- начало периода
    , @period_end_date = NULL -- окончание периода (если интервал периода больше суток - конечная дата уменьшается)
    , @time_zone = NULL -- тайм-зона (по умолчанию +03:00).
                        -- Если строка тайм-зоны не соответствует критерию LIKE '[+-][0-1][0-9]:[0-9][05]',
                        -- то ей присваивается значение по умолчанию (+03:00 - Москва).
                        -- Если задана тайм-зона, отличная от UTC (+00:00), то даты периода считаются
                        -- указанными в соответствующей тайм-зоне и выходное значение столбца LOGGED_TIME также
                        -- приводится к заданной тайм-зоне.
                        -- Если задана тайм-зона +00:00, то все даты (параметры и выходное значение LOGGED_TIME)
                        -- являются датами UTC
 
    , @test_mode = NULL -- Если NULL или 0 - тестовый режим выключен.
                        -- Если больше 0 - тестовый режим включен. Возвращает два набора:
                        -- 1) значения параметров
                        -- 2) строку созданного динамического запроса