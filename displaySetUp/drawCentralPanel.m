function [widget,wip] = drawCentralPanel(widget)
%drawCentralPanel Summary of this function goes here
%   Detailed explanation goes here
% -------------------------- Slice viewer panel ------------------------- %


wip = round(widget.fig.Position);

widget.panel_CentralTabsMRI = uitabgroup('Parent',widget.fig,...
    'Position',round([(wip(3)-wip(4))/2,10,wip(4),wip(4)-20]));
widget.tab_CT = uitab('Parent',widget.panel_CentralTabsMRI,...
    'Title','[select CT NIfTI file]','Tag','CT');
widget.tab_T1 = uitab('Parent',widget.panel_CentralTabsMRI,...
    'Title','[select Anatomical NIfTI file (optional)]','Tag','T1');
widget.tab_glassbrain = uitab('Parent',widget.panel_CentralTabsMRI,...
    'Title','[3D Glassbrain]','Tag','glassbrain');
widget.glassbrain = uipanel('Parent',widget.fig,'Visible','off');
pause(2);
tab_IP = widget.tab_CT.InnerPosition;
widget.panel_sliceView1_CT = uipanel('Parent',widget.tab_CT,...
    'Position',round([(tab_IP(3)-tab_IP(4))/2,tab_IP(4)/2,tab_IP(4)/2,tab_IP(4)/2]),...
    'Tag','coronal panel 1','BorderType','none');
widget.ax_sliceView1_CT = axes('Parent',widget.panel_sliceView1_CT,...
    'XTick',[],'YTick',[],'Tag','coronal ax','Color',[0.3,0.3,0.3],...
    'Position',[0.05,0.01,0.94,0.94],'XAxisLocation','top');
widget.ax_sliceView1_CT.XLabel.String = 'X';
widget.ax_sliceView1_CT.YLabel.String = 'Y';
widget.label_coronal_CT = uilabel('Parent',widget.panel_sliceView1_CT,'Text','Coronal Slice','FontColor',[1 1 1],...
    'Position',[widget.panel_sliceView1_CT.Position(3)*widget.ax_sliceView1_CT.Position(1)+10,...
    widget.panel_sliceView1_CT.Position(4)*widget.ax_sliceView1_CT.Position(2)+10,...
    300,20]);

widget.panel_sliceView2_CT = uipanel('Parent',widget.tab_CT,...
    'Position',round([tab_IP(3)/2,tab_IP(4)/2,tab_IP(4)/2,tab_IP(4)/2]),...
    'Tag','sagittal panel 1','BorderType','none');
widget.ax_sliceView2_CT = axes('Parent',widget.panel_sliceView2_CT,...
    'XTick',[],'YTick',[],'Tag','sagittal ax','Color',[0.3,0.3,0.3],...
    'Position',[0.01,0.01,0.94,0.94],'XAxisLocation','top');
widget.ax_sliceView2_CT.XLabel.String = 'Z';
widget.label_sagittal_CT = uilabel('Parent',widget.panel_sliceView2_CT,'Text','Sagittal Slice','FontColor',[1 1 1],...
    'Position',[widget.panel_sliceView2_CT.Position(3)*widget.ax_sliceView2_CT.Position(1)+10,...
    widget.panel_sliceView2_CT.Position(4)*widget.ax_sliceView2_CT.Position(2)+10,...
    300,20]);

widget.panel_sliceView3_CT = uipanel('Parent',widget.tab_CT,...
    'Position',round([(tab_IP(3)-tab_IP(4))/2,0,tab_IP(4)/2,tab_IP(4)/2]),...
    'Tag','axial panel 1','BorderType','none');
widget.ax_sliceView3_CT = axes('Parent',widget.panel_sliceView3_CT,...
    'XTick',[],'YTick',[],'Tag','axial ax','Color',[0.3,0.3,0.3],...
    'Position',[0.05,0.05,0.94,0.94],'XAxisLocation','top');
widget.ax_sliceView3_CT.YLabel.String = 'Z';
widget.label_axial_CT = uilabel('Parent',widget.panel_sliceView3_CT,'Text','Axial Slice','FontColor',[1 1 1],...
    'Position',[widget.panel_sliceView3_CT.Position(3)*widget.ax_sliceView3_CT.Position(1)+10,...
    widget.panel_sliceView3_CT.Position(4)*widget.ax_sliceView3_CT.Position(2)+10,...
    300,20]);

