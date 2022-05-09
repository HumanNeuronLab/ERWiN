function gitAutoUpdate(wVersion)
    try
        % Test if there is an internet connection
        java.net.InetAddress.getByName('www.google.com');
    catch
        return
    end
    
    % Test if git is installed
    [status,~] = system('git');
    currDir = pwd;
    if status ~= 0
        % Get directory to current  script
        scriptPath = fileparts(which('ERWiN.m'));
        cd(scriptPath);
        
        if isfolder([scriptPath filesep '.git']) % if git dir already created
            % Check for any news commits
            [status,~] = system('git fetch');

            if status ~= 0 % if new commits found
                % Archive current version of ERWiN prior to update
                if ~isfolder([scriptPath filesep 'ARCHIVE'])
                    mkdir(scriptPath, 'ARCHIVE');
                end
                incrNumb = 1;
                archDir = ['V_' wVersion 'x' num2str(incrNumb)];
                while isfolder(['ARCHIVE' filesep archDir])
                    incrNumb = incrNumb + 1;
                    archDir = ['V_' wVersion 'x' num2str(incrNumb)];
                end
                mkdir([scriptPath '/ARCHIVE'], archDir);
                listDir = dir(scriptPath);
                j = 1;
                for i = 1:length(listDir)
                    if ~isequal(listDir(i).name, 'ARCHIVE') && ...
                            ~startsWith(listDir(i).name, '.')
                        listMove{j} = listDir(i).name;
                        j = j+1;
                    end
                end
                for i = 1:length(listMove)
                    movefile([scriptPath filesep listMove{i}],...
                        [scriptPath filesep 'ARCHIVE' filesep archDir]);
                end
                % Pull updated files
                !git pull origin main
                open([scriptPath filesep 'ERWiN.m']);
            end
    
        else
            % Need to make this directory a git directory
            system(['git init ' scriptPath ' -b main']);
            % Add remote repository
            !git remote add origin git@github.com:HumanNeuronLab/ERWiN.git
            % Archive current version of ERWiN prior to update
            if ~isfolder([scriptPath filesep 'ARCHIVE'])
                mkdir(scriptPath, 'ARCHIVE');
            end
            incrNumb = 1;
            archDir = ['V_' wVersion 'x' num2str(incrNumb)];
            while isfolder(['ARCHIVE' filesep archDir])
                incrNumb = incrNumb + 1;
                archDir = ['V_' wVersion 'x' num2str(incrNumb)];
            end
            mkdir([scriptPath filesep 'ARCHIVE'], archDir);
            listDir = dir(scriptPath);
            j = 1;
            for i = 1:length(listDir)
                if ~isequal(listDir(i).name, 'ARCHIVE') && ...
                        ~startsWith(listDir(i).name, '.')
                    listMove{j} = listDir(i).name;
                    j = j+1;
                end
            end
            for i = 1:length(listMove)
                movefile([scriptPath filesep listMove{i}],...
                    [scriptPath filesep 'ARCHIVE' filesep archDir]);
            end
            % Pull updated files
            !git pull origin main
        end
        cd(currDir);
        fid = fopen([scriptPath filesep 'readme.txt']);
        readMeText = fscanf(fid,'%s');
        vStr = 'CurrentVersion:';
        idx = strfind(readMeText,vStr);
        widgetVersion = readMeText(idx+length(vStr):idx+length(vStr)+2);
        fprintf(['\n\n<strong>Current version (v' widgetVersion ...
            ') of ERWiN is up-to-date!</strong>\n\n']);
    else
        disp(['Try installing Git to get automatic ' ...
            'ERWiN bug fixes and updates!']);
    end
end
