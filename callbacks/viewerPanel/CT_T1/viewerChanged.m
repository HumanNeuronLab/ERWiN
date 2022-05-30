function viewerChanged(~,evt,widget)

    currTab = evt.NewValue.Tag;
    if isequal(currTab,'CT') || isequal(currTab,'T1')
        for i = 1:length(evt.NewValue.Children)
            indexer(i) = {evt.NewValue.Children(i).Tag};
        end
        paramsIdx = find(contains(indexer,'slice params panel 1'));
        coronalIdx = find(contains(indexer,'coronal panel 1'));
        sagittalIdx = find(contains(indexer,'sagittal panel 1'));
        axialIdx = find(contains(indexer,'axial panel 1'));

        for j = 1:length(widget.tab_CT.Children(coronalIdx).Children(2).Children)
            Cindexer_CT(j) = {widget.tab_CT.Children(coronalIdx).Children(2).Children(j).Tag};
        end
        cCrossHairIdx_CT = find(contains(Cindexer_CT,'coronal_crosshair'));
        for k = 1:length(widget.tab_CT.Children(sagittalIdx).Children(2).Children)
            Sindexer_CT(k) = {widget.tab_CT.Children(sagittalIdx).Children(2).Children(k).Tag};
        end
        sCrossHairIdx_CT = find(contains(Sindexer_CT,'sagittal_crosshair'));
        for l = 1:length(widget.tab_CT.Children(axialIdx).Children(2).Children)
            Aindexer_CT(l) = {widget.tab_CT.Children(axialIdx).Children(2).Children(l).Tag};
        end
        aCrossHairIdx_CT = find(contains(Aindexer_CT,'axial_crosshair'));


        for j = 1:length(widget.tab_T1.Children(coronalIdx).Children(2).Children)
            Cindexer_T1(j) = {widget.tab_T1.Children(coronalIdx).Children(2).Children(j).Tag};
        end
        cCrossHairIdx_T1 = find(contains(Cindexer_T1,'coronal_crosshair'));
        for k = 1:length(widget.tab_T1.Children(sagittalIdx).Children(2).Children)
            Sindexer_T1(k) = {widget.tab_T1.Children(sagittalIdx).Children(2).Children(k).Tag};
        end
        sCrossHairIdx_T1 = find(contains(Sindexer_T1,'sagittal_crosshair'));
        for l = 1:length(widget.tab_T1.Children(axialIdx).Children(2).Children)
            Aindexer_T1(l) = {widget.tab_T1.Children(axialIdx).Children(2).Children(l).Tag};
        end
        aCrossHairIdx_T1 = find(contains(Aindexer_T1,'axial_crosshair'));


        if isequal(currTab,'CT') && ~(isequal(evt.NewValue.Title,'[select CT NIfTI file]'))
            widget.params.panel_ElectrodeParams.Enable = 'on';
            if ~(isequal(widget.tab_T1.Title,'[select Anatomical NIfTI file (optional)]'))
                for i = 1:length(evt.NewValue.Children(paramsIdx).Children)
                    indexerCT(i) = {evt.NewValue.Children(paramsIdx).Children(i).Tag};
                end
                for i = 1:length(widget.tab_T1.Children(paramsIdx).Children)
                    indexerT1(i) = {widget.tab_T1.Children(paramsIdx).Children(i).Tag};
                end
                CTxsliderIdx = find(contains(indexerCT,'X slider'));
                CTysliderIdx = find(contains(indexerCT,'Y slider'));
                CTzsliderIdx = find(contains(indexerCT,'Z slider'));
                CTxfieldIdx = find(contains(indexerCT,'X field'));
                CTyfieldIdx = find(contains(indexerCT,'Y field'));
                CTzfieldIdx = find(contains(indexerCT,'Z field'));
                CTvoxelintIdx = find(contains(indexerCT,'Voxel Intensity'));
                CTcontactlabelIdx = find(contains(indexerCT,'Contact label'));
                CTcontactsliderIdx = find(contains(indexerCT,'Contact slider'));

                T1xsliderIdx = find(contains(indexerT1,'X slider'));
                T1ysliderIdx = find(contains(indexerT1,'Y slider'));
                T1zsliderIdx = find(contains(indexerT1,'Z slider'));
                T1xfieldIdx = find(contains(indexerT1,'X field'));
                T1yfieldIdx = find(contains(indexerT1,'Y field'));
                T1zfieldIdx = find(contains(indexerT1,'Z field'));
                T1voxelintIdx = find(contains(indexerT1,'Voxel Intensity'));
                T1contactlabelIdx = find(contains(indexerT1,'Contact label'));
                T1contactsliderIdx = find(contains(indexerT1,'Contact slider'));

                evt.NewValue.Children(paramsIdx).Children(CTxsliderIdx).Value = ...
                    widget.tab_T1.Children(paramsIdx).Children(T1xsliderIdx).Value;
                evt.NewValue.Children(paramsIdx).Children(CTysliderIdx).Value = ...
                    widget.tab_T1.Children(paramsIdx).Children(T1ysliderIdx).Value;
                evt.NewValue.Children(paramsIdx).Children(CTzsliderIdx).Value = ...
                    widget.tab_T1.Children(paramsIdx).Children(T1zsliderIdx).Value;

                evt.NewValue.Children(paramsIdx).Children(CTxfieldIdx).Value = ...
                    widget.tab_T1.Children(paramsIdx).Children(T1xfieldIdx).Value;
                evt.NewValue.Children(paramsIdx).Children(CTyfieldIdx).Value = ...
                    widget.tab_T1.Children(paramsIdx).Children(T1yfieldIdx).Value;
                evt.NewValue.Children(paramsIdx).Children(CTzfieldIdx).Value = ...
                    widget.tab_T1.Children(paramsIdx).Children(T1zfieldIdx).Value;

                evt.NewValue.Children(paramsIdx).Children(CTvoxelintIdx).Text = ...
                    ['Voxel intensity: ' mat2str(round(widget.glassbrain.UserData.CTvol(...
                    evt.NewValue.Children(paramsIdx).Children(CTxfieldIdx).Value,...
                    evt.NewValue.Children(paramsIdx).Children(CTyfieldIdx).Value,...
                    evt.NewValue.Children(paramsIdx).Children(CTzfieldIdx).Value)))];
                if isequal(widget.tab_T1.Children(paramsIdx).Children(T1contactlabelIdx).Visible,'on')
                    evt.NewValue.Children(paramsIdx).Children(CTcontactlabelIdx).Visible = 'on';
                    evt.NewValue.Children(paramsIdx).Children(CTzsliderIdx).Visible = 'on';
                else
                    evt.NewValue.Children(paramsIdx).Children(CTcontactlabelIdx).Visible = 'off';
                    evt.NewValue.Children(paramsIdx).Children(CTcontactsliderIdx).Visible = 'off';
                end
                evt.NewValue.Children(paramsIdx).Children(CTcontactlabelIdx).Text = ...
                    widget.tab_T1.Children(paramsIdx).Children(T1contactlabelIdx).Text;
                evt.NewValue.Children(paramsIdx).Children(CTcontactsliderIdx).Value = ...
                    widget.tab_T1.Children(paramsIdx).Children(T1contactsliderIdx).Value;

                evt.NewValue.Children(coronalIdx).Children(2).Children(cCrossHairIdx_CT).Position = ...
                    widget.tab_T1.Children(coronalIdx).Children(2).Children(cCrossHairIdx_T1).Position;
                evt.NewValue.Children(coronalIdx).Children(2).Children(length(evt.NewValue.Children(coronalIdx).Children(2).Children)).Tag = ...
                    widget.tab_T1.Children(coronalIdx).Children(2).Children(length(widget.tab_T1.Children(coronalIdx).Children(2).Children)).Tag;
                evt.NewValue.Children(coronalIdx).Children(2).Children(length(evt.NewValue.Children(coronalIdx).Children(2).Children)).CData = widget.glassbrain.UserData.CTvol(:,:,str2double(evt.NewValue.Children(coronalIdx).Children(2).Children(length(widget.tab_CT.Children(coronalIdx).Children(2).Children)).Tag));
                evt.NewValue.Children(coronalIdx).Children(1).Text = ...
                    widget.tab_T1.Children(coronalIdx).Children(1).Text;

                vol_size = size(widget.glassbrain.UserData.CTvol);

                evt.NewValue.Children(sagittalIdx).Children(2).Children(sCrossHairIdx_CT).Position = ...
                    widget.tab_T1.Children(sagittalIdx).Children(2).Children(sCrossHairIdx_T1).Position;
                evt.NewValue.Children(sagittalIdx).Children(2).Children(length(evt.NewValue.Children(sagittalIdx).Children(2).Children)).Tag = ...
                    widget.tab_T1.Children(sagittalIdx).Children(2).Children(length(widget.tab_T1.Children(sagittalIdx).Children(2).Children)).Tag;
                evt.NewValue.Children(sagittalIdx).Children(2).Children(length(evt.NewValue.Children(sagittalIdx).Children(2).Children)).CData = ...
                    reshape(widget.glassbrain.UserData.CTvol(:,str2double(evt.NewValue.Children(sagittalIdx).Children(2).Children(length(widget.tab_CT.Children(sagittalIdx).Children(2).Children)).Tag),:),[vol_size(1),vol_size(3)]);
                evt.NewValue.Children(sagittalIdx).Children(1).Text = ...
                    widget.tab_T1.Children(sagittalIdx).Children(1).Text;

                evt.NewValue.Children(axialIdx).Children(2).Children(aCrossHairIdx_CT).Position = ...
                    widget.tab_T1.Children(axialIdx).Children(2).Children(aCrossHairIdx_T1).Position;
                evt.NewValue.Children(axialIdx).Children(2).Children(length(evt.NewValue.Children(axialIdx).Children(2).Children)).Tag = ...
                    widget.tab_T1.Children(axialIdx).Children(2).Children(length(widget.tab_T1.Children(axialIdx).Children(2).Children)).Tag;
                evt.NewValue.Children(axialIdx).Children(2).Children(length(evt.NewValue.Children(axialIdx).Children(2).Children)).CData = ...
                    rot90(reshape(widget.glassbrain.UserData.CTvol(str2double(evt.NewValue.Children(axialIdx).Children(2).Children(length(widget.tab_CT.Children(axialIdx).Children(2).Children)).Tag),:,:),[vol_size(2),vol_size(3)]));
                evt.NewValue.Children(axialIdx).Children(1).Text = ...
                    widget.tab_T1.Children(axialIdx).Children(1).Text;

            end
            
        elseif isequal(currTab,'T1') && ~(isequal(evt.NewValue.Title,'[select Anatomical NIfTI file (optional)]'))
            widget.params.panel_ElectrodeParams.Enable = 'off';
            if ~(isequal(widget.tab_CT.Title,'[select CT NIfTI file]'))
                for i = 1:length(evt.NewValue.Children(paramsIdx).Children)
                    indexerT1(i) = {evt.NewValue.Children(paramsIdx).Children(i).Tag};
                end
                for i = 1:length(widget.tab_CT.Children(paramsIdx).Children)
                    indexerCT(i) = {widget.tab_CT.Children(paramsIdx).Children(i).Tag};
                end
                CTxsliderIdx = find(contains(indexerCT,'X slider'));
                CTysliderIdx = find(contains(indexerCT,'Y slider'));
                CTzsliderIdx = find(contains(indexerCT,'Z slider'));
                CTxfieldIdx = find(contains(indexerCT,'X field'));
                CTyfieldIdx = find(contains(indexerCT,'Y field'));
                CTzfieldIdx = find(contains(indexerCT,'Z field'));
                CTvoxelintIdx = find(contains(indexerCT,'Voxel Intensity'));
                CTcontactlabelIdx = find(contains(indexerCT,'Contact label'));
                CTcontactsliderIdx = find(contains(indexerCT,'Contact slider'));

                T1xsliderIdx = find(contains(indexerT1,'X slider'));
                T1ysliderIdx = find(contains(indexerT1,'Y slider'));
                T1zsliderIdx = find(contains(indexerT1,'Z slider'));
                T1xfieldIdx = find(contains(indexerT1,'X field'));
                T1yfieldIdx = find(contains(indexerT1,'Y field'));
                T1zfieldIdx = find(contains(indexerT1,'Z field'));
                T1voxelintIdx = find(contains(indexerT1,'Voxel Intensity'));
                T1contactlabelIdx = find(contains(indexerT1,'Contact label'));
                T1contactsliderIdx = find(contains(indexerT1,'Contact slider'));

                evt.NewValue.Children(paramsIdx).Children(T1xsliderIdx).Value = ...
                    widget.tab_CT.Children(paramsIdx).Children(CTxsliderIdx).Value;
                evt.NewValue.Children(paramsIdx).Children(T1ysliderIdx).Value = ...
                    widget.tab_CT.Children(paramsIdx).Children(CTysliderIdx).Value;
                evt.NewValue.Children(paramsIdx).Children(T1zsliderIdx).Value = ...
                    widget.tab_CT.Children(paramsIdx).Children(CTzsliderIdx).Value;

                evt.NewValue.Children(paramsIdx).Children(T1xfieldIdx).Value = ...
                    widget.tab_CT.Children(paramsIdx).Children(CTxfieldIdx).Value;
                evt.NewValue.Children(paramsIdx).Children(T1yfieldIdx).Value = ...
                    widget.tab_CT.Children(paramsIdx).Children(CTyfieldIdx).Value;
                evt.NewValue.Children(paramsIdx).Children(T1zfieldIdx).Value = ...
                    widget.tab_CT.Children(paramsIdx).Children(CTzfieldIdx).Value;

                evt.NewValue.Children(paramsIdx).Children(T1voxelintIdx).Text = ...
                    ['Voxel intensity: ' mat2str(round(widget.glassbrain.UserData.T1vol(...
                    evt.NewValue.Children(paramsIdx).Children(T1xfieldIdx).Value,...
                    evt.NewValue.Children(paramsIdx).Children(T1yfieldIdx).Value,...
                    evt.NewValue.Children(paramsIdx).Children(T1zfieldIdx).Value)))];
                if isequal(widget.tab_CT.Children(paramsIdx).Children(CTcontactlabelIdx).Visible,'on')
                    evt.NewValue.Children(paramsIdx).Children(T1contactlabelIdx).Visible = 'on';
                    evt.NewValue.Children(paramsIdx).Children(T1contactsliderIdx).Visible = 'on';
                else
                    evt.NewValue.Children(paramsIdx).Children(T1contactlabelIdx).Visible = 'off';
                    evt.NewValue.Children(paramsIdx).Children(T1contactsliderIdx).Visible = 'off';
                end
                evt.NewValue.Children(paramsIdx).Children(T1contactlabelIdx).Text = ...
                    widget.tab_CT.Children(paramsIdx).Children(CTcontactlabelIdx).Text;
                evt.NewValue.Children(paramsIdx).Children(T1contactsliderIdx).Value = ...
                    widget.tab_CT.Children(paramsIdx).Children(CTcontactsliderIdx).Value;
                evt.NewValue.Children(paramsIdx).Children(T1contactsliderIdx).Limits = ...
                    widget.tab_CT.Children(paramsIdx).Children(CTcontactsliderIdx).Limits;
                evt.NewValue.Children(paramsIdx).Children(T1contactsliderIdx).MajorTicks = ...
                    widget.tab_CT.Children(paramsIdx).Children(CTcontactsliderIdx).MajorTicks;

                evt.NewValue.Children(coronalIdx).Children(2).Children(cCrossHairIdx_T1).Position = ...
                    widget.tab_CT.Children(coronalIdx).Children(2).Children(cCrossHairIdx_CT).Position;
                evt.NewValue.Children(coronalIdx).Children(2).Children(length(evt.NewValue.Children(coronalIdx).Children(2).Children)).Tag = ...
                    widget.tab_CT.Children(coronalIdx).Children(2).Children(length(widget.tab_CT.Children(coronalIdx).Children(2).Children)).Tag;
                evt.NewValue.Children(coronalIdx).Children(2).Children(length(evt.NewValue.Children(coronalIdx).Children(2).Children)).CData = ...
                    widget.glassbrain.UserData.T1vol(:,:,str2double(evt.NewValue.Children(coronalIdx).Children(2).Children(length(widget.tab_T1.Children(coronalIdx).Children(2).Children)).Tag));
                evt.NewValue.Children(coronalIdx).Children(1).Text = ...
                    widget.tab_CT.Children(coronalIdx).Children(1).Text;

                vol_size = size(widget.glassbrain.UserData.T1vol);

                evt.NewValue.Children(sagittalIdx).Children(2).Children(sCrossHairIdx_T1).Position = ...
                    widget.tab_CT.Children(sagittalIdx).Children(2).Children(sCrossHairIdx_CT).Position;
                evt.NewValue.Children(sagittalIdx).Children(2).Children(length(evt.NewValue.Children(sagittalIdx).Children(2).Children)).Tag = ...
                    widget.tab_CT.Children(sagittalIdx).Children(2).Children(length(widget.tab_CT.Children(sagittalIdx).Children(2).Children)).Tag;
                evt.NewValue.Children(sagittalIdx).Children(2).Children(length(evt.NewValue.Children(sagittalIdx).Children(2).Children)).CData = ...
                    reshape(widget.glassbrain.UserData.T1vol(:,str2double(evt.NewValue.Children(sagittalIdx).Children(2).Children(length(widget.tab_T1.Children(sagittalIdx).Children(2).Children)).Tag),:),[vol_size(1),vol_size(3)]);
                evt.NewValue.Children(sagittalIdx).Children(1).Text = ...
                    widget.tab_CT.Children(sagittalIdx).Children(1).Text;

                evt.NewValue.Children(axialIdx).Children(2).Children(aCrossHairIdx_T1).Position = ...
                    widget.tab_CT.Children(axialIdx).Children(2).Children(aCrossHairIdx_CT).Position;
                evt.NewValue.Children(axialIdx).Children(2).Children(length(evt.NewValue.Children(axialIdx).Children(2).Children)).Tag = ...
                    widget.tab_CT.Children(axialIdx).Children(2).Children(length(widget.tab_CT.Children(axialIdx).Children(2).Children)).Tag;
                evt.NewValue.Children(axialIdx).Children(2).Children(length(evt.NewValue.Children(axialIdx).Children(2).Children)).CData = ...
                    rot90(reshape(widget.glassbrain.UserData.T1vol(str2double(evt.NewValue.Children(axialIdx).Children(2).Children(length(widget.tab_T1.Children(axialIdx).Children(2).Children)).Tag),:,:),[vol_size(2),vol_size(3)]));
                evt.NewValue.Children(axialIdx).Children(1).Text = ...
                    widget.tab_CT.Children(axialIdx).Children(1).Text;

            end
        else
            widget.params.panel_ElectrodeParams.Enable = 'off';
        end
    
    else
        widget.params.panel_ElectrodeParams.Enable = 'off';
    
    end
end