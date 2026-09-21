
% convert jsondecode output to string and array from char and cell

Filename = "Modules_url_list.txt";

Json_text = jsonencode(Modules_list, "PrettyPrint", true);

fid = fopen(Filename, 'w');
fprintf(fid, Json_text);
fclose(fid);



%%

Json_text_in = fileread(Filename);

Table = jsondecode(Json_text_in)


%%
clc

Fields = fieldnames(Table);

for i = 1:numel(Fields)

Field_name = Fields{i};

Column = Table.(Field_name);

for j = 1:numel(Table)
    Data = Table(j).(Field_name);
    if class(Data) == "char"
        Data = string(Data);
    end
    Table(j).(Field_name) = Data;
end


end