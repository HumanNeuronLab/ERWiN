function selectFile(data, ~, widget)

    tab_MRI = widget.panel_CentralTabsMRI.SelectedTab;
    if isequal(widget.transform.UserData.action,'none')
        viewerV = tab_MRI.Tag;
        mainView = 1;
    else
        viewerV = data;
        if isequal(data,'CT')
            mainView = 1;
        else
            mainView = 0;
        end
    end

    switch viewerV
        case 'CT'
            ax1 = widget.ax_sliceView1_CT;
            ax2 = widget.ax_sliceView2_CT;
            ax3 = widget.ax_sliceView3_CT;
            labelC = widget.label_coronal_CT;
            labelS = widget.label_sagittal_CT;
            labelA = widget.label_axial_CT;
            labelButton = widget.label_selectNifti_CT;
            labelVI = widget.label_voxelIntensity_CT;
            panel4 = widget.panel_sliceView4_CT;
            checkbox = 'checkboxCT';
            volName = 'CTvol';
            try
               widget.ax_sliceView1_CT.Children.delete;
               widget.ax_sliceView2_CT.Children.delete;
               widget.ax_sliceView3_CT.Children.delete;
            catch
            end
        case 'T1'
            ax1 = widget.ax_sliceView1_T1;
            ax2 = widget.ax_sliceView2_T1;
            ax3 = widget.ax_sliceView3_T1;
            labelC = widget.label_coronal_T1;
            labelS = widget.label_sagittal_T1;
            labelA = widget.label_axial_T1;
            labelButton = widget.label_selectNifti_T1;
            labelVI = widget.label_voxelIntensity_T1;
            panel4 = widget.panel_sliceView4_T1;
            checkbox = 'checkboxT1';
            volName = 'T1vol';
            try
               widget.ax_sliceView1_T1.Children.delete;
               widget.ax_sliceView2_T1.Children.delete;
               widget.ax_sliceView3_T1.Children.delete;
            catch
            end
    end

    cMap = 'bone';
    crosshair_color = [1,0.65,0];
    colormap(ax1,cMap);
    colormap(ax2,cMap);
    colormap(ax3,cMap);
    widget.fig.Pointer = 'watch';
    drawnow

    if isequal(widget.transform.UserData.action,'none')
        if isfield(widget.glassbrain.UserData,'filePath')
            [file,path] = uigetfile({'*.nii;*.mgh;*.mgz'},'Select NIfTI file',widget.glassbrain.UserData.filePath);
        else
             [file,path] = uigetfile({'*.nii;*.mgh;*.mgz'},'Select NIfTI file');
        end
        tab_MRI.Title = file;
        labelButton.Text = file;
        data.BackgroundColor = [0.94,0.94,0.94];
        if contains(file,'.nii')
            widget.glassbrain.UserData.vol = niftiread([path file]);
        else
            widget.glassbrain.UserData.vol = MRIread([path file]);
        end
        widget.glassbrain.UserData.filePath = path;
        endIdx = strfind(path,[filesep 'elec_recon' filesep])-1;
        startIdx = max(strfind(path(1:endIdx),filesep))+1;
        widget.glassbrain.UserData.patientID = path(startIdx:endIdx);

