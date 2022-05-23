function ERWiN
%ERWiN() - Electrode Reconstruction Widget for Neuroimaging
%   This GUI widget was created to locate stereo-EEG contact coordinates.
%   
%   Version:        0.5
%   Contact:        jonathan.monney@unige.ch
%   Last Update:    20/05/2022
%
%   Current Version Updates:
%       - GUI created that allows i-EEG electrode location estimation based
%         on the deepest contact's position and a second contact position
%         placed on the electrode's shaft.
%         Required parameters for each electrode are Name, Number of
%         Contacts, Distance Between Contacts (mm), Deepest Contact's
%         Coordinates, Second Contact Coordinates.
%       - "Snapping", when enabled, searches for the voxel with the highest
%         intensity in a 2x2x2 volumetric kernel (to more accurately place 
%         the electrode's contact).
%       - A T1 file may also be loaded to anatomically compare electrode 
%         locations with patient's pre-implantation scan (optional).
%       - Glassbrain is a graphical output that displays located electrodes
%         and a mesh of the CT (and/or T1) volume.
%       - Rotation and permutation buttons added. (V0.1)
%       - Output .mgrids may be viewed in BioImage Suite 3.0
%       - Fixed bug wrgds to color assignment
%          
%       Note: electrode parameters may only be modified or updated in the
%       CT tab. After updating any electrode parameters, estimation must be
%       re-run in order to update contact locations. At this point, only
%       depth electrodes may be created (no grids or strips).
% 
%   Future Version Updates:
%       - Rotation and permutation transformations must be taken into
%         coordinate account for contacts.
%       - Add option to not save Mgrid file.
%       - Add option to save .txt file compatible with final BioImageSuite
%         output file.
%       - Add option to create "grid" electrodes.
%       - Add option to create "strip" electrodes.
%
%   Created by J.P.Monney - Human Neuron Lab (Université de Genève)



% ======================================================================= %
% ========================== ENVIRONMENT SET-UP ========================= %
% ======================================================================= %

clearvars
clc

% ----------- Check all subfolders & functions added to path ------------ %

scriptPath = fileparts(which(mfilename));
if ~contains(path,genpath(scriptPath))
    addpath(genpath(scriptPath));
    if isfolder([scriptPath filesep 'ARCHIVE'])
        rmpath(genpath([scriptPath filesep 'ARCHIVE']));
    end
    savepath;
end
if contains(path,genpath([scriptPath filesep 'ARCHIVE']))
    rmpath(genpath([scriptPath filesep 'ARCHIVE']));
    savepath;
end

% --------------- Verify all required add-ons are installed ------------- %

addonsCheck();

% ----------- Check for new Git commits (bug fixes & updates) ----------- %

gitAutoUpdate();

% --------------- Main figure & output variable declaration ------------- %

widget              = [];
fig_title           = sprintf('ERWiN - by Human Neuron Lab');
screen_offset       = os_offset();
monitorSize         = get(groot,'MonitorPositions');
[numMonitors,~]     = size(monitorSize);
screenSize          = monitorSize(numMonitors,:);
fig_height          = 0.92*screenSize(4);
fig_width           = round(fig_height + (290 * 2));% screenSize(3) - 40;
fig_distfromLeft    = screenSize(1) + (screenSize(3)-fig_width)/2;
fig_distfromBottom  = screenSize(2) + screen_offset;
fig_size            = [fig_distfromLeft,...
                       fig_distfromBottom,...
                       fig_width,...
                       fig_height];

widget.fig          = uifigure('Name',fig_title,...
                               'Position',fig_size,...
                               'Color',[0.5,0.5,0.5],...
                               'Pointer','watch');
widget              = update_outputData(widget);
drawnow

[widget,wip]        = drawCentralPanel(widget);
widget              = drawLeftPanel(widget,wip);
widget              = drawRightPanel(widget,wip);
widget              = logoDisplay(widget,scriptPath);

widget.fig.Pointer  = 'arrow';
drawnow


% ======================================================================= %
% ======================== CALLBACK DEFINITIONS ========================= %
% ======================================================================= %

widget              = defineCallbacks(widget);                  %#ok<NASGU>

% ======================================================================= %
% ========================== LOCAL FUNCTIONS ============================ %
% ======================================================================= %

function offset = os_offset

    if ispc
        os = 'pc';
    elseif ismac
        os = 'mac';
    elseif islinux
        os = 'linux';
    end
    
    switch os
        case 'pc'
            offset = 50;
        case {'mac','linux'}
            offset = 0;
    end

end

function addonsCheck

    addonsInstalled = matlab.addons.installedAddons;
    addonsNames = addonsInstalled(:,1);

    % Format: {'Toolbox Name','functionUsed()','script it appears in'; 
    %          ...}
    addonsRequired = ...
        {'Statistics and Machine Learning Toolbox','pdist2()','estimateButtonPushed.m'};
    addonsMissing = zeros(length(addonsRequired),1);
    [sAddonsRequired,~] = size(addonsRequired);
    [sAddonsNames,~] = size(addonsNames);
    for j = 1:sAddonsRequired
        for i = 1:sAddonsNames
            if isequal(addonsNames{i,1},addonsRequired{j,1})
                break
            elseif i == height(addonsNames)
                addonsMissing(j) = 1;
            end
        end
    end

    numMissingAddons = sum(addonsMissing);
    if numMissingAddons ~= 0
        msg1 = ['<strong>Add-On requirements missing for ERWiN (', ...
            num2str(numMissingAddons), ') :</strong>\n\n'];
        fprintf(2,msg1);
        for l = 1:height(addonsMissing)
            if addonsMissing(l) == 1
                msg2 = ['<strong>\t- ', addonsRequired{l,1}, '</strong> ' ...
                    '(used for ', addonsRequired{l,2}, ...
                    ' -> "', addonsRequired{l,3}, '")\n\n'];
                fprintf(1,msg2);
            end
        end
        
        % To display the link to download the toolbox, force an error:
        if addonsMissing(1) == 1
            pdist2;
        end
    end
end

function widget = logoDisplay(widget,scriptPath)
    logoPath = [scriptPath filesep 'assets' filesep 'UNIGE_logo.png'];
    widget.logoUnige = uiimage('Parent',widget.fig,'ImageSource',logoPath,...
        'Position',[10 10 270 127]);
end

end
  