widget.panel_sliceView4_CT = uipanel('Parent',widget.tab_CT,...
    'Position',[tab_IP(3)/2 + widget.ax_sliceView2_CT.Position(1)*widget.panel_sliceView2_CT.Position(3),...
    widget.ax_sliceView3_CT.Position(2)*widget.panel_sliceView3_CT.Position(4),...
    widget.ax_sliceView2_CT.Position(3)*widget.panel_sliceView2_CT.Position(3),...
    widget.ax_sliceView3_CT.Position(4)*widget.panel_sliceView3_CT.Position(4)],...
    'Tag','slice params panel 1');

widget.button_selectNifti_CT = uibutton('Parent',widget.panel_sliceView4_CT,'Text','Select NIfTI file',...
    'Position',[15,widget.panel_sliceView4_CT.Position(4)-37,100,22],'BackgroundColor',[1,0.65,0]);
widget.label_selectNifti_CT = uilabel('Parent',widget.panel_sliceView4_CT,'Text','[Select NIfTI file]',...
    'Position',[widget.button_selectNifti_CT.Position(1)+widget.button_selectNifti_CT.Position(3)+15,widget.button_selectNifti_CT.Position(2),100,22]);
widget.label_voxelIntensity_CT = uilabel('Parent',widget.panel_sliceView4_CT,'Text','Voxel intensity:',...
    'Position',[widget.button_selectNifti_CT.Position(1),widget.button_selectNifti_CT.Position(2)-37,150,22],'Tag','Voxel Intensity');
widget.label_Xvalue_CT = uilabel('Parent',widget.panel_sliceView4_CT,'Text','X:',...
    'Position',[15,widget.label_voxelIntensity_CT.Position(2)-37,20,20]);
widget.label_Yvalue_CT = uilabel('Parent',widget.panel_sliceView4_CT,'Text','Y:',...
    'Position',[15,widget.label_Xvalue_CT.Position(2)-30,20,20]);
widget.label_Zvalue_CT = uilabel('Parent',widget.panel_sliceView4_CT,'Text','Z:',...
    'Position',[15,widget.label_Yvalue_CT.Position(2)-30,20,20]);
widget.field_Xvalue_CT = uieditfield('numeric','Parent',widget.panel_sliceView4_CT,'HorizontalAlignment','center','Tag','X field',...
    'Position',[widget.label_Xvalue_CT.Position(1)+widget.label_Xvalue_CT.Position(3)+10,widget.label_Xvalue_CT.Position(2),50,22],...
    'Enable','off');
widget.field_Yvalue_CT = uieditfield('numeric','Parent',widget.panel_sliceView4_CT,'HorizontalAlignment','center','Tag','Y field',...
    'Position',[widget.label_Yvalue_CT.Position(1)+widget.label_Yvalue_CT.Position(3)+10,widget.label_Yvalue_CT.Position(2),50,22],...
    'Enable','off');
widget.field_Zvalue_CT = uieditfield('numeric','Parent',widget.panel_sliceView4_CT,'HorizontalAlignment','center','Tag','Z field',...
    'Position',[widget.label_Zvalue_CT.Position(1)+widget.label_Zvalue_CT.Position(3)+10,widget.label_Zvalue_CT.Position(2),50,22],...
    'Enable','off');
widget.button_smallerX_CT = uibutton('Parent',widget.panel_sliceView4_CT,'Text','<','Tag','X',...
    'Position',[widget.field_Xvalue_CT.Position(1)+widget.field_Xvalue_CT.Position(3)+10,widget.field_Xvalue_CT.Position(2),20,20],...
    'Enable','off');
widget.button_smallerY_CT = uibutton('Parent',widget.panel_sliceView4_CT,'Text','<','Tag','Y',...
    'Position',[widget.field_Yvalue_CT.Position(1)+widget.field_Yvalue_CT.Position(3)+10,widget.field_Yvalue_CT.Position(2),20,20],...
    'Enable','off');
widget.button_smallerZ_CT = uibutton('Parent',widget.panel_sliceView4_CT,'Text','<','Tag','Z',...
    'Position',[widget.field_Zvalue_CT.Position(1)+widget.field_Zvalue_CT.Position(3)+10,widget.field_Zvalue_CT.Position(2),20,20],...
    'Enable','off');
widget.slider_X_CT = uislider('Parent',widget.panel_sliceView4_CT,'MajorTicks',[],'MinorTicks',[],'Tag','X slider',...
    'Enable','off');
