function widget = checkStatus(field,widget)

    if ~isempty(widget.fig.UserData.(field).Name) && ~isempty(widget.fig.UserData.(field).numContacts)...
            && ~isempty(widget.fig.UserData.(field).contactDist) && ~isempty(widget.fig.UserData.(field).deepestCoord)...
            && ~isempty(widget.fig.UserData.(field).secondCoord) ...
            && (isempty(widget.fig.UserData.(field).Estimation) || isequal(widget.fig.UserData.(field).Estimation, 'READY'))
        widget.fig.UserData.(field).Estimation = 'READY';
        widget.params.button_estimate.BackgroundColor = [1,0.65,0];
        widget.params.button_estimate.Enable = 'on';
        widget.params.button_estimate.Text = 'Estimate';
        widget.tree.UserData.(field).electrodeName.Text = [widget.fig.UserData.(field).Name '    [READY FOR ESTIMATION]'];
    elseif ~isempty(widget.fig.UserData.(field).Name) && ~isempty(widget.fig.UserData.(field).numContacts)...
            && ~isempty(widget.fig.UserData.(field).contactDist) && ~isempty(widget.fig.UserData.(field).deepestCoord)...
            && ~isempty(widget.fig.UserData.(field).secondCoord) && isequal(widget.fig.UserData.(field).Estimation,'FAILED')
        widget.params.button_estimate.BackgroundColor = [1,0.65,0];
        widget.params.button_estimate.Enable = 'on';
        widget.params.button_estimate.Text = 'Re-estimate';
        widget.tree.UserData.(field).electrodeName.Text = [widget.fig.UserData.(field).Name '    [RE-ESTIMATE]'];
    elseif ~isempty(widget.fig.UserData.(field).Name) && ~isempty(widget.fig.UserData.(field).numContacts)...
            && ~isempty(widget.fig.UserData.(field).contactDist) && ~isempty(widget.fig.UserData.(field).deepestCoord)...
            && ~isempty(widget.fig.UserData.(field).secondCoord) && isequal(widget.fig.UserData.(field).Estimation,'RE-ESTIMATE')
        widget.params.button_estimate.BackgroundColor = [1,0.65,0];
        widget.params.button_estimate.Enable = 'on';
        widget.params.button_estimate.Text = 'Re-estimate';
        widget.tree.UserData.(field).electrodeName.Text = [widget.fig.UserData.(field).Name '    [RE-ESTIMATE]'];
    elseif ~isempty(widget.fig.UserData.(field).Name) && ~isempty(widget.fig.UserData.(field).numContacts)...
            && ~isempty(widget.fig.UserData.(field).contactDist) && ~isempty(widget.fig.UserData.(field).deepestCoord)...
            && ~isempty(widget.fig.UserData.(field).secondCoord) && isequal(widget.fig.UserData.(field).Estimation,'SUCCESS')
        widget.params.button_estimate.BackgroundColor = [0.95,0.95,0.95];
        widget.params.button_estimate.Enable = 'off';
        widget.params.button_estimate.Text = 'Estimation successful';
        widget.tree.UserData.(field).electrodeName.Text = ['✓ ' widget.fig.UserData.(field).Name];
    else
        widget.params.button_estimate.BackgroundColor = [1,0.65,0];
        widget.params.button_estimate.Enable = 'off';
        widget.params.button_estimate.Text = 'Estimate';
    end
    
    numElectrodes = length(widget.params.dropdown_ElectrodeSelector.Items);
    
    ready_check = zeros(numElectrodes,1);
    for i = 1:numElectrodes
        currField = ['Electrode' num2str(i)];
        if isequal(widget.fig.UserData.(currField).Estimation, 'SUCCESS')
            ready_check(i) = 1;
        else
            ready_check(i) = 0;
        end
    end
    ready_check = sum(ready_check)/numElectrodes;
    if ready_check == 1
        widget.params.button_done.Enable = 'on';
        widget.params.button_done.BackgroundColor = [1,0.65,0];
    else
        widget.params.button_done.Enable = 'off';
        widget.params.button_done.BackgroundColor = [0.95,0.95,0.95];
    end
   
end