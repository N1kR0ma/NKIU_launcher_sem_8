function [] = NKIU_file_generate_2_0(file_ish, ... % Файл данными расчёта
    Name_0, ... %%% Название нового файла
    Dos_box_dir) %%% Директория с DOSBOX прогой

%%%% Функция для создания альтернативных файлов с расчётом ДВС

%% Входные данные чтобы потом было удобнее переделывать в функцию
way = fileparts(which(mfilename));
File_ish = file_ish;
Name_1 = Name_0+".DAT";
Name_2 = Name_0 +".REZ";
way2dosbox = Dos_box_dir;
way2work_folder = way;

%% Преобразование путей и имён фалов
%%%% Не менять местамми а то имя будет дюже не красивое
%%%% Задаёт число пробелов
spaces = string(repmat(' ', 1, 12)); 
%%%% Это вариант генерации 
Variant = " 01";
%%%% Создание подзаголовка файла
zagolovok = strcat(Variant,spaces,Name_1);
Name =strcat(way2work_folder,'\',Name_1);
way2NKIU = way + "\NKIU";
wayNKIU = way + "\NKIU\NKIU.EXE"

%% Запись новых данных в файл нового двигателя
fid = fopen(Name_1,'w')

format_writer = '%12.6f %12.6f %12.6f %12.6f %12.6f\r\n'
 fprintf(fid,'------------------------------------------------------------ \n')  
 text_center('MГТУ им.Н.Э.Баумана каф.ДВС',fid, 70)  
 text_center(zagolovok,fid, 44) %%% Здесь нужно будет сделать тестовую переменную
 fprintf(fid,'%12.5f %12.6f %12.6f %12.6f %12.6f %12.6f\r\n',Line_4_1);
 fprintf(fid,format_writer,Line_5_1(1,:));
 fprintf(fid,format_writer,Line_5_1(2,:));
 fprintf(fid,format_writer,Line_5_1(3,:));
 fprintf(fid,format_writer,Line_5_1(4,:));
 fprintf(fid,format_writer,Line_5_1(5,:));
 fprintf(fid,format_writer,Line_5_1(6,:)); 
 fprintf(fid,format_writer,Line_5_1(7,:));
 fprintf(fid,format_writer,Line_5_1(8,:));
 fprintf(fid,format_writer,Line_5_1(9,:));
 fprintf(fid,'%d   %d   %d   %d   %d\r\n',Line_5_1(10,:));

type(Name_1)
%%% Конвертация в формат понятный для ms-dos
convertToMSDOS(Name, Name)
 
%% Копирование файла в папку NKIU
% Использование fullfile для кросс-платформенных путей
source = Name;
destination = way2NKIU;

% Создание целевой папки, если её нет
if ~exist(destination, 'dir')
    mkdir(destination)
end

copyfile(source, destination)
%%%%% осторожно файлы закрываются
fclose('all');

%% Создание скрипта для генерации нового фала
skript =  sprintf(['%s' ... %%%Выбор путя с досбоксом
    ' -c "mount c %s"' ... %%% Монтирования рабочего диска
    ' -c "C:"' ... %%% Выбор смонтированного в качестве рабочего
    ' -c "%s' ... %%% Путь из рабочей папки к проге NKIU
    ' %s' ...   %%% Файл с исходными данными
    ' %s"' ...  %%% Файл в который записывать расчёт
     '-c "exit"'], ... 
    way2dosbox, ...
    way2work_folder, ...
    'NKIU\NKIU.EXE', ...
    Name_1, ...
    Name_2);
%%  И все страдания были ради этой строчкидзж
system(skript);

%%%% Копирование файла в директорию с результатами
% Использование fullfile для кросс-платформенных путей
source = Name;
destination = way2NKIU;

% Создание целевой папки, если её нет
if ~exist(destination, 'dir')
    mkdir(destination)
end

copyfile(source, destination)

end