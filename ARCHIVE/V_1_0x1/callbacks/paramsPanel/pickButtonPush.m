function pickButtonPush(data,~,widget)

    vol = widget.glassbrain.UserData.CTvol;
    idx = find(contains(widget.params.dropdown_ElectrodeSelector.Items,widget.params.dropdown_ElectrodeSelector.Value));
    field = ['Electrode' num2str(idx)];
    if isequal(widget.fig.UserData.(field).Estimation, 'SUCCESS')
        widget.fig.UserData.(field).Estimation = 'RE-ESTIMATE';
    end
    if widget.params.checkbox_Snapping.Value == 1
        kernel = [2 2 2];
        X = widget.field_Xvalue_CT.Value;
        Y = widget.field_Yvalue_CT.Value;
        Z = widget.field_Zvalue_CT.Value;
        kernel_vol = vol(Y-kernel(1):Y+kernel(1),...
            X-kernel(2):X+kernel(2),Z-kernel(3):Z+kernel(3));
        val = max(max(max(kernel_vol)));
        flag = false;
        for x = 1:length(kernel_vol(1,:,:))
            for y = 1:length(kernel_vol(:,1,:))
                for z = 1:length(kernel_vol(:,:,1))
                    if kernel_vol(x,y,z) == val
                        flag = true;
                        break
                    end
                end
                if flag == true
                    break
                end
            end
            if flag == true
                break
            end
        end
        x_out = X + (y - (1+kernel(1)));
        y_out = Y + (x - (1+kernel(2)));
        z_out = Z + (z - (1+kernel(3)));
        widget.field_Xvalue_CT.Value = x_out;
        widget.field_Yvalue_CT.Value = y_out;
        widget.field_Zvalue_CT.Value = z_out;
        n_evtX.Value = x_out;
        n_evtY.Value = y_out;
        n_evtZ.Value = z_out;
        
        fieldValueChanged(widget.field_Xvalue_CT,n_evtX,widget);
        fieldValueChanged(widget.field_Yvalue_CT,n_evtY,widget);
        fieldValueChanged(widget.field_Zvalue_CT,n_evtZ,widget);
    end
    switch data.Tag
        case 'Deepest'
            widget.params.field_XDeepest.Value = widget.field_Xvalue_CT.Value;
            widget.params.field_YDeepest.Value = widget.field_Yvalue_CT.Value;
            widget.params.field_ZDeepest.Value = widget.field_Zvalue_CT.Value;
            widget.fig.UserData.(field).deepestCoord = [widget.field_Xvalue_CT.Value widget.field_Yvalue_CT.Value widget.field_Zvalue_CT.Value];
            widget.tree.UserData.(field).deepestCoord.Text = ['Deepest contact coord. (X,Y,Z): ' mat2str(widget.fig.UserData.(field).deepestCoord)];
            widget.params.button_PickDeepest.BackgroundColor = [0.94,0.94,0.94];
        case 'Second'
            widget.params.field_XSecond.Value = widget.field_Xvalue_CT.Value;
            widget.params.field_YSecond.Value = widget.field_Yvalue_CT.Value;
            widget.params.field_ZSecond.Value = widget.field_Zvalue_CT.Value;
            widget.fig.UserData.(field).secondCoord = [widget.field_Xvalue_CT.Value widget.field_Yvalue_CT.Value widget.field_Zvalue_CT.Value];
            widget.tree.UserData.(field).secondCoord.Text = ['Second contact coord. (X,Y,Z): ' mat2str(widget.fig.UserData.(field).secondCoord)];
            widget.params.button_PickSecond.BackgroundColor = [0.94,0.94,0.94];
    end
    widget = checkStatus(field,widget);
end