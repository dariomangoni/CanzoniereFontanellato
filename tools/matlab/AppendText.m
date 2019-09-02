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

addedText = 'ciao';

for file_sel = 1:length(listing)
    if listing(file_sel).isdir || ~strcmp(listing(file_sel).name(end-3:end), '.tex')
        continue
    end
    
    filename_source = listing(file_sel).name;
    filename_dest{filedest_cont} = filename_source(1:end-4); % remove extension
    filename_dest{filedest_cont} = regexprep(filename_dest{filedest_cont},'([A-Z])','_${lower($1)}');
    filename_dest{filedest_cont} = regexprep(filename_dest{filedest_cont},'(^_)','');
    assert( copyfile([source_folder, filename_source], [destination_folder, filename_dest{filedest_cont}, '.tex'] ));
    filedest_cont = filedest_cont+1;
end


cd(bkp_folder);