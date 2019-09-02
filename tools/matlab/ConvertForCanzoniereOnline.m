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

% Preamble for CanzoniereOnline



filename_dest = cell(length(listing),1);
filedest_cont = 1;
for file_sel = 1:length(listing)
    if listing(file_sel).isdir || ~strcmp(listing(file_sel).name(end-3:end), '.tex')
        continue
    end
    
    filename_source = listing(file_sel).name;
    filename_dest{filedest_cont} = filename_source(1:end-4); % remove extension
    filename_dest{filedest_cont} = regexprep(filename_dest{filedest_cont},'([A-Z])','_${lower($1)}');
    filename_dest{filedest_cont} = regexprep(filename_dest{filedest_cont},'(^_)','');
%     assert( copyfile([source_folder, filename_source], [destination_folder, filename_dest{filedest_cont}, '.tex'] ));
    source_text = fileread([source_folder, filename_source]);
    
    % replace chords
    source_text = regexprep(source_text,'(\\\[)(Do)([^\].]*\])','$1C$3');
    source_text = regexprep(source_text,'(\\\[)(Re)([^\].]*\])','$1D$3');
    source_text = regexprep(source_text,'(\\\[)(Mi)([^\].]*\])','$1E$3');
    source_text = regexprep(source_text,'(\\\[)(Fa)([^\].]*\])','$1F$3');
    source_text = regexprep(source_text,'(\\\[)(Sol)([^\].]*\])','$1G$3');
    source_text = regexprep(source_text,'(\\\[)(La)([^\].]*\])','$1A$3');
    source_text = regexprep(source_text,'(\\\[)(Si)([^\].]*\])','$1B$3');

    author = string(regexp(source_text, 'by\s*\=\s*\{([^\}]*)\}', 'tokens', 'once'));
    if isempty(author)
        addAuthorField = regexprep(source_text, '(\\beginsong\{[^\}]*})', '$1[by={}]', 'once');
    end
    title = string(regexp(source_text, '\\beginsong\{([^\}]*)}', 'tokens', 'once'));
    album = '';
    tone = '';
    family = '';
    group = '';
    moment = '';
    identifier = string(filename_dest{filedest_cont});
    review_date = regexprep(date,'-','_');
    transwriter = 'DarioMangoni';
    videoURL = '';
%     preamble = ['%titolo{',title,'}',...
%                 '%autore{',author,'}\n',...
%                 '%album{',album,'}\n',...
%                 '%tonalita{',tone,'}\n',...
%                 '%famiglia{',family,'}\n',...
%                 '%gruppo{',group,'}\n',...
%                 '%momenti{',moment,'}\n',...
%                 '%identificatore{',identifier,'}\n',...
%                 '%data_revisione{',review_date,'}\n',...
%                 '%trascrittore{',transwriter,'}\n',...
%                 '%video{',videoURL,'}\n'];
    
    fid_destination = fopen([destination_folder, filename_dest{filedest_cont},'.tex'], 'w');
    fprintf(fid_destination, '%s\n', join(['%titolo{',title,'}'], ''),...
                                        join(['%autore{',author,'}'], ''),...
                                        join(['%album{',album,'}'], ''),...
                                        join(['%tonalita{',tone,'}'], ''),...
                                        join(['%famiglia{',family,'}'], ''),...
                                        join(['%gruppo{',group,'}'], ''),...
                                        join(['%momenti{',moment,'}'], ''),...
                                        join(['%identificatore{',identifier,'}'], ''),...
                                        join(['%data_revisione{',review_date,'}'], ''),...
                                        join(['%trascrittore{',transwriter,'}'], ''),...
                                        join(['%video{',videoURL,'}'], ''));
    fprintf(fid_destination, '%s', source_text);
    fclose(fid_destination);
            
    filedest_cont = filedest_cont+1;
end
filedest_cont = filedest_cont-1;

%% create CanzoniSparse.tex that lists all the songs
fid = fopen([destination_folder,'CanzoniSparse.tex'], 'w');
filename_dest = sort(filename_dest(~cellfun('isempty',filename_dest)));
for file_cont = 1:filedest_cont
    fprintf(fid, '\\input{"songs/%s"}\n', filename_dest{file_cont});
end

fclose(fid);


cd(bkp_folder);