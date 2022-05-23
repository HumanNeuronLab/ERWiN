function widget = contactDotDisplay(widget)
    j1 = 1;
    j2 = 1;
    j3 = 1;
    for i = 1:length((widget.ax_sliceView1_CT.Children))
        if isequal(widget.ax_sliceView1_CT.Children(i).Tag,'dot')
            idDelete1(j1) = i;
            j1 = j1+1;
        end
    end
    for i = 1:length((widget.ax_sliceView2_CT.Children))
        if isequal(widget.ax_sliceView2_CT.Children(i).Tag,'dot')
            idDelete2(j2) = i;
            j2 = j2+1;
        end
    end
    for i = 1:length((widget.ax_sliceView3_CT.Children))
        if isequal(widget.ax_sliceView3_CT.Children(i).Tag,'dot')
            idDelete3(j3) = i;
            j3 = j3+1;
        end
    end
    try
        widget.ax_sliceView1_CT.Children(idDelete1).delete
    catch
    end
    try
        widget.ax_sliceView2_CT.Children(idDelete2).delete
    catch
    end
    try
        widget.ax_sliceView3_CT.Children(idDelete3).delete
    catch
    end

    for i = 1:length(fieldnames(widget.fig.UserData))
        field = ['Electrode' num2str(i)];
        if isequal(widget.fig.UserData.(field).Estimation,'SUCCESS')
            xVal = widget.slider_X_CT.Value;
            yVal = widget.slider_Y_CT.Value;
            zVal = widget.slider_Z_CT.Value;
            widget.idX = find(...
                widget.fig.UserData.(field).contact(:,1) >= xVal-1 &...
                widget.fig.UserData.(field).contact(:,1) <= xVal+1);
            widget.idY = find(...
                widget.fig.UserData.(field).contact(:,2) >= yVal-1 &...
                widget.fig.UserData.(field).contact(:,2) <= yVal+1);
            widget.idZ = find(...
                widget.fig.UserData.(field).contact(:,3) >= zVal-1 &...
                widget.fig.UserData.(field).contact(:,3) <= zVal+1);

            hold(widget.ax_sliceView1_CT,'on');
            plot(widget.ax_sliceView1_CT,...
                widget.fig.UserData.(field).contact(widget.idZ,1), ...
                widget.fig.UserData.(field).contact(widget.idZ,2), ...
                'Marker','.','MarkerSize',15,'Tag','dot',...
                'Color',widget.glassbrain.UserData.electrodes.(field).Color);
            hold(widget.ax_sliceView1_CT,'off');

            hold(widget.ax_sliceView2_CT,'on');
            plot(widget.ax_sliceView2_CT,...
                widget.fig.UserData.(field).contact(widget.idX,3), ...
                widget.fig.UserData.(field).contact(widget.idX,2), ...
                'Marker','.','MarkerSize',15,'Tag','dot',...
                'Color',widget.glassbrain.UserData.electrodes.(field).Color);
            hold(widget.ax_sliceView2_CT,'off');

            hold(widget.ax_sliceView3_CT,'on');
            plot(widget.ax_sliceView3_CT,...
                widget.fig.UserData.(field).contact(widget.idY,1), ...
                length(widget.glassbrain.UserData.vol(1,:,1))-...
                widget.fig.UserData.(field).contact(widget.idY,3)+1, ...
                'Marker','.','MarkerSize',15,'Tag','dot',...
                'Color',widget.glassbrain.UserData.electrodes.(field).Color);
            hold(widget.ax_sliceView1_CT,'off');
        end
    end

end