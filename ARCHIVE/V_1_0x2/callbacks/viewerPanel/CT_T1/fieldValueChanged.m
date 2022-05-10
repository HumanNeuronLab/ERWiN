function fieldValueChanged(data,evt,widget)

    curr_field = data.Tag;

    switch widget.panel_CentralTabsMRI.SelectedTab.Tag
        case 'CT'
            vol = widget.glassbrain.UserData.CTvol;
            ax1 = widget.ax_sliceView1_CT;
            ax2 = widget.ax_sliceView2_CT;
            ax3 = widget.ax_sliceView3_CT;
            labelC = widget.label_coronal_CT;
            labelS = widget.label_sagittal_CT;
            labelA = widget.label_axial_CT;
            labelVI = widget.label_voxelIntensity_CT;
            slider1 = widget.slider_X_CT;
            slider2 = widget.slider_Y_CT;
            slider3 = widget.slider_Z_CT;
            field1 = widget.field_Xvalue_CT;
            field2 = widget.field_Yvalue_CT;
            field3 = widget.field_Zvalue_CT;
        case 'T1'
            vol = widget.glassbrain.UserData.T1vol;
            ax1 = widget.ax_sliceView1_T1;
            ax2 = widget.ax_sliceView2_T1;
            ax3 = widget.ax_sliceView3_T1;
            labelC = widget.label_coronal_T1;
            labelS = widget.label_sagittal_T1;
            labelA = widget.label_axial_T1;
            labelVI = widget.label_voxelIntensity_T1;
            slider1 = widget.slider_X_T1;
            slider2 = widget.slider_Y_T1;
            slider3 = widget.slider_Z_T1;
            field1 = widget.field_Xvalue_T1;
            field2 = widget.field_Yvalue_T1;
            field3 = widget.field_Zvalue_T1;
    end

    vol_size = size(vol);
    switch curr_field
        case 'X field'
            
            pos = [evt.Value,field2.Value,field3.Value];
            for i = 1:length(ax1.Children)
                if ~isequal(ax1.Children(i).Type,'image')
                    ax1.Children(i).Position = [pos(1) pos(2)];
                end
            end
            for i = 1:length(ax2.Children)
                if isequal(ax2.Children(i).Type,'image')
                    ax2.Children(i).CData = reshape(vol(:,pos(1),:),[vol_size(1),vol_size(3)]);
                    ax2.Children(i).Tag = num2str(pos(1));
                else
                    ax2.Children(i).Position = [pos(3) pos(2)];
                end
            end
            for i = 1:length(ax3.Children)
                if ~isequal(ax3.Children(i).Type,'image')
                    ax3.Children(i).Position = [pos(1) vol_size(3)-pos(3)+1];
                end
            end
            slider1.Value = evt.Value;

        case 'Y field'
            
            pos = [field1.Value,evt.Value,field3.Value];
            for i = 1:length(ax1.Children)
                if ~isequal(ax1.Children(i).Type,'image')
                    ax1.Children(i).Position = [pos(1) pos(2)];
                end
            end
            for i = 1:length(ax2.Children)
                if ~isequal(ax2.Children(i).Type,'image')
                    ax2.Children(i).Position = [pos(3) pos(2)];
                end
            end
            for i = 1:length(ax3.Children)
                if isequal(ax3.Children(i).Type,'image')
                    ax3.Children(i).CData = rot90(reshape(vol(pos(2),:,:),[vol_size(2),vol_size(3)]));
                    ax3.Children(i).Tag = num2str(pos(2));
                else
                    ax3.Children(i).Position = [pos(1) vol_size(3)-pos(3)+1];
                end
            end
            slider2.Value = evt.Value;

        case 'Z field'
            
            pos = [field1.Value,field2.Value,evt.Value];
            for i = 1:length(ax1.Children)
                if isequal(ax1.Children(i).Type,'image')
                    ax1.Children(i).CData = vol(:,:,pos(3));
                    ax1.Children(i).Tag = num2str(pos(3));
                else
                    ax1.Children(i).Position = [pos(1) pos(2)];
                end
            end
            for i = 1:length(ax2.Children)
                if ~isequal(ax2.Children(i).Type,'image')
                    ax2.Children(i).Position = [pos(3) pos(2)];
                end
            end
            for i = 1:length(ax3.Children)
                if ~isequal(ax3.Children(i).Type,'image')
                    ax3.Children(i).Position = [pos(1) vol_size(3)-pos(3)+1];
                end
            end
            slider3.Value = evt.Value;

    end
    labelVI.Text = ['Voxel intensity: ' num2str(round(vol(pos(2),pos(1),pos(3))))];
    labelC.Text = ['Coronal Slice: ' mat2str(pos)];
    labelS.Text = ['Sagittal Slice: ' mat2str(pos)];
    labelA.Text = ['Axial Slice: ' mat2str(pos)];
    

end