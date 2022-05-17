function transformVol(data,~,widget)

    if isequal(data.Text,'Rotate')
        widget.transform.UserData.action = 'rotate';
    elseif isequal(data.Text,'Permute')
        widget.transform.UserData.action = 'permute';
    end
    selectFile('CT',0,widget);
    if isfield(widget.glassbrain.UserData,'T1vol')
        selectFile('T1',0,widget);
    end
    widget.transform.UserData.action = 'none';
    
end