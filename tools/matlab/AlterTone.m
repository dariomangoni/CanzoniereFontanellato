clear variables
close all
clc

altertone = -2;

[filename, filepath] = uigetfile('*.tex','Open TEX file');

fid = fopen([filepath, filename], 'r');
text = fileread([filepath, filename]);
frewind(fid);

% chord_scale{1} = {'La'};
% chord_scale{2} = {'Si&', 'La#'};
% chord_scale{3} = {'Si'};
% chord_scale{4}= {'Do'};
% chord_scale{5} = {'Do#', 'Re&'};
% chord_scale{6} = {'Re'};
% chord_scale{7} = {'Re#', 'Mi&'};
% chord_scale{8} = {'Mi'};  
% chord_scale{9} = {'Fa'};
% chord_scale{10} = {'Fa#' , 'Sol&'};
% chord_scale{11} = {'Sol'};
% chord_scale{12} = {'Sol#', 'La&'};

chord_scale{1} = {'A'};
chord_scale{2} = {'B&', 'A#'};
chord_scale{3} = {'B'};
chord_scale{4}= {'C'};
chord_scale{5} = {'C#', 'D&'};
chord_scale{6} = {'D'};
chord_scale{7} = {'D#', 'E&'};
chord_scale{8} = {'E'};
chord_scale{9} = {'F'};
chord_scale{10} = {'F#' , 'G&'};
chord_scale{11} = {'G'};
chord_scale{12} = {'G#', 'A&'};


captures_cell = {};
for chord_sel = 1:length(chord_scale)
    for opt_sel = 1:length(chord_scale{chord_sel})
        captures_cell{end+1} = chord_scale{chord_sel}{opt_sel};
    end
end

captures_cell = strjoin(string(flip(sort(captures_cell))));
captures_cell = regexprep(captures_cell, '\s', '|');
captures = ['(',char(captures_cell),')'];

[tokenExt, tokens] = regexp(text, ['\\\[',captures,'.*?\]'], 'tokenExtents', 'tokens');
start_end_tokens = reshape(cell2mat(tokenExt), 2, length(tokenExt))';
startTok = start_end_tokens(:,1);
endTok = start_end_tokens(:,2);
for match_sel = 1:length(tokens)
    chord_found = false;
    for chord_sel = 1:length(chord_scale)
        for opt_sel = 1:length(chord_scale{chord_sel})
            if strcmp(chord_scale{chord_sel}{opt_sel}, tokens{match_sel})
                new_chord_sel = chord_sel + altertone;
                if new_chord_sel < 1
                    new_chord_sel = new_chord_sel + 12;
                end
                if new_chord_sel > 12
                    new_chord_sel = rem(new_chord_sel, length(chord_scale));
                end
%                 text(startTok(match_sel): endTok(match_sel))
%                 chord_scale{new_chord_sel}{1}
                text = [text(1:startTok(match_sel)-1), chord_scale{new_chord_sel}{1}, text(endTok(match_sel)+1:end)];
                shifting = length(chord_scale{new_chord_sel}{1}) - (endTok(match_sel) - startTok(match_sel) +1) ;
%                 shifting
                endTok(match_sel:end) = endTok(match_sel:end) + shifting;
                startTok(match_sel+1:end) = startTok(match_sel+1:end) + shifting;
                chord_found = true;
                break
            end

        end
        if chord_found
            break
        end
    end
end


% for row_sel = 1
% end

fclose(fid);
fid = fopen([filepath, filename], 'w');
fprintf(fid, '%s', text);
fclose(fid);