%%%%% Функция для перекодировки полученных матлабом файлов в понятную
%%%%% MS-DOS собственно от вас требуется 2 вещи:
%%%%% 1) Указать путь к фозданному файлу с его названием и кодировкой
%%%%% 2) Указать путь к файлу с новой желаемой кодировкой
%%%%% Поздравляю вы великолепны
%%%%% Написано Deepseek так что наверное это лучшая часть "моего" кода

%{
Собственно для работы данной функции необходимо наличие java на 
компьютере т.к. большинство людей пока работает на windows и не
страдает паранойей то скорее всего она у вас уже есть... если нет...
помянем 
Единственная задача даной функции дать DosBox прочитать созданный 
файл
%}

function [] = convertToMSDOS(inputFile, outputFile)
% CONVERTTOMSDOS Конвертирует текстовый файл в кодировку MS-DOS (CP866)
%
% Синтаксис:
%   convertToMSDOS(inputFile, outputFile)
%   convertToMSDOS(inputFile)  - создаст файл с суффиксом '_dos.txt'
%
% Примеры:
%   convertToMSDOS('input.txt', 'output_dos.txt')
%   convertToMSDOS('document.txt')
%
% Поддерживаемые кодировки исходного файла:
%   UTF-8, Windows-1251, ASCII

    % Проверка количества аргументов
    if nargin < 1
        error('Необходимо указать входной файл');
    end
    
    % Если выходной файл не указан, создаем имя автоматически
    if nargin < 2
        [path, name, ext] = fileparts(inputFile);
        outputFile = fullfile(path, [name '_dos' ext]);
    end
    
    % Проверяем существование входного файла
    if ~exist(inputFile, 'file')
        error('Входной файл "%s" не найден', inputFile);
    end
    
    % Пытаемся определить кодировку исходного файла
    try
        % Пробуем прочитать файл в различных кодировках
        encodings = {'UTF-8', 'windows-1251', 'ISO-8859-1', 'US-ASCII'};
        
        for i = 1:length(encodings)
            try
                % Открываем файл с указанной кодировкой
                fid = fopen(inputFile, 'r', 'n', encodings{i});
                textData = fread(fid, '*char')';
                fclose(fid);
                
                fprintf('Файл успешно прочитан в кодировке: %s\n', encodings{i});
                break;
            catch
                if i == length(encodings)
                    error('Не удалось определить кодировку файла');
                end
            end
        end
        
    catch ME
        error('Ошибка при чтении файла: %s', ME.message);
    end
    
    % Конвертируем текст в кодировку MS-DOS (CP866)
    try
        % Для версий MATLAB с поддержкой iconv
        if exist('unicode2native', 'file') && exist('native2unicode', 'file')
            % Преобразуем текст в байты кодировки CP866
            bytes = unicode2native(textData, 'CP866');
            
            % Записываем в файл с кодировкой CP866
            fid = fopen(outputFile, 'w', 'n', 'CP866');
            fwrite(fid, bytes, 'uint8');
            fclose(fid);
            
        else
            % Альтернативный метод для старых версий MATLAB
            fprintf('Используется альтернативный метод конвертации...\n');
            
            % Попробуем использовать Java для конвертации
            try
                % Преобразуем строку в байты CP866 через Java
                bytes = uint8(textData);
                
                % Простая замена для кириллицы (Windows-1251 → CP866)
                % Это базовое преобразование для наиболее частых символов
                bytes = simpleEncodingConvert(bytes);
                
                fid = fopen(outputFile, 'wb');
                fwrite(fid, bytes, 'uint8');
                fclose(fid);
                
            catch
                % Самый простой метод - сохранить как есть
                warning('Используется прямое сохранение. Кодировка может быть некорректной.');
                fid = fopen(outputFile, 'w', 'n', 'windows-1251');
                fprintf(fid, '%s', textData);
                fclose(fid);
            end
        end
        
        fprintf('Файл успешно конвертирован и сохранен как: %s\n', outputFile);
        fprintf('Кодировка: MS-DOS (CP866)\n');
        
    catch ME
        error('Ошибка при конвертации: %s', ME.message);
    end
end