%         if widget.transform.UserData.permutations ~= 0
%             for i = 1:widget.transform.UserData.permutations
%                 widget.glassbrain.UserData.vol = permute(...
%                     widget.glassbrain.UserData.vol,[3 1 2]);
%             end
%         end
%         if widget.transform.UserData.rotations ~= 0
%             for i = 1:widget.transform.UserData.rotations
%                 widget.glassbrain.UserData.vol = rot90(widget.glassbrain.UserData.vol);
%             end
%         end

        widget.glassbrain.UserData.vol = rot90(widget.glassbrain.UserData.vol);
    elseif isequal(widget.transform.UserData.action,'resetView')
        widget.glassbrain.UserData.vol = widget.glassbrain.UserData.(volName);
        widget.transform.UserData.action = 'none';
    elseif isequal(widget.transform.UserData.action,'permute')
        switch data
            case 'CT'
                widget.transform.UserData.permutations = widget.transform.UserData.permutations+1;
                if widget.transform.UserData.permutations == 3
                    widget.transform.UserData.permutations = 0;
                else
                    widget.glassbrain.UserData.vol = permute(...
                    widget.glassbrain.UserData.CTvol,[3 1 2]);
                end
            case 'T1'
                widget.glassbrain.UserData.vol = permute(...
                    widget.glassbrain.UserData.T1vol,[3 1 2]);
        end
    elseif isequal(widget.transform.UserData.action,'rotate')
        switch data
            case 'CT'
                widget.glassbrain.UserData.vol = rot90(widget.glassbrain.UserData.CTvol);
                widget.transform.UserData.rotations = widget.transform.UserData.rotations+1;
                if widget.transform.UserData.rotations == 4
                    widget.transform.UserData.rotations = 0;
                end
            case 'T1'
                widget.glassbrain.UserData.vol = rot90(widget.glassbrain.UserData.T1vol);
        end
    end

    if isequal(tab_MRI.Tag,'CT') && mainView == 1
        widget.params.panel_ElectrodeParams.Enable = 'on';
        widget.tree_Summary.Enable = 'on';
        expand(widget.tree_Summary.Children(1));
        widget.params.button_PickDeepest.BackgroundColor = [1,0.65,0];
        widget.params.button_PickSecond.BackgroundColor = [1,0.65,0];
        if isfield(widget.glassbrain.UserData,'CTvol')
            widget.glassbrain.UserData.CTvol = [];
            widget.glassbrain.UserData = rmfield(widget.glassbrain.UserData,'CTvol');
        end
        if isfield(widget.glassbrain.UserData,'CTvolView')
            widget.glassbrain.UserData.CTvolView = [];
            widget.glassbrain.UserData = rmfield(widget.glassbrain.UserData,'CTvolView');
        end
        widget.glassbrain.UserData.CTvol = widget.glassbrain.UserData.vol;%permute(vol,[1 3 2]);
    elseif isequal(tab_MRI.Tag,'T1') || mainView == 0
        if isfield(widget.glassbrain.UserData,'T1vol')
            widget.glassbrain.UserData.T1vol = [];
            widget.glassbrain.UserData = rmfield(widget.glassbrain.UserData,'T1vol');
        end
        if isfield(widget.glassbrain.UserData,'T1volView')
            widget.glassbrain.UserData.T1volView = [];
            widget.glassbrain.UserData = rmfield(widget.glassbrain.UserData,'T1volView');
        end
        for i = 1:length(tab_MRI.Parent.Children)
            indexer1(i) = {tab_MRI.Parent.Children(i).Tag};
        end
        CT_tab = find(contains(indexer1,'CT'));
        for i = 1:length(tab_MRI.Parent.Children(CT_tab).Children)
            indexer2(i) = {tab_MRI.Parent.Children(CT_tab).Children(i).Tag};
        end
        paramsPanel1 = find(contains(indexer2,'slice params panel'));
        for i = 1:length(tab_MRI.Parent.Children(CT_tab).Children(paramsPanel1).Children)
            indexer3(i) = {tab_MRI.Parent.Children(CT_tab).Children(paramsPanel1).Children(i).Tag};
        end
        sliderContact1 = find(contains(indexer3,'Contact slider'));
        labelContact1 = find(contains(indexer3,'Contact label'));
        if isequal(tab_MRI.Parent.Children(CT_tab).Children(paramsPanel1).Children(sliderContact1).Visible,'on')
           for i = 1:length(tab_MRI.Children)
                indexer4(i) = {tab_MRI.Children(i).Tag};
            end
            paramsPanel = find(contains(indexer4,'slice params panel'));
            for i = 1:length(tab_MRI.Children(paramsPanel).Children)
                indexer5(i) = {tab_MRI.Children(paramsPanel).Children(i).Tag};
            end
            sliderContact = find(contains(indexer5,'Contact slider'));
            labelContact = find(contains(indexer5,'Contact label'));
            tab_MRI.Children(paramsPanel).Children(sliderContact).Limits = tab_MRI.Parent.Children(CT_tab).Children(paramsPanel1).Children(sliderContact1).Limits;
            tab_MRI.Children(paramsPanel).Children(sliderContact).Value = tab_MRI.Parent.Children(CT_tab).Children(paramsPanel1).Children(sliderContact1).Value;
            tab_MRI.Children(paramsPanel).Children(sliderContact).MajorTicks = tab_MRI.Parent.Children(CT_tab).Children(paramsPanel1).Children(sliderContact1).MajorTicks;
            tab_MRI.Children(paramsPanel).Children(labelContact).Text = tab_MRI.Parent.Children(CT_tab).Children(paramsPanel1).Children(labelContact1).Text;
            tab_MRI.Children(paramsPanel).Children(labelContact).Visible = 'on';
            tab_MRI.Children(paramsPanel).Children(sliderContact).Visible = 'on';
        end
        widget.glassbrain.UserData.T1vol = widget.glassbrain.UserData.vol;
    end
    
    %vol = rot90(vol);
    vol_size = size(widget.glassbrain.UserData.(volName));
    ax1.XLim = [0,vol_size(2)];
    ax1.YLim = [0,vol_size(1)];
    ax2.XLim = [0,vol_size(3)];
    ax2.YLim = [0,vol_size(1)];
    ax3.XLim = [0,vol_size(2)];
    ax3.YLim = [0,vol_size(3)];

    slice_selection = ceil(vol_size(3)/2+1);
    labelVI.Text = ['Voxel intensity: ' ...
        mat2str(round(widget.glassbrain.UserData.vol(slice_selection,slice_selection,slice_selection)))];
    labelC.Text = ['Coronal Slice: ' mat2str([slice_selection,slice_selection,slice_selection])];
    labelS.Text = ['Sagittal Slice: ' mat2str([slice_selection,slice_selection,slice_selection])];
    labelA.Text = ['Axial Slice: ' mat2str([slice_selection,slice_selection,slice_selection])];

    coronal_slice = widget.glassbrain.UserData.(volName)(:,:,slice_selection);
    sagittal_slice = widget.glassbrain.UserData.(volName)(:,slice_selection,:);
    sagittal_slice = reshape(sagittal_slice,[vol_size(1),vol_size(3)]);
    axial_slice = widget.glassbrain.UserData.(volName)(slice_selection,:,:);
    axial_slice = reshape(axial_slice,[vol_size(2),vol_size(3)]);
    axial_slice = rot90(axial_slice);
    
    widget.coronal_image = imagesc('Parent',ax1,'CData',coronal_slice,'Tag',num2str(slice_selection));
    widget.coronal_crosshair = drawcrosshair(ax1,'Position',[ceil(vol_size(2)/2+1),ceil(vol_size(1)/2+1)],...
        'Color',crosshair_color,'LineWidth',1.5,'Tag','coronal_crosshair');
    widget.sagittal_image = imagesc('Parent',ax2,'CData',sagittal_slice,'Tag',num2str(slice_selection));
    widget.sagittal_crosshair = drawcrosshair(ax2,'Position',[ceil(vol_size(2)/2+1),ceil(vol_size(1)/2+1)],...
        'Color',crosshair_color,'LineWidth',1.5,'Tag','sagittal_crosshair');
    widget.axial_image = imagesc('Parent',ax3,'CData',axial_slice,'Tag',num2str(slice_selection));
    widget.axial_crosshair = drawcrosshair(ax3,'Position',[ceil(vol_size(2)/2+1),ceil(vol_size(1)/2+1)],...
        'Color',crosshair_color,'LineWidth',1.5,'Tag','axial_crosshair');

    for i = 1:length(panel4.Children)
        tag{i} = panel4.Children(i).Tag; %#ok<AGROW> 
    end

    X_idx = find(contains(tag,'X'));
    for i = X_idx
        if contains(tag(i),'field')
            panel4.Children(i).Enable = 'on';
            panel4.Children(i).Value = slice_selection;
            p.field_X = panel4.Children(i);
        elseif contains(tag(i), 'slider')
            panel4.Children(i).Limits = [1,vol_size(2)];
            panel4.Children(i).Enable = 'on';
            panel4.Children(i).Value = slice_selection;
            p.slider_X = panel4.Children(i);
        else
            panel4.Children(i).Enable = 'on';
        end
    end

    Y_idx = find(contains(tag,'Y'));
    for i = Y_idx
        if contains(tag(i),'field')
            panel4.Children(i).Enable = 'on';
            panel4.Children(i).Value = slice_selection;
            p.field_Y = panel4.Children(i);
        elseif contains(tag(i), 'slider')
            panel4.Children(i).Limits = [1,vol_size(1)];
            panel4.Children(i).Enable = 'on';
            panel4.Children(i).Value = slice_selection;
            p.slider_Y = panel4.Children(i);
        else
            panel4.Children(i).Enable = 'on';
        end
    end

    Z_idx = find(contains(tag,'Z'));
    for i = Z_idx
        if contains(tag(i),'field')
            panel4.Children(i).Enable = 'on';
            panel4.Children(i).Value = slice_selection;
            p.field_Z = panel4.Children(i);
        elseif contains(tag(i), 'slider')
            panel4.Children(i).Limits = [1,vol_size(3)];
            panel4.Children(i).Enable = 'on';
            panel4.Children(i).Value = slice_selection;
            p.slider_Z = panel4.Children(i);
        else
            panel4.Children(i).Enable = 'on';
        end
    end


    widget.glassbrain.UserData.(checkbox).Enable = 'on';
    drawnow
    widget.fig.Pointer = 'arrow';
    widget.button_resetView_CT.Enable = 'on';
    widget.button_load.Enable = 'on';
    widget = contactDotDisplay(widget);
