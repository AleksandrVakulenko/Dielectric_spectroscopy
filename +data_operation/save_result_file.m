
% FIMXE: (0) check if file exist

function save_result_file(Result, Extra)
arguments
    Result Aster_FRA.LCR_result_type
    Extra Aster_FRA.LCR_extra_data_type = Aster_FRA.LCR_extra_data_type.empty;
end

if isempty(Result)
    warning('Empty data, nothing to save')
    return
end

Save_folder_name = "Result_LCR_01";


Save_folder_name = char(Save_folder_name);

exist = f_core.find_file_in_dir('.', Save_folder_name, "folder");
if ~exist
    mkdir(Save_folder_name);
end

File_name = genereate_filename();
exist = f_core.find_file_in_dir(Save_folder_name, File_name, "file");
if exist
    stop = false;
    while ~stop
        pause(0.2);
        File_name = genereate_filename();
        exist = f_core.find_file_in_dir(Save_folder_name, File_name, "file");
        if ~exist
            stop = true;
        end
    end
end

File_path = [Save_folder_name filesep File_name];
if isempty(Extra)
    save(File_path, "Result"); % NOTE: use this name to read file
else
    save(File_path, "Result", "Extra"); % NOTE: use this name to read file
end
disp('Save OK'); % FIXME: disp

end


function File_name = genereate_filename(add)
arguments
    add string = "";
end
DT = datetime;

Year = year(DT);
Month = month(DT);
Day = day(DT);

Hour = hour(DT);
Minute = minute(DT);
Second = round(second(DT));

Date_str = [num2str(Year, '%04d') '_' ...
            num2str(Month, '%02d') '_' ...
            num2str(Day, '%02d') '_' ...
            num2str(Hour, '%02d') '_' ...
            num2str(Minute, '%02d') '_' ...
            num2str(Second, '%02d')];

File_name = char([Date_str char(add) '.mat']);

end