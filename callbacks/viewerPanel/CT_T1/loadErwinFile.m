function loadErwinFile(~,~,widget)
    [file,path] = uigetfile({'*_erwin.mat'},'Select ERWiN autosave file',widget.glassbrain.UserData.filePath);
    load([path file]);
    widget.tree_Summary.Children.delete
    for i = 1:length(fieldnames(autosave.electrode))
        field = ['Electrode' num2str(i)];
        widget.fig.UserData.(field) = autosave.electrode.(field);
        widget = createTreeNode(widget,widget.tree_Summary,field);
        widget = checkStatus(field,widget,0);
        try
            widget.params.dropdown_ElectrodeSelector.Items{i} = autosave.electrode.(field).Name;
        catch
            widget.params.dropdown_ElectrodeSelector.Items{i} = ['Electrode' num2str(i)];
        end

        if isfield(autosave,'glassbrain') && isfield(autosave.glassbrain,field)
            widget.glassbrain.UserData.electrodes.(field) = autosave.glassbrain.(field);
        end
    end
    widget.params.spinner_NumElectrodes = i;
    evt.Value = widget.params.dropdown_ElectrodeSelector.Items{i};
    data = widget.params.dropdown_ElectrodeSelector;
    widget.params.dropdown_ElectrodeSelector.Value = evt.Value;
    widget.tree_Summary.SelectedNodes = widget.tree_Summary.Children(i);
    electrodeSelectionChanged(data,evt,widget)
    widget.glassbrain.UserData.filePath = autosave.filePath;
    widget.glassbrain.UserData.patientID = autosave.patientID;
    
end