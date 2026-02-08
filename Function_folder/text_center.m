% Функция центрирования текста (сам в шоке что такое потребовалось писать)
function [] = text_center(text, fid, line_width)    
    % Вычисляем отступы
    text_length = length(text);
    left_spaces = floor((line_width - text_length) / 2);
    right_spaces = line_width - text_length - left_spaces;
    
    % Записываем центрированный текст
    fprintf(fid, '%s%s%s\n', ...
        repmat(' ', 1, left_spaces), ...
        text, ...
        repmat(' ', 1, right_spaces));
end