function widget = contactDotDisplay(widget)
    j1 = 1;
    j2 = 1;
    j3 = 1;
    switch widget.panel_CentralTabsMRI.SelectedTab.Tag
        case 'CT'
            ax1 = 'ax_sliceView1_CT';
            ax2 = 'ax_sliceView2_CT';
            ax3 = 'ax_sliceView3_CT';
            sliderX = 'slider_X_CT';
            sliderY = 'slider_Y_CT';
            sliderZ = 'slider_Z_CT';
        case 'T1'
            ax1 = 'ax_sliceView1_T1';
            ax2 = 'ax_sliceView2_T1';
            ax3 = 'ax_sliceView3_T1';
            sliderX = 'slider_X_T1';
            sliderY = 'slider_Y_T1';
            sliderZ = 'slider_Z_T1';
    end
    for i = 1:length((widget.(ax1).Children))
        if isequal(widget.(ax1).Children(i).Tag,'dot')
            idDelete1(j1) = i;
            j1 = j1+1;
        end
    end
    for i = 1:length((widget.(ax2).Children))
        if isequal(widget.(ax2).Children(i).Tag,'dot')
            idDelete2(j2) = i;
            j2 = j2+1;
        end
    end
    for i = 1:length((widget.(ax3).Children))
        if isequal(widget.(ax3).Children(i).Tag,'dot')
            idDelete3(j3) = i;
            j3 = j3+1;
        end
    end
    try
        widget.(ax1).Children(idDelete1).delete
    catch
    end
    try
        widget.(ax2).Children(idDelete2).delete
    catch
    end
    try
        widget.(ax3).Children(idDelete3).delete
    catch
    end

    for i = 1:length(fieldnames(widget.fig.UserData))
        field = ['Electrode' num2str(i)];
        if isequal(widget.fig.UserData.(field).Estimation,'SUCCESS')
            xVal = widget.(sliderX).Value;
            yVal = widget.(sliderY).Value;
            zVal = widget.(sliderZ).Value;
            widget.idX = find(...
                widget.fig.UserData.(field).contact(:,1) >= xVal-1 &...
                widget.fig.UserData.(field).contact(:,1) <= xVal+1);
            widget.idY = find(...
                widget.fig.UserData.(field).contact(:,2) >= yVal-1 &...
                widget.fig.UserData.(field).contact(:,2) <= yVal+1);
            widget.idZ = find(...
                widget.fig.UserData.(field).contact(:,3) >= zVal-1 &...
                widget.fig.UserData.(field).contact(:,3) <= zVal+1);

            hold(widget.(ax1),'on');
            plot(widget.(ax1),...
                widget.fig.UserData.(field).contact(widget.idZ,1), ...
                widget.fig.UserData.(field).contact(widget.idZ,2), ...
                'Marker','.','MarkerSize',15,'Tag','dot',...
                'Color',widget.glassbrain.UserData.electrodes.(field).Color);
            hold(widget.(ax1),'off');

            hold(widget.(ax2),'on');
            plot(widget.(ax2),...
                widget.fig.UserData.(field).contact(widget.idX,3), ...
                widget.fig.UserData.(field).contact(widget.idX,2), ...
                'Marker','.','MarkerSize',15,'Tag','dot',...
                'Color',widget.glassbrain.UserData.electrodes.(field).Color);
            hold(widget.(ax2),'off');

            hold(widget.(ax3),'on');
            plot(widget.(ax3),...
                widget.fig.UserData.(field).contact(widget.idY,1), ...
                length(widget.glassbrain.UserData.vol(1,:,1))-...
                widget.fig.UserData.(field).contact(widget.idY,3)+1, ...
                'Marker','.','MarkerSize',15,'Tag','dot',...
                'Color',widget.glassbrain.UserData.electrodes.(field).Color);
            hold(widget.(ax3),'off');
        end
    end

end