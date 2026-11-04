% Legacy Webots R2021b compatibility hook for MATLAB R2026 and newer.
% It is inert during ordinary MATLAB sessions.
% R2025a uses the project launcher and must keep its cached prototype so a
% reset does not rebuild a thunk library that another process may still hold.
if ~isempty(getenv('WEBOTS_CONTROLLER_NAME')) && strcmp(getenv('WEBOTS_VERSION'), 'R2021b')
    matlabRelease = version('-release');
    if str2double(matlabRelease(1:4)) >= 2026
        prototype = strrep(strrep(['protofile_matlab_' matlabRelease ...
            '_webots_' getenv('WEBOTS_VERSION')], '.', '_'), ' ', '_');
        prototypePath = fullfile(tempdir, [prototype '.m']);
        if isfile(prototypePath)
            delete(prototypePath);
        end
    end
end
