clear variables
close all
clc

source_folder = 'songs_orig\';
destination_folder = 'songs\';
status = rmdir(destination_folder, 's');
assert(mkdir(destination_folder))


bkp_folder = cd;

cd(source_folder);
listing = dir;
cd ..

filename_dest = cell(length(listing),1);
filedest_cont = 1;
for file_sel = 1:length(listing)
    if listing(file_sel).isdir || ~strcmp(listing(file_sel).name(end-3:end), '.tex')
        continue
    end
    
    filename_source = listing(file_sel).name;
    filename_dest{filedest_cont} = filename_source(1:end-4);
    filename_dest{filedest_cont} = regexprep(filename_dest{filedest_cont},'[\xe0-\xe5]','a');
    filename_dest{filedest_cont} = regexprep(filename_dest{filedest_cont},'[\xc0-\xc5]','A');
    filename_dest{filedest_cont} = regexprep(filename_dest{filedest_cont},'[\xe8-\xeb]','e');
    filename_dest{filedest_cont} = regexprep(filename_dest{filedest_cont},'[\xc8-\xcb]','E');
    filename_dest{filedest_cont} = regexprep(filename_dest{filedest_cont},'[\xec-\xef]','i');
    filename_dest{filedest_cont} = regexprep(filename_dest{filedest_cont},'[\xcc-\xcf]','I');
    filename_dest{filedest_cont} = regexprep(filename_dest{filedest_cont},'[\xf0\xf2-\xf6]','o');
    filename_dest{filedest_cont} = regexprep(filename_dest{filedest_cont},'[\xd2-\xd6]','O');
    filename_dest{filedest_cont} = regexprep(filename_dest{filedest_cont},'[\xf9-\xfc]','u');
    filename_dest{filedest_cont} = regexprep(filename_dest{filedest_cont},'[\xd9-\xdc]','U');
    filename_dest{filedest_cont} = regexprep(filename_dest{filedest_cont},'[\s+_]([a-z])','${upper($1)}');
    filename_dest{filedest_cont} = regexprep(filename_dest{filedest_cont},'[\W]','');
    filename_dest{filedest_cont} = regexprep(filename_dest{filedest_cont},'\s','');
    assert( copyfile([source_folder, filename_source], [destination_folder, filename_dest{filedest_cont}, '.tex'] ));
    filedest_cont = filedest_cont+1;
end


%% create CanzoniSparse.tex that lists all the songs
fid = fopen([destination_folder,'CanzoniSparse.tex'], 'w');
filename_dest = sort(filename_dest(~cellfun('isempty',filename_dest)));
filedest_cont = filedest_cont-1;
for file_cont = 1:filedest_cont
    fprintf(fid, '\\input{"songs/%s"}\n', filename_dest{file_cont});
end

fclose(fid);

cd(bkp_folder);