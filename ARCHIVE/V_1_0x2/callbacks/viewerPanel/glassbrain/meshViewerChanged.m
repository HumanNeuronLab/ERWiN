function meshViewerChanged(data,evt,widget)
    
    if evt.Value == 1 && isequal(data.Text,'View CT')
        widget.glassbrain.UserData.CTvolView.Visible = 'on';
    elseif evt.Value == 1 && isequal(data.Text,'View T1')
        widget.glassbrain.UserData.T1volView.Visible = 'on';
    elseif evt.Value == 0 && isequal(data.Text,'View CT')
        widget.glassbrain.UserData.CTvolView.Visible = 'off';
    elseif evt.Value == 0 && isequal(data.Text,'View T1')
        widget.glassbrain.UserData.T1volView.Visible = 'off';
    end
    
end