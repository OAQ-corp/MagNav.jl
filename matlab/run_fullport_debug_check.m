function results = run_fullport_debug_check()
%RUN_FULLPORT_DEBUG_CHECK Parse-level smoke check for generated MATLAB ports.
%   results = run_fullport_debug_check()
%
%   How to run (MATLAB):
%     addpath(genpath('matlab'));
%     results = run_fullport_debug_check;
%
%   This function attempts to run CHECKCODE (if available) over all generated
%   files under +magnav_fullport and summarizes parser/lint messages.

    root = fileparts(mfilename('fullpath'));
    fullport_dir = fullfile(root, '+magnav_fullport');
    files = dir(fullfile(fullport_dir, '*.m'));

    results = struct();
    results.total_files = numel(files);
    results.checked_files = 0;
    results.warning_files = 0;
    results.messages = struct('file', {}, 'count', {});

    has_checkcode = exist('checkcode', 'file') == 2;

    for k = 1:numel(files)
        p = fullfile(files(k).folder, files(k).name);
        if has_checkcode
            msgs = checkcode(p, '-id'); %#ok<CHECKCODE>
            results.checked_files = results.checked_files + 1;
            if ~isempty(msgs)
                results.warning_files = results.warning_files + 1;
                results.messages(end+1).file = files(k).name; %#ok<AGROW>
                results.messages(end).count = numel(msgs);
            end
        end
    end

    if ~has_checkcode
        warning('checkcode is not available in this MATLAB/Octave environment.');
    end

    fprintf('Fullport files: %d\n', results.total_files);
    fprintf('Checked files : %d\n', results.checked_files);
    fprintf('Warn files    : %d\n', results.warning_files);
end