widget.slider_X_CT.Position = [widget.button_smallerX_CT.Position(1)+widget.button_smallerX_CT.Position(3)+10,widget.button_smallerX_CT.Position(2)+10,widget.panel_sliceView4_CT.Position(3)/2,widget.slider_X_CT.Position(4)];
widget.slider_Y_CT = uislider('Parent',widget.panel_sliceView4_CT,'MajorTicks',[],'MinorTicks',[],'Tag','Y slider',...
    'Enable','off');
widget.slider_Y_CT.Position = [widget.button_smallerY_CT.Position(1)+widget.button_smallerY_CT.Position(3)+10,widget.button_smallerY_CT.Position(2)+10,widget.panel_sliceView4_CT.Position(3)/2,widget.slider_Y_CT.Position(4)];
widget.slider_Z_CT = uislider('Parent',widget.panel_sliceView4_CT,'MajorTicks',[],'MinorTicks',[],'Tag','Z slider',...
    'Enable','off');
widget.slider_Z_CT.Position = [widget.button_smallerZ_CT.Position(1)+widget.button_smallerZ_CT.Position(3)+10,widget.button_smallerZ_CT.Position(2)+10,widget.panel_sliceView4_CT.Position(3)/2,widget.slider_Z_CT.Position(4)];
widget.button_greaterX_CT = uibutton('Parent',widget.panel_sliceView4_CT,'Text','>','Tag','X',...
    'Position',[widget.slider_X_CT.Position(1)+widget.slider_X_CT.Position(3)+10,widget.field_Xvalue_CT.Position(2),20,20],...
    'Enable','off');
widget.button_greaterY_CT = uibutton('Parent',widget.panel_sliceView4_CT,'Text','>','Tag','Y',...
    'Position',[widget.slider_Y_CT.Position(1)+widget.slider_Y_CT.Position(3)+10,widget.field_Yvalue_CT.Position(2),20,20],...
    'Enable','off');
widget.button_greaterZ_CT = uibutton('Parent',widget.panel_sliceView4_CT,'Text','>','Tag','Z',...
    'Position',[widget.slider_Z_CT.Position(1)+widget.slider_Z_CT.Position(3)+10,widget.field_Zvalue_CT.Position(2),20,20],...
    'Enable','off');
widget.label_contacts_CT = uilabel('Parent',widget.panel_sliceView4_CT,'Text','Contacts: ',...
    'Position',[15,widget.slider_Z_CT.Position(2)-50,200,20],'Tag','Contact label',...
    'Visible','off');
widget.slider_contacts_CT = uislider('Parent',widget.panel_sliceView4_CT,'MajorTicks',[],'MinorTicks',[],'Visible','off','Tag','Contact slider');
widget.slider_contacts_CT.Position = [widget.panel_sliceView4_CT.Position(3)*0.1,widget.label_contacts_CT.Position(2)-27,widget.panel_sliceView4_CT.Position(3)*0.8,widget.slider_contacts_CT.Position(4)];
widget.button_correctContacts = uibutton('Parent',widget.panel_sliceView4_CT,'Text','Correct',...
    'Position',[widget.panel_sliceView4_CT.Position(3)/2-30,widget.label_contacts_CT.Position(2),60,22],...
    'Enable','off','Visible','off');

%%%%%%%%%%%%
widget.panel_sliceView1_T1 = uipanel('Parent',widget.tab_T1,...
    'Position',round([(tab_IP(3)-tab_IP(4))/2,tab_IP(4)/2,tab_IP(4)/2,tab_IP(4)/2]),...
    'Tag','coronal panel 1','BorderType','none');
widget.ax_sliceView1_T1 = axes('Parent',widget.panel_sliceView1_T1,...
    'XTick',[],'YTick',[],'Tag','coronal ax','Color',[0.3,0.3,0.3],...
    'Position',[0.05,0.01,0.94,0.94],'XAxisLocation','top');
widget.ax_sliceView1_T1.XLabel.String = 'X';
widget.ax_sliceView1_T1.YLabel.String = 'Y';
widget.label_coronal_T1 = uilabel('Parent',widget.panel_sliceView1_T1,'Text','Coronal Slice','FontColor',[1 1 1],...
    'Position',[widget.panel_sliceView1_T1.Position(3)*widget.ax_sliceView1_T1.Position(1)+10,...
    widget.panel_sliceView1_T1.Position(4)*widget.ax_sliceView1_T1.Position(2)+10,...
    300,20]);

