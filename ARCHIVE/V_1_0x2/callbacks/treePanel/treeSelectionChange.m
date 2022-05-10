function treeSelectionChange(~,evt,widget)
    
    currentTab = widget.panel_CentralTabsMRI.SelectedTab.Tag;
    switch currentTab
        case 'CT'
            slider_contacts = widget.slider_contacts_CT;
            label_contacts = widget.label_contacts_CT;
            field_Xvalue1 = widget.field_Xvalue_CT;
            field_Yvalue1 = widget.field_Yvalue_CT;
            field_Zvalue1 = widget.field_Zvalue_CT;
            slider_x1 = widget.slider_X_CT;
            slider_y1 = widget.slider_Y_CT;
            slider_z1 = widget.slider_Z_CT;
            ax1 = widget.ax_sliceView1_CT;
            ax2 = widget.ax_sliceView2_CT;
            ax3 = widget.ax_sliceView3_CT;
            labelVI = widget.label_voxelIntensity_CT;
            button_correctContacts = widget.button_correctContacts;
            artificial_evt.Value = widget.params.dropdown_ElectrodeSelector.Items(str2double(evt.SelectedNodes.Tag(10:end)));
            widget.params.dropdown_ElectrodeSelector.Value = {artificial_evt.Value};
            electrodeSelectionChanged(widget.params.dropdown_ElectrodeSelector,...
                artificial_evt,widget);
        case 'T1'
            if ~(isequal(widget.panel_CentralTabsMRI.SelectedTab.Title,'[select Anatomical NIfTI file (optional)]'))
                slider_contacts = widget.slider_contacts_T1;
                label_contacts = widget.label_contacts_T1;
                field_Xvalue1 = widget.field_Xvalue_T1;
                field_Yvalue1 = widget.field_Yvalue_T1;
                field_Zvalue1 = widget.field_Zvalue_T1;
                slider_x1 = widget.slider_X_T1;
                slider_y1 = widget.slider_Y_T1;
                slider_z1 = widget.slider_Z_T1;
                ax1 = widget.ax_sliceView1_T1;
                ax2 = widget.ax_sliceView2_T1;
                ax3 = widget.ax_sliceView3_T1;
                labelVI = widget.label_voxelIntensity_T1;
                button_correctContacts = widget.button_correctContacts;
            else
                widget.panel_Centralwidget.panel_CentralTabsMRIMRI.SelectedTab = widget.tab_CT;
                slider_contacts = widget.slider_contacts_CT;
                label_contacts = widget.label_contacts_CT;
                field_Xvalue1 = widget.field_Xvalue_CT;
                field_Yvalue1 = widget.field_Yvalue_CT;
                field_Zvalue1 = widget.field_Zvalue_CT;
                slider_x1 = widget.slider_X_CT;
                slider_y1 = widget.slider_Y_CT;
                slider_z1 = widget.slider_Z_CT;
                ax1 = widget.ax_sliceView1_CT;
                ax2 = widget.ax_sliceView2_CT;
                ax3 = awidget.x_sliceView3_CT;
                labelVI = widget.label_voxelIntensity_CT;
                button_correctContacts = widget.button_correctContacts;
            end
            artificial_evt.Value = widget.params.dropdown_ElectrodeSelector.Items(str2double(evt.SelectedNodes.Tag(10:end)));
            widget.params.dropdown_ElectrodeSelector.Value = {artificial_evt.Value};
            electrodeSelectionChanged(widget.params.dropdown_ElectrodeSelector,...
                artificial_evt,widget)
        case 'glassbrain'
            try
                currElectrode = evt.SelectedNodes.Tag;
                if ~(isempty(evt.PreviousSelectedNodes))
                    prevElectrode = evt.PreviousSelectedNodes.Tag;
                    widget.glassbrain.UserData.electrodes.(prevElectrode).ElectrodevolView.LineWidth = 1.5;
                    widget.glassbrain.UserData.electrodes.(prevElectrode).ElectrodevolView.Marker = '.';
                    widget.glassbrain.UserData.electrodes.(prevElectrode).ElectrodevolView.MarkerSize = 3;
                    widget.glassbrain.UserData.electrodes.(prevElectrode).ElectrodevolView.MarkerFaceColor = widget.glassbrain.UserData.electrodes.(prevElectrode).Color;
                end
                if ~(isnan(str2double(evt.SelectedNodes.Text(9:10)))) || ...
                        ~(isnan(str2double(evt.SelectedNodes.Text(9))))
                    verifier = ~(isnan(str2double(evt.SelectedNodes.Text(9:10))));
                    switch verifier
                        case true
                            currContact = str2double(evt.SelectedNodes.Text(9:10));
                        case false
                            currContact = str2double(evt.SelectedNodes.Text(9));
                    end
                    
                    if ~(isfield(widget.glassbrain.UserData,'highlightedContact'))
                        widget.glassbrain.UserData.highlightedContact.coord = widget.fig.UserData.(currElectrode).contact(currContact,:);
                        hold(widget.glassbrain.UserData.axes,'on');
                        widget.glassbrain.UserData.highlightedContact.point = ...
                            scatter3(widget.glassbrain.UserData.highlightedContact.coord(1),...
                            widget.glassbrain.UserData.highlightedContact.coord(2),...
                            widget.glassbrain.UserData.highlightedContact.coord(3),'Parent',widget.glassbrain.UserData.axes);
                        widget.glassbrain.UserData.highlightedContact.point.MarkerFaceColor = [1 1 1];
                        widget.glassbrain.UserData.highlightedContact.point.MarkerEdgeColor = widget.glassbrain.UserData.electrodes.(currElectrode).Color;
                        widget.glassbrain.UserData.highlightedContact.point.Marker = 'o';
                        widget.glassbrain.UserData.highlightedContact.point.SizeData = 40;
                    else
                        widget.glassbrain.UserData.highlightedContact.point.MarkerEdgeColor = widget.glassbrain.UserData.electrodes.(currElectrode).Color;
                        widget.glassbrain.UserData.highlightedContact.coord = widget.fig.UserData.(currElectrode).contact(currContact,:);
                        widget.glassbrain.UserData.highlightedContact.point.XData = widget.glassbrain.UserData.highlightedContact.coord(1);
                        widget.glassbrain.UserData.highlightedContact.point.YData = widget.glassbrain.UserData.highlightedContact.coord(2);
                        widget.glassbrain.UserData.highlightedContact.point.ZData = widget.glassbrain.UserData.highlightedContact.coord(3);
                    end
                    widget.glassbrain.UserData.highlightedContact.point.Visible = 'on';
                    widget.glassbrain.UserData.electrodes.(currElectrode).ElectrodevolView.LineWidth = 1;
                    widget.glassbrain.UserData.electrodes.(currElectrode).ElectrodevolView.Marker = 'o';
                    widget.glassbrain.UserData.electrodes.(currElectrode).ElectrodevolView.MarkerSize = 3;
                else
                    widget.glassbrain.UserData.electrodes.(currElectrode).ElectrodevolView.LineWidth = 1;
                    widget.glassbrain.UserData.electrodes.(currElectrode).ElectrodevolView.Marker = 'o';
                    widget.glassbrain.UserData.electrodes.(currElectrode).ElectrodevolView.MarkerSize = 4;
                    widget.glassbrain.UserData.electrodes.(currElectrode).ElectrodevolView.MarkerFaceColor = [1 1 1];
                    if isfield(widget.glassbrain.UserData,'highlightedContact')
                        widget.glassbrain.UserData.highlightedContact.point.Visible = 'off';
                    end
                end
                widget.glassbrain.UserData.buttonColor.Enable = 'on';
                widget.glassbrain.UserData.lampColor.Enable = 'on';
                widget.glassbrain.UserData.lampColor.Color = widget.glassbrain.UserData.electrodes.(currElectrode).Color;
            catch
                return
            end
    end
    
    
    
end