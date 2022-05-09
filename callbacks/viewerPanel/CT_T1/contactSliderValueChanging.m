function contactSliderValueChanging(data,evt,widget)

    idx = find(contains(widget.params.dropdown_ElectrodeSelector.Items, widget.params.dropdown_ElectrodeSelector.Value));
    field = ['Electrode' num2str(idx)];
    Value = round(evt.Value);

    switch widget.panel_CentralTabsMRI.SelectedTab.Tag
        case 'CT'
            slider_x = widget.slider_X_CT;
            slider_y = widget.slider_Y_CT;
            slider_z = widget.slider_Z_CT;
            label_contacts = widget.label_contacts_CT;
            data.Value = Value;
            if Value ~= 1
                widget.button_correctContacts.Enable = 'on';
            else
                widget.button_correctContacts.Enable = 'off';
            end
        case 'T1'
            slider_x = widget.slider_X_T1;
            slider_y = widget.slider_Y_T1;
            slider_z = widget.slider_Z_T1;
            label_contacts = widget.label_contacts_T1;
    end 

    
    widget.tree_Summary.SelectedNodes = widget.tree.UserData.(field).contacts.Children(Value);
    
    label_contacts.Text = ['Contact ' num2str(Value) ': ' mat2str(round(widget.fig.UserData.(field).contact(Value,:)))];
    slider_x.Value = round(widget.fig.UserData.(field).contact(Value,1));
    slider_y.Value = round(widget.fig.UserData.(field).contact(Value,2));
    slider_z.Value = round(widget.fig.UserData.(field).contact(Value,3));

    artificialEvent.Value = slider_x.Value;
    slider_valueChanging(slider_x,artificialEvent,widget);
    artificialEvent.Value = slider_y.Value;
    slider_valueChanging(slider_y,artificialEvent,widget);
    artificialEvent.Value = slider_z.Value;
    slider_valueChanging(slider_z,artificialEvent,widget);

end