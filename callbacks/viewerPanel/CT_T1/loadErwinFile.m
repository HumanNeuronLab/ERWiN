function loadErwinFile(~,~,fileName,widget)
    load(fileName);
    for i = 1:length(fieldnames(autosave.electrodes))
        field = ['Electrode' num2str(i)];
        widget.fig.Userdata.(field) = autosave.electrode.(field);
        widget.glassbrain.UserData.filePath = autosave.filePath;
        widget.glassbrain.UserData.patientID = autosave.patientID;
        if isfield(autosave,glassbrain)
            widget.glassbrain.UserData.electrodes.(field) = autosave.glassbrain.(field);
        end
    end

end