%     widget.button_permuteVol_CT.Enable = 'on';
%     widget.button_rotateVol_CT.Enable = 'on';

    addlistener(widget.coronal_crosshair,'MovingROI',@(src,data)crossDrag...
        (src,data,widget.glassbrain.UserData.(volName),vol_size,labelVI,ax1,ax2,ax3,labelC,labelS,labelA,widget.coronal_image,...
        widget.sagittal_image,widget.sagittal_crosshair,widget.axial_image,widget.axial_crosshair,p,widget));
    addlistener(widget.sagittal_crosshair,'MovingROI',@(src,data)crossDrag...
        (src,data,widget.glassbrain.UserData.(volName),vol_size,labelVI,ax1,ax2,ax3,labelC,labelS,labelA,widget.sagittal_image,...
        widget.coronal_image,widget.coronal_crosshair,widget.axial_image,widget.axial_crosshair,p,widget));
    addlistener(widget.axial_crosshair,'MovingROI',@(src,data)crossDrag...
        (src,data,widget.glassbrain.UserData.(volName),vol_size,labelVI,ax1,ax2,ax3,labelC,labelS,labelA,widget.axial_image,...
        widget.coronal_image,widget.coronal_crosshair,widget.sagittal_image,widget.sagittal_crosshair,p,widget));

end