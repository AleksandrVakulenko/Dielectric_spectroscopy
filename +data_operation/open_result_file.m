
function [Result, Extra] = open_result_file(Filename, Folder)

File_addr = [char(Folder) filesep char(Filename)];


if nargout == 0
    return;

elseif nargout == 1
    Result = load(File_addr, 'Result');
    Extra = [];

else
    Result = load(File_addr, 'Result');
    try
        Extra = load(File_addr, 'Extra');
    catch
        Extra = [];
    end


end

end


% NOTE: unused function
function Names = get_matfile_vars(File_addr)
Info = matfile(File_addr);
Prop_names = properties(Info);
Prop_names(Prop_names == "Properties") = [];
Prop_names = cellfun(@(x) string(x), Prop_names);
Names = Prop_names;
end