widget.panel_sliceView2_T1 = uipanel('Parent',widget.tab_T1,...
    'Position',round([tab_IP(3)/2,tab_IP(4)/2,tab_IP(4)/2,tab_IP(4)/2]),...
    'Tag','sagittal panel 1','BorderType','none');
widget.ax_sliceView2_T1 = axes('Parent',widget.panel_sliceView2_T1,...
    'XTick',[],'YTick',[],'Tag','sagittal ax','Color',[0.3,0.3,0.3],...
    'Position',[0.01,0.01,0.94,0.94],'XAxisLocation','top');
widget.ax_sliceView2_T1.XLabel.String = 'Z';
widget.label_sagittal_T1 = uilabel('Parent',widget.panel_sliceView2_T1,'Text','Sagittal Slice','FontColor',[1 1 1],...
    'Position',[widget.panel_sliceView2_T1.Position(3)*widget.ax_sliceView2_T1.Position(1)+10,...
    widget.panel_sliceView2_T1.Position(4)*widget.ax_sliceView2_T1.Position(2)+10,...
    300,20]);

widget.panel_sliceView3_T1 = uipanel('Parent',widget.tab_T1,...
    'Position',round([(tab_IP(3)-tab_IP(4))/2,0,tab_IP(4)/2,tab_IP(4)/2]),...
    'Tag','axial panel 1','BorderType','none');
widget.ax_sliceView3_T1 = axes('Parent',widget.panel_sliceView3_T1,...
    'XTick',[],'YTick',[],'Tag','axial ax','Color',[0.3,0.3,0.3],...
    'Position',[0.05,0.05,0.94,0.94],'XAxisLocation','top');
widget.ax_sliceView3_T1.YLabel.String = 'Z';
widget.label_axial_T1 = uilabel('Parent',widget.panel_sliceView3_T1,'Text','Axial Slice','FontColor',[1 1 1],...
    'Position',[widget.panel_sliceView3_T1.Position(3)*widget.ax_sliceView3_T1.Position(1)+10,...
    widget.panel_sliceView3_T1.Position(4)*widget.ax_sliceView3_T1.Position(2)+10,...
    300,20]);

widget.panel_sliceView4_T1 = uipanel('Parent',widget.tab_T1,...
    'Position',[tab_IP(3)/2 + widget.ax_sliceView2_T1.Position(1)*widget.panel_sliceView2_T1.Position(3),...
    widget.ax_sliceView3_T1.Position(2)*widget.panel_sliceView3_T1.Position(4),...
    widget.ax_sliceView2_T1.Position(3)*widget.panel_sliceView2_T1.Position(3),...
    widget.ax_sliceView3_T1.Position(4)*widget.panel_sliceView3_T1.Position(4)],...
    'Tag','slice params panel 1');

widget.button_selectNifti_T1 = uibutton('Parent',widget.panel_sliceView4_T1,'Text','Select NIfTI file',...
    'Position',[15,widget.panel_sliceView4_T1.Position(4)-37,100,22],'BackgroundColor',[1,0.65,0]);
widget.label_selectNifti_T1 = uilabel('Parent',widget.panel_sliceView4_T1,'Text','[Select NIfTI file]',...
    'Position',[widget.button_selectNifti_T1.Position(1)+widget.button_selectNifti_T1.Position(3)+15,widget.button_selectNifti_T1.Position(2),100,22]);
widget.label_voxelIntensity_T1 = uilabel('Parent',widget.panel_sliceView4_T1,'Text','Voxel intensity:',...
    'Position',[widget.button_selectNifti_T1.Position(1),widget.button_selectNifti_T1.Position(2)-37,150,22],'Tag','Voxel Intensity');
widget.label_Xvalue_T1 = uilabel('Parent',widget.panel_sliceView4_T1,'Text','X:',...
    'Position',[15,widget.label_voxelIntensity_T1.Position(2)-37,20,20]);
widget.label_Yvalue_T1 = uilabel('Parent',widget.panel_sliceView4_T1,'Text','Y:',...
    'Position',[15,widget.label_Xvalue_T1.Position(2)-30,20,20]);
widget.label_Zvalue_T1 = uilabel('Parent',widget.panel_sliceView4_T1,'Text','Z:',...
    'Position',[15,widget.label_Yvalue_T1.Position(2)-30,20,20]);
