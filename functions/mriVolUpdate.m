function widget = mriVolUpdate(widget,currTab)

    if isfield(widget.glassbrain.UserData,'electrodes')
        for i = 1:length(fieldnames(widget.glassbrain.UserData.electrodes))
            field = ['Electrode' num2str(i)];
            if ~(isfield(widget.glassbrain.UserData.electrodes.(field),'ElectrodevolView'))
                hold(widget.glassbrain.UserData.axes, "on");
                widget.glassbrain.UserData.electrodes.(field).ElectrodevolView = plot3(widget.glassbrain.UserData.electrodes.(field).coord(:,1),widget.glassbrain.UserData.electrodes.(field).coord(:,2),widget.glassbrain.UserData.electrodes.(field).coord(:,3),'Parent',widget.glassbrain.UserData.axes);
                widget.glassbrain.UserData.electrodes.(field).ElectrodevolView.Color = widget.glassbrain.UserData.electrodes.(field).Color;
                widget.glassbrain.UserData.electrodes.(field).ElectrodevolView.LineWidth = 1;
                widget.glassbrain.UserData.electrodes.(field).ElectrodevolView.Marker = '.';
                widget.glassbrain.UserData.electrodes.(field).ElectrodevolView.MarkerSize = 3;
                widget.glassbrain.UserData.electrodes.(field).ElectrodevolView.MarkerFaceColor = widget.glassbrain.UserData.electrodes.(field).Color;
            end
        end
    end
    if isfield(widget.glassbrain.UserData,'T1vol') && ...
            ~(isfield(widget.glassbrain.UserData,'T1volView') && ...
            isequal(currTab,'T1'))
        hold(widget.glassbrain.UserData.axes, "on");
        widget.glassbrain.UserData.T1volView = patch(isosurface(widget.glassbrain.UserData.T1vol),'Parent',widget.glassbrain.UserData.axes,'FaceAlpha',0.15,'FaceColor',[0.4,0.5,0.8],'EdgeColor','none','Visible','off');
        widget.glassbrain.UserData.T1volView.FaceLighting = 'gouraud';
        widget.glassbrain.UserData.T1volView.AmbientStrength = 0.8;
        widget.glassbrain.UserData.T1volView.SpecularStrength = 0.9;
        widget.glassbrain.UserData.T1volView.DiffuseStrength = 0.9;
        widget.glassbrain.UserData.checkboxT1.Value = 0;
    end

    if isfield(widget.glassbrain.UserData,'CTvol') && ...
            ~(isfield(widget.glassbrain.UserData,'CTvolView') && ...
            isequal(currTab,'CT'))
        hold(widget.glassbrain.UserData.axes, "on");
        widget.glassbrain.UserData.CTvolView = patch(isosurface(widget.glassbrain.UserData.CTvol,1200),'Parent',widget.glassbrain.UserData.axes,'FaceAlpha',0.10,'FaceColor',[0.7,0.7,0.7],'EdgeColor','none','Visible','off');
        widget.glassbrain.UserData.CTvolView.FaceLighting = 'none';
        widget.glassbrain.UserData.CTvolView.AmbientStrength = 0.8;
        widget.glassbrain.UserData.CTvolView.SpecularStrength = 0.9;
        widget.glassbrain.UserData.CTvolView.DiffuseStrength = 0.9;
        widget.glassbrain.UserData.checkboxCT.Value = 0;
    end
    
end