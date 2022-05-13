function transformVol(data,~,widget)

    if isequal(data.Text,'Rotate')
        widget.transform.UserData.action = 'rotate';
    elseif isequal(data.Text,'Permute')
        widget.transform.UserData.action = 'permute';
    end
    selectFile(0,0, widget)
end