widget.field_Xvalue_T1 = uieditfield('numeric','Parent',widget.panel_sliceView4_T1,'HorizontalAlignment','center','Tag','X field',...
    'Position',[widget.label_Xvalue_T1.Position(1)+widget.label_Xvalue_T1.Position(3)+10,widget.label_Xvalue_T1.Position(2),50,22],...
    'Enable','off');
widget.field_Yvalue_T1 = uieditfield('numeric','Parent',widget.panel_sliceView4_T1,'HorizontalAlignment','center','Tag','Y field',...
    'Position',[widget.label_Yvalue_T1.Position(1)+widget.label_Yvalue_T1.Position(3)+10,widget.label_Yvalue_T1.Position(2),50,22],...
    'Enable','off');
widget.field_Zvalue_T1 = uieditfield('numeric','Parent',widget.panel_sliceView4_T1,'HorizontalAlignment','center','Tag','Z field',...
    'Position',[widget.label_Zvalue_T1.Position(1)+widget.label_Zvalue_T1.Position(3)+10,widget.label_Zvalue_T1.Position(2),50,22],...
    'Enable','off');
widget.button_smallerX_T1 = uibutton('Parent',widget.panel_sliceView4_T1,'Text','<','Tag','X',...
    'Position',[widget.field_Xvalue_T1.Position(1)+widget.field_Xvalue_T1.Position(3)+10,widget.field_Xvalue_T1.Position(2),20,20],...
    'Enable','off');
widget.button_smallerY_T1 = uibutton('Parent',widget.panel_sliceView4_T1,'Text','<','Tag','Y',...
    'Position',[widget.field_Yvalue_T1.Position(1)+widget.field_Yvalue_T1.Position(3)+10,widget.field_Yvalue_T1.Position(2),20,20],...
    'Enable','off');
widget.button_smallerZ_T1 = uibutton('Parent',widget.panel_sliceView4_T1,'Text','<','Tag','Z',...
    'Position',[widget.field_Zvalue_T1.Position(1)+widget.field_Zvalue_T1.Position(3)+10,widget.field_Zvalue_T1.Position(2),20,20],...
    'Enable','off');
widget.slider_X_T1 = uislider('Parent',widget.panel_sliceView4_T1,'MajorTicks',[],'MinorTicks',[],'Tag','X slider',...
    'Enable','off');
widget.slider_X_T1.Position = [widget.button_smallerX_T1.Position(1)+widget.button_smallerX_T1.Position(3)+10,widget.button_smallerX_T1.Position(2)+10,widget.panel_sliceView4_T1.Position(3)/2,widget.slider_X_CT.Position(4)];
widget.slider_Y_T1 = uislider('Parent',widget.panel_sliceView4_T1,'MajorTicks',[],'MinorTicks',[],'Tag','Y slider',...
    'Enable','off');
widget.slider_Y_T1.Position = [widget.button_smallerY_T1.Position(1)+widget.button_smallerY_T1.Position(3)+10,widget.button_smallerY_T1.Position(2)+10,widget.panel_sliceView4_T1.Position(3)/2,widget.slider_Y_CT.Position(4)];
widget.slider_Z_T1 = uislider('Parent',widget.panel_sliceView4_T1,'MajorTicks',[],'MinorTicks',[],'Tag','Z slider',...
    'Enable','off');
widget.slider_Z_T1.Position = [widget.button_smallerZ_T1.Position(1)+widget.button_smallerZ_T1.Position(3)+10,widget.button_smallerZ_T1.Position(2)+10,widget.panel_sliceView4_T1.Position(3)/2,widget.slider_Z_CT.Position(4)];
widget.button_greaterX_T1 = uibutton('Parent',widget.panel_sliceView4_T1,'Text','>','Tag','X',...
    'Position',[widget.slider_X_T1.Position(1)+widget.slider_X_T1.Position(3)+10,widget.field_Xvalue_T1.Position(2),20,20],...
    'Enable','off');
widget.button_greaterY_T1 = uibutton('Parent',widget.panel_sliceView4_T1,'Text','>','Tag','Y',...
    'Position',[widget.slider_Y_T1.Position(1)+widget.slider_Y_T1.Position(3)+10,widget.field_Yvalue_T1.Position(2),20,20],...
    'Enable','off');
widget.button_greaterZ_T1 = uibutton('Parent',widget.panel_sliceView4_T1,'Text','>','Tag','Z',...
    'Position',[widget.slider_Z_T1.Position(1)+widget.slider_Z_T1.Position(3)+10,widget.field_Zvalue_T1.Position(2),20,20],...
    'Enable','off');
widget.label_contacts_T1 = uilabel('Parent',widget.panel_sliceView4_T1,'Text','Contacts: ',...
    'Position',[15,widget.slider_Z_T1.Position(2)-50,200,20],'Tag','Contact label',...
    'Visible','off');
widget.slider_contacts_T1 = uislider('Parent',widget.panel_sliceView4_T1,'MajorTicks',[],'MinorTicks',[],'Visible','off','Tag','Contact slider');
widget.slider_contacts_T1.Position = [widget.panel_sliceView4_T1.Position(3)*0.1,widget.label_contacts_T1.Position(2)-27,widget.panel_sliceView4_T1.Position(3)*0.8,widget.slider_contacts_T1.Position(4)];

%%%%%%%%%%%%

widget.glassbrain.UserData.panel = uipanel('Parent',widget.tab_glassbrain,'Position',[50,10,tab_IP(3)-100,tab_IP(4)-150]);
widget.glassbrain.UserData.axes = axes('Parent',widget.glassbrain.UserData.panel,'View',[30,5]);
widget.glassbrain.UserData.axes.XDir = 'reverse';
widget.glassbrain.UserData.axes.ZDir = 'reverse';
axis(widget.glassbrain.UserData.axes,'tight','equal','vis3d');
bg_color = 0.25;
widget.glassbrain.UserData.axes.Color = [bg_color bg_color bg_color];
widget.glassbrain.UserData.panel.BackgroundColor = [bg_color bg_color bg_color];
axis_color = 0.7;
widget.glassbrain.UserData.axes.XColor = [axis_color axis_color axis_color];
widget.glassbrain.UserData.axes.YColor = [axis_color axis_color axis_color];
widget.glassbrain.UserData.axes.ZColor = [axis_color axis_color axis_color];
widget.glassbrain.UserData.lgt = camlight(widget.glassbrain.UserData.axes,'headlight');
widget.glassbrain.UserData.buttonColor = uibutton('Parent',widget.tab_glassbrain,'Position',[tab_IP(3)/2-50,widget.glassbrain.UserData.panel.Position(2)+widget.glassbrain.UserData.panel.Position(4)+10,50,22],'Text','Color','Enable','off');
widget.glassbrain.UserData.lampColor = uilamp('Parent',widget.tab_glassbrain,'Color',[0.95 0.95 0.95],...
    'Position',[widget.glassbrain.UserData.buttonColor.Position(1)+widget.glassbrain.UserData.buttonColor.Position(3)+10,...
    widget.glassbrain.UserData.buttonColor.Position(2)+(widget.glassbrain.UserData.buttonColor.Position(4)/2)-5,10 10]);
widget.glassbrain.UserData.panelVolSelect = uipanel('Parent',widget.tab_glassbrain,'Position',[widget.glassbrain.UserData.panel.Position(1),widget.glassbrain.UserData.panel.Position(2)+widget.glassbrain.UserData.panel.Position(4)+10,100,70]);
widget.glassbrain.UserData.checkboxCT = uicheckbox('Parent',widget.glassbrain.UserData.panelVolSelect,'Position',[10 40 100 20],'Text','View CT','Enable','off');
widget.glassbrain.UserData.checkboxT1 = uicheckbox('Parent',widget.glassbrain.UserData.panelVolSelect,'Position',[10 10 100 20],'Text','View T1','Enable','off');
widget.glassbrain.UserData.ColorList = [[1 0 0];[1 135/255 0];[1 211/255 0];...
    [222/255 1 10/255];[161/255 1 10/255];[10/255 1 153/255];...
    [10/255 239/255 1];[20/255 125/255 245/255];[88/255 10/255 1];...
    [190/255 10/255 1];[1 153/255 153/255];[216/255 1 153/255];...
    [199/255 173/255 1];[157/255 201/255 251/255];[241/255 1 153/255];...
    [173/255 250/255 1];[173/255 1 221/255];[1 238/255 153/255];...
    [1 207/255 153/255];[233/255 173/255 1];[152/255 245/255 225/255];...
    [251/255 248/255 204/255];[247/255 37/255 133/255];[4/255 243/255 63/255]];


end