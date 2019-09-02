clear variables
close all
clc

source_folder = '..\..\';

canzonieri_list = {'CanzoniereScout', 'CanzoniereLiturgico', 'CanzoniereVarie'};
for canzoniere_sel = 1:size(canzonieri_list,2)
    fid_orig = fopen([source_folder,canzonieri_list{canzoniere_sel},'.tex'], 'r');
    file_orig_content = textscan(fid_orig,'%s');
    fclose(fid_orig);


    fid_dest = fopen([source_folder,canzonieri_list{canzoniere_sel},'_new','.tex'], 'w');
    for row_sel = 1:size(file_orig_content{:},1)
        source_text = file_orig_content{1}{row_sel};
        song_name = regexp(source_text,'\\input\{"songs\/?(.*)"\}','tokens');
        song_name = regexprep(song_name{:},'([A-Z])','_${lower($1)}');
        song_name = regexprep(song_name{:},'(^_)','');
        source_text = ['\input{"songs/',song_name,'"}'];
        fprintf(fid_dest, '%s\n', source_text);
    end
    fclose(fid_dest);
end
