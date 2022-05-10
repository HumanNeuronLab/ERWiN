function electrodeNameChanged(~,evt,widget)

    idx = find(contains(widget.params.dropdown_ElectrodeSelector.Items,widget.params.dropdown_ElectrodeSelector.Value));
    field = ['Electrode' num2str(idx)];
    if contains(evt.Value, ' ') || contains(evt.Value, '_')
        warning('Electrode name may not contains spaces or underscores.')
        widget.params.label_NameAcceptance.Text = ['Warning: rename electrode!' newline 'Electrode name may not contains spaces or underscores.'];
        widget.params.label_NameAcceptance.Visible = 'on';
        widget.params.label_NameAcceptance.FontColor = [1,0.65,0];
        widget.params.field_ElectrodeName.BackgroundColor = [1,0.95,0.95];
        widget.params.field_ElectrodeName.Value = evt.PreviousValue;
    elseif length(find(contains(widget.params.dropdown_ElectrodeSelector.Items, evt.Value))) > 1
        warning('This names is an abbreviated version of another electrode. Please change one of the names.')
        widget.params.label_NameAcceptance.Text = ['Warning: rename electrode!' newline 'Another electrode has this name or a longer version of it.'];
        widget.params.label_NameAcceptance.Visible = 'on';
        widget.params.label_NameAcceptance.FontColor = [1,0.65,0];
        widget.params.field_ElectrodeName.BackgroundColor = [1,0.95,0.95];
        widget.params.field_ElectrodeName.Value = evt.PreviousValue;
    else
        widget.params.label_NameAcceptance.Visible = 'off';
        widget.params.field_ElectrodeName.BackgroundColor = [1,1,1];
        widget.tree.UserData.(field).electrodeName.Text = [widget.params.radiogroup1.SelectedObject.Text ...
            widget.params.radiogroup2.SelectedObject.Text '_' evt.Value];
        widget.params.dropdown_ElectrodeSelector.Items{idx} = [widget.params.radiogroup1.SelectedObject.Text ...
            widget.params.radiogroup2.SelectedObject.Text '_' evt.Value];
        widget.params.dropdown_ElectrodeSelector.Value = widget.params.dropdown_ElectrodeSelector.Items{idx};
        widget.fig.UserData.(field).Name = [widget.params.radiogroup1.SelectedObject.Text ...
            widget.params.radiogroup2.SelectedObject.Text '_' evt.Value];
    end
    widget = checkStatus(field,widget);
end