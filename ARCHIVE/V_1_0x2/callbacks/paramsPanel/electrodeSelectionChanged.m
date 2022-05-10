function electrodeSelectionChanged(data,evt,widget)
    

    collapse(widget.tree_Summary);
    field = find(contains(data.Items,evt.Value));
    field = ['Electrode' num2str(field)];
    try
        expand(widget.tree.UserData.(field).electrodeName);
    catch
        warning('This electrode has an abbreviated name from another electrode. Please change the name.')
        return
    end
    try
        if isempty(widget.tree_Summary.SelectedNodes) || ~(isequal(data.Value,widget.tree_Summary.SelectedNodes.Text))
           if isnan(str2double(widget.tree_Summary.SelectedNodes.Text(9)))
                currElectrode = find(contains(data.Items,data.Value));
                widget.tree_Summary.SelectedNodes = widget.tree_Summary.Children(currElectrode);
           end
        end
        if ~isnan(str2double(widget.tree_Summary.SelectedNodes.Text(9:10))) ||...
                ~isnan(str2double(widget.tree_Summary.SelectedNodes.Text(9)))
            if ~isnan(str2double(widget.tree_Summary.SelectedNodes.Text(9:10)))
                Value = str2double(widget.tree_Summary.SelectedNodes.Text(9:10));
            else
                Value = str2double(widget.tree_Summary.SelectedNodes.Text(9));
            end
            widget.label_contacts_CT.Text = ['Contact ' num2str(Value) ': ' mat2str(round(widget.fig.UserData.(field).contact(Value,:)))];
            widget.slider_X_CT.Value = round(widget.fig.UserData.(field).contact(Value,1));
            widget.slider_Y_CT.Value = round(widget.fig.UserData.(field).contact(Value,2));
            widget.slider_Z_CT.Value = round(widget.fig.UserData.(field).contact(Value,3));
        
            artificialEvent.Value = widget.slider_X_CT.Value;
            sliderValueChanging(widget.slider_X_CT,artificialEvent,widget);
            artificialEvent.Value = widget.slider_Y_CT.Value;
            sliderValueChanging(widget.slider_Y_CT,artificialEvent,widget);
            artificialEvent.Value = widget.slider_Z_CT.Value;
            sliderValueChanging(widget.slider_Z_CT,artificialEvent,widget);
            [n_contacts,~]  = size(widget.fig.UserData.(field).contact);
            widget.slider_contacts_CT.Limits = [1 n_contacts];
            widget.slider_contacts_CT.MajorTicks = (1:n_contacts);
            widget.slider_contacts_CT.Value = Value;
            widget.slider_contacts_CT.Visible = 'on';
            widget.label_contacts_CT.Visible = 'on';
            widget.button_correctContacts.Visible = 'on';
            if Value ~= 1
                widget.button_correctContacts.Enable = 'on';
            else
                widget.button_correctContacts.Enable = 'off';
            end
        else
            expand(widget.tree.UserData.(field).contacts);
            [n_contacts,~]  = size(widget.fig.UserData.(field).contact);
            widget.slider_contacts_CT.Limits = [1 n_contacts];
            widget.slider_contacts_CT.MajorTicks = (1:n_contacts);
            widget.slider_contacts_CT.Value = 1;
            widget.slider_contacts_CT.Visible = 'on';
            widget.label_contacts_CT.Text = ['Contact 1: ' mat2str(widget.fig.UserData.(field).contact(1,:))];
            widget.label_contacts_CT.Visible = 'on';
            widget.button_correctContacts.Enable = 'off';
            widget.button_correctContacts.Visible = 'on';
        end
    catch
        widget.slider_contacts_CT.Visible = 'off';
        widget.label_contacts_CT.Visible = 'off';
        widget.button_correctContacts.Visible = 'off';
    end
    try
        widget.params.field_ElectrodeName.Value = widget.fig.UserData.(field).Name(4:end);
        hemisphere = ['radio_' widget.fig.UserData.(field).Name(1)];
        widget.params.(hemisphere).Value = true;
    catch
        widget.params.field_ElectrodeName.Value = field;
        widget.params.radio_R.Value = true;
    end
    try
        widget.params.field_NumContacts.Value = widget.fig.UserData.(field).numContacts;
    catch
        widget.params.field_NumContacts.Value = 0;
    end
    try
        widget.params.field_ContactDistance.Value = widget.fig.UserData.(field).contactDist;
    catch
        widget.params.field_ContactDistance.Value = 0;
    end
    try
        widget.params.field_XDeepest.Value = widget.fig.UserData.(field).deepestCoord(1);
        widget.params.field_YDeepest.Value = widget.fig.UserData.(field).deepestCoord(2);
        widget.params.field_ZDeepest.Value = widget.fig.UserData.(field).deepestCoord(3);
    catch
        widget.params.field_XDeepest.Value = 0;
        widget.params.field_YDeepest.Value = 0;
        widget.params.field_ZDeepest.Value = 0;
    end
    try
        widget.params.field_XSecond.Value = widget.fig.UserData.(field).secondCoord(1);
        widget.params.field_YSecond.Value = widget.fig.UserData.(field).secondCoord(2);
        widget.params.field_ZSecond.Value = widget.fig.UserData.(field).secondCoord(3);
    catch
        widget.params.field_XSecond.Value = 0;
        widget.params.field_YSecond.Value = 0;
        widget.params.field_ZSecond.Value = 0;
    end
    widget = checkStatus(field,widget);
    
end