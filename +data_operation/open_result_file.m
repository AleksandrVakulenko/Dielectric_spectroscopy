
function [Result, Extra] = open_result_file(Filename, Folder)

File_addr = [char(Folder) filesep char(Filename)];

Names = get_matfile_vars(File_addr);


if nargout == 0
    return;

elseif nargout == 1
    if any(contains(Names, "Result"))
        Result = load(File_addr, 'Result');
        Extra = [];
    else
        error("Error opening mat file: no variable with name 'Result'");
    end

else
    if any(contains(Names, "Result")) && any(contains(Names, "Extra"))
        Result = load(File_addr, 'Result');
        Extra = load(File_addr, 'Extra');
    elseif any(contains(Names, "Result")) && ~any(contains(Names, "Extra"))
        Result = load(File_addr, 'Result');
        Extra = [];
    else
        error("Error opening mat file: no variable with name 'Result'");
    end

end




end



function Names = get_matfile_vars(File_addr)
Info = matfile(File_addr);
Prop_names = properties(Info);
Prop_names(Prop_names == "Properties") = [];
Prop_names = cellfun(@(x) string(x), Prop_names);
Names = Prop_names;
end
