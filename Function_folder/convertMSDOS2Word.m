function convertMSDOS2Word(inputFile, outputFile, targetEncoding)
% CONVERTMSDOS2WORD Конвертирует файл из кодировки MS-DOS в кодировку для Word
%
%   convertMSDOS2Word(inputFile, outputFile, targetEncoding)
%
%   Параметры:
%   inputFile      - путь к исходному файлу в кодировке MS-DOS (CP866)
%   outputFile     - путь к выходному файлу
%   targetEncoding - целевая кодировка (по умолчанию: 'UTF-8')
%                    Возможные значения: 'UTF-8', 'windows-1251'
%
%   Примеры использования:
%   convertMSDOS2Word('oldfile.txt', 'newfile.txt', 'UTF-8')
%   convertMSDOS2Word('dos_text.txt', 'word_text.txt')

    % Установка кодировки по умолчанию
    if nargin < 3
        targetEncoding = 'UTF-8';
    end
    
    % Проверка существования исходного файла
    if ~exist(inputFile, 'file')
        error('Файл "%s" не найден', inputFile);
    end
    
    % Определение кодировки MS-DOS для русского текста
    % CP866 - основная кодировка MS-DOS для русского языка
    sourceEncoding = 'CP866';
    
    % Чтение файла в бинарном режиме
    fprintf('Чтение файла: %s\n', inputFile);
    
    fid = fopen(inputFile, 'r', 'n', sourceEncoding);
    if fid == -1
        error('Не удалось открыть файл: %s', inputFile);
    end
    
    % Чтение всего содержимого файла
    textContent = fread(fid, '*char')';
    fclose(fid);
    
    % Для корректной конвертации можно также использовать альтернативный способ
    % Этот способ более надежен для сложных случаев
    fprintf('Конвертация из %s в %s...\n', sourceEncoding, targetEncoding);
    
    % Открываем файл для записи в целевой кодировке
    fid = fopen(outputFile, 'w', 'n', targetEncoding);
    if fid == -1
        error('Не удалось создать выходной файл: %s', outputFile);
    end
    
    % Записываем преобразованный текст
    fwrite(fid, textContent, 'char');
    fclose(fid);
    
    fprintf('Файл успешно сохранен: %s\n', outputFile);
    fprintf('Кодировка: %s\n', targetEncoding);
end