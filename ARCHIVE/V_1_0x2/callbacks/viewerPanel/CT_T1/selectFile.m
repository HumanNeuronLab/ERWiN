function selectFile(data, ~, widget)

    tab_MRI = widget.panel_CentralTabsMRI.SelectedTab;
    switch tab_MRI.Tag
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
    end


    [file,path] = uigetfile({'*.nii;*.mgh;*.mgz'});
    tab_MRI.Title = file;
    labelButton.Text = file;
    data.BackgroundColor = [0.94,0.94,0.94];
    cMap = 'bone';
    crosshair_color = [1,0.65,0];
    colormap(ax1,cMap);
    colormap(ax2,cMap);
    colormap(ax3,cMap);
    widget.fig.Pointer = 'watch';
    drawnow

    if contains(file,'.nii')
        widget.glassbrain.UserData.vol = load_nifti([path file]);
        widget.glassbrain.UserData.vol = widget.glassbrain.UserData.vol.vol;
    else
        widget.glassbrain.UserData.vol = load_mgh([path file]);
    end
 
    if isequal(tab_MRI.Tag,'CT')
        widget.widget.params.panel_ElectrodeParams.Enable = 'on';
        widget.tree_Summary.Enable = 'on';
        expand(widget.tree_Summary.Children(1));
        widget.params.button_PickDeepest.BackgroundColor = [1,0.65,0];
        widget.params.button_PickSecond.BackgroundColor = [1,0.65,0];
        if isfield(widget.glassbrain.UserData,'CTvol')
            widget.glassbrain.UserData.CTvol = [];
            widget.glassbrain.UserData = rmfield(widget.glassbrain.UserData,'CTvol');
        end
        widget.glassbrain.UserData.CTvol = widget.glassbrain.UserData.vol;%permute(vol,[1 3 2]);
    elseif isequal(tab_MRI.Tag,'T1')
        if isfield(widget.glassbrain.UserData,'T1vol')
            widget.glassbrain.UserData.T1vol = [];
            widget.glassbrain.UserData = rmfield(widget.glassbrain.UserData,'T1vol');
        end
        for i = 1:length(tab_MRI.Parent.Children)
            indexer1(i) = {tab_MRI.Parent.Children(i).Tag};
        end
        CT_tab = find(contains(indexer1,'CT'));
        for i = 1:length(tab_MRI.Parent.Children(CT_tab).Children)
            indexer2(i) = {tab_MRI.Parent.Children(CT_tab).Children(i).Tag};
        end
        widget.paramsPanel1 = find(contains(indexer2,'slice widget.params panel'));
        for i = 1:length(tab_MRI.Parent.Children(CT_tab).Children(widget.paramsPanel1).Children)
            indexer3(i) = {tab_MRI.Parent.Children(CT_tab).Children(widget.paramsPanel1).Children(i).Tag};
        end
        sliderContact1 = find(contains(indexer3,'Contact slider'));
        labelContact1 = find(contains(indexer3,'Contact label'));
        if isequal(tab_MRI.Parent.Children(CT_tab).Children(widget.paramsPanel1).Children(sliderContact1).Visible,'on')
           for i = 1:length(tab_MRI.Children)
                indexer4(i) = {tab_MRI.Children(i).Tag};
            end
            widget.paramsPanel = find(contains(indexer4,'slice widget.params panel'));
            for i = 1:length(tab_MRI.Children(widget.paramsPanel).Children)
                indexer5(i) = {tab_MRI.Children(widget.paramsPanel).Children(i).Tag};
            end
            sliderContact = find(contains(indexer5,'Contact slider'));
            labelContact = find(contains(indexer5,'Contact label'));
            tab_MRI.Children(widget.paramsPanel).Children(sliderContact).Limits = tab_MRI.Parent.Children(CT_tab).Children(widget.paramsPanel1).Children(sliderContact1).Limits;
            tab_MRI.Children(widget.paramsPanel).Children(sliderContact).Value = tab_MRI.Parent.Children(CT_tab).Children(widget.paramsPanel1).Children(sliderContact1).Value;
            tab_MRI.Children(widget.paramsPanel).Children(sliderContact).MajorTicks = tab_MRI.Parent.Children(CT_tab).Children(widget.paramsPanel1).Children(sliderContact1).MajorTicks;
            tab_MRI.Children(widget.paramsPanel).Children(labelContact).Text = tab_MRI.Parent.Children(CT_tab).Children(widget.paramsPanel1).Children(labelContact1).Text;
            tab_MRI.Children(widget.paramsPanel).Children(labelContact).Visible = 'on';
            tab_MRI.Children(widget.paramsPanel).Children(sliderContact).Visible = 'on';
        end
        widget.glassbrain.UserData.T1vol = widget.glassbrain.UserData.vol;%permute(vol,[1 3 2]);
    end
    
    %vol = rot90(vol);
    vol_size = size(widget.glassbrain.UserData.vol);
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

    coronal_slice = widget.glassbrain.UserData.vol(:,:,slice_selection);
    sagittal_slice = widget.glassbrain.UserData.vol(:,slice_selection,:);
    sagittal_slice = reshape(sagittal_slice,[vol_size(1),vol_size(3)]);
    axial_slice = widget.glassbrain.UserData.vol(slice_selection,:,:);
    axial_slice = reshape(axial_slice,[vol_size(2),vol_size(3)]);
    axial_slice = rot90(axial_slice);
    
    coronal_image = imagesc('Parent',ax1,'CData',coronal_slice,'Tag',num2str(slice_selection));
    coronal_crosshair = drawcrosshair(ax1,'Position',[ceil(vol_size(2)/2+1),ceil(vol_size(1)/2+1)],...
        'Color',crosshair_color,'LineWidth',1.5,'Tag','coronal_crosshair');
    sagittal_image = imagesc('Parent',ax2,'CData',sagittal_slice,'Tag',num2str(slice_selection));
    sagittal_crosshair = drawcrosshair(ax2,'Position',[ceil(vol_size(2)/2+1),ceil(vol_size(1)/2+1)],...
        'Color',crosshair_color,'LineWidth',1.5,'Tag','sagittal_crosshair');
    axial_image = imagesc('Parent',ax3,'CData',axial_slice,'Tag',num2str(slice_selection));
    axial_crosshair = drawcrosshair(ax3,'Position',[ceil(vol_size(2)/2+1),ceil(vol_size(1)/2+1)],...
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


    widget = mriVolUpdate(widget);
    drawnow
    widget.fig.Pointer = 'arrow';

    addlistener(coronal_crosshair,'MovingROI',@(src,data)crossDrag...
        (src,data,widget.glassbrain.UserData.vol,vol_size,labelVI,ax1,ax2,ax3,labelC,labelS,labelA,coronal_image,...
        sagittal_image,sagittal_crosshair,axial_image,axial_crosshair,p));
    addlistener(sagittal_crosshair,'MovingROI',@(src,data)crossDrag...
        (src,data,widget.glassbrain.UserData.vol,vol_size,labelVI,ax1,ax2,ax3,labelC,labelS,labelA,sagittal_image,...
        coronal_image,coronal_crosshair,axial_image,axial_crosshair,p));
    addlistener(axial_crosshair,'MovingROI',@(src,data)crossDrag...
        (src,data,widget.glassbrain.UserData.vol,vol_size,labelVI,ax1,ax2,ax3,labelC,labelS,labelA,axial_image,...
        coronal_image,coronal_crosshair,sagittal_image,sagittal_crosshair,p));

end