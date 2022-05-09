function contactCorrect(~,~,widget)
    
    idx = find(contains(widget.params.dropdown_ElectrodeSelector.Items,widget.params.dropdown_ElectrodeSelector.Value));
    field = ['Electrode' num2str(idx)];
    currContact = sliderContacts.Value;
    X = widget.field_Xvalue_CT;
    Y = widget.field_Xvalue_CT;
    Z = widget.field_Xvalue_CT;
    widget.fig.UserData.(field).contact(currContact,1) = X;
    widget.fig.UserData.(field).contact(currContact,2) = Y;
    widget.fig.UserData.(field).contact(currContact,3) = Z;
    widget.glassbrain.UserData.electrodes.(field).coord(currContact,:) = widget.fig.UserData.(field).contact(currContact,:);
    widget.glassbrain.UserData.electrodes.Electrode1.ElectrodevolView.XData(currContact) = widget.glassbrain.UserData.electrodes.(field).coord(currContact,1);
    widget.glassbrain.UserData.electrodes.Electrode1.ElectrodevolView.YData(currContact) = widget.glassbrain.UserData.electrodes.(field).coord(currContact,2);
    widget.glassbrain.UserData.electrodes.Electrode1.ElectrodevolView.ZData(currContact) = widget.glassbrain.UserData.electrodes.(field).coord(currContact,3);
    widget.tree.UserData.(field).contacts.Children(currContact).Text = ['Contact ' num2str(currContact) ': ' mat2str(widget.fig.UserData.(field).contact(currContact,:))];
    widget.tree_Summary.SelectedNodes = widget.tree.UserData.(field).contacts.Children(currContact);

end