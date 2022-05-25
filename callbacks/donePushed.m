function donePushed(~,~,widget,fig,pos)

    cd(widget.glassbrain.UserData.filePath);
    [filename,path,~] = uiputfile('*.mgrid','File Export',...
        widget.glassbrain.UserData.patientID,...
        'Position',[pos(1)+pos(3)/2-250,300,500,500]);
        
    for z = 1:length(fieldnames(widget.fig.UserData))
        field = ['Electrode' num2str(z)];
        final_outputData.(field) = widget.fig.UserData.(field);
        final_outputData.(field).Color = widget.glassbrain.UserData.electrodes.(field).Color;
        name_list(z) = {['    - ' final_outputData.(field).Name '\n']}; %#ok<AGROW>
    end

    saveMGRID(final_outputData,[path filename],widget.glassbrain.UserData.patientID);
    fprintf(2,'\n\nElectrode localization successful for:\n\n');
    fprintf(['<strong>' name_list{:} '</strong> \n\n\n']);
    
%         close(fig);

end