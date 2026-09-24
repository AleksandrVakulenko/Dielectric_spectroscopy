function save_result_file(Result)

if isempty(Result)
    warning('Empty data, nothing to save')
    return
end

Save_folder_name = "Result_LCR_01";
File_name = genereate_filename();

Save_folder_name = char(Save_folder_name);
File_name = char(File_name);

Fern_path = f_core.get_fern_local_path();
exist = f_core.find_file_in_dir('.', Save_folder_name, "folder");
if ~exist
    mkdir(Save_folder_name);
end

File_path = [Save_folder_name filesep File_name];

save(File_path, "Result");
disp('Save OK'); % FIXME: disp

end