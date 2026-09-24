


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