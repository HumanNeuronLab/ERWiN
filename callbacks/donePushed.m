function donePushed(~,~,widget,fig,pos)
    
    saveFig = uifigure("Position",[pos(1)+pos(3)/2-250,300,500,500],'Name',...
        'ERWiN - Electrode saving options');
    label1 = uilabel('Parent',saveFig,'Position',[15,450,300,20],'Text','Select the electrodes you wish to save to the output file:');
    checkbox_allElectrodes = uicheckbox('Parent',saveFig,'Position',[20,label1.Position(2)-37,100,20],'Value',1,'Text','all electrodes');
    panel1 = uipanel('Parent',saveFig,'Position',[20,checkbox_allElectrodes.Position(2)-10-300,460,300],'Scrollable','on','BackgroundColor',[1,1,1],'Enable','off');
    height = panel1.Position(4);
    for i = 1:length(fieldnames(widget.fig.UserData))
        checkboxLabel = ['checkbox' num2str(i)];
        field = ['Electrode' num2str(i)];
        checkboxes.(checkboxLabel) = uicheckbox('Parent',panel1,'Position',[10,height-30,300,20],'Value',1,'Text',widget.fig.UserData.(field).Name);
        height = checkboxes.(checkboxLabel).Position(2);
    end
    label2 = uilabel('Parent',saveFig,'Position',[15,panel1.Position(2)-37,75,20],'Text','File name:');
    field1 = uieditfield('Parent',saveFig,'Position',[label2.Position(1)+label2.Position(3)+10,label2.Position(2),saveFig.Position(3)-(label2.Position(1)+label2.Position(3)+10)-100,22]);
    label3 = uilabel('Parent',saveFig,'Position',[field1.Position(1)+field1.Position(3)+10,field1.Position(2),60,20],'Text','.mgrid'); %#ok<NASGU> 
    buttonSave = uibutton('Parent',saveFig,'Position',[saveFig.Position(3)-75,15,50,30],'Text','Save','Enable','off','BackgroundColor',[1,0.65,0]);
    checkbox_allElectrodes.ValueChangedFcn = {@checkChange,panel1,checkboxes};
    field1.ValueChangingFcn = {@fileNamed,buttonSave};
    buttonSave.ButtonPushedFcn = {@savePushed,checkbox_allElectrodes,checkboxes,field1,widget.fig.UserData,fig,saveFig};

    function checkChange(~,evt,panel1,checkboxes)
        if evt.Value == 0
            panel1.Enable = 'on';
        else
            panel1.Enable = 'off';
            for k = 1:length(fieldnames(checkboxes))
                checkboxLabel = ['checkbox' num2str(k)];
                checkboxes.(checkboxLabel).Value = 1;
            end
        end

    end
    
    function fileNamed(~,evt,buttonSave)
        if ~(isempty(evt.Value))
            buttonSave.Enable = 'on';
        else
            buttonSave.Enable = 'off';
        end
    end

    function savePushed(~,~,allElectrodes,checkboxes,filename,outputData,fig,saveFig)
        if allElectrodes.Value
            elecToSave = ones(length(fieldnames(checkboxes)),1);
        else
            elecToSave = zeros(length(fieldnames(checkboxes)),1);
            for l = 1:length(fieldnames(checkboxes))
                checkboxLabel = ['checkbox' num2str(l)];
                if checkboxes.(checkboxLabel).Value == 1
                    elecToSave(l) = 1;
                end
            end
        end
        counter = 1;
        for z = 1:length(fieldnames(outputData))
            if elecToSave(z) == 1
                final_field = ['Electrode' num2str(counter)];
                field = ['Electrode' num2str(z)];
                final_outputData.(final_field) = outputData.(field);
                final_outputData.(final_field).Color = widget.glassbrain.UserData.electrodes.(final_field).Color;
                name_list(counter) = {['    - ' final_outputData.(final_field).Name '\n']}; %#ok<AGROW> 
                counter = counter +1;
            end
        end
        saveMGRID(final_outputData,filename.Value);
        close(fig);
        close(saveFig);
        fprintf(2,'\n\nElectrode localization successful for:\n\n');
        fprintf(['<strong>' name_list{:} '</strong> \n\n\n']);

    end
end