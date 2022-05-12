function widget = drawLeftPanel(widget,wip)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% ---------------------- Electrode Parameter Panel ---------------------- %

widget.params.panel_ElectrodeParams = uipanel('Parent',widget.fig,'Enable','off',...
    'Position',[40,60,widget.panel_CentralTabsMRI.Position(1)-80,wip(4)-120]);

widget.params.label_NumElectrodes = uilabel('Parent',widget.params.panel_ElectrodeParams,...
    'HorizontalAlignment','right','FontWeight','bold','Text','Number of electrodes: ',...
    'Position',[15,widget.params.panel_ElectrodeParams.Position(4)-37,140,22]);
widget.params.spinner_NumElectrodes = uispinner('Parent',widget.params.panel_ElectrodeParams,...
    'Limits',[1 20],'ValueDisplayFormat','%.0f',...
    'HorizontalAlignment','center','FontWeight','bold','Value',1,...
    'Position',[widget.params.label_NumElectrodes.Position(1)+widget.params.label_NumElectrodes.Position(3)+10,...
    widget.params.label_NumElectrodes.Position(2),45,22]);
widget.params.dropdown_ElectrodeSelector = uidropdown('Parent',widget.params.panel_ElectrodeParams,...
    'Items',{'Electrode1'},'Value','Electrode1',...
    'Position',[widget.params.panel_ElectrodeParams.Position(3)*0.25,widget.params.label_NumElectrodes.Position(2)-37,...
    widget.params.panel_ElectrodeParams.Position(3)*0.5,22]);
widget.params.divider1 = uilabel('Parent',widget.params.panel_ElectrodeParams,'HorizontalAlignment','center',...
    'Text','______________________________',...
    'Position',[0,widget.params.dropdown_ElectrodeSelector.Position(2)-50,widget.params.panel_ElectrodeParams.Position(3),20]);
widget.params.label_ElectrodeName = uilabel('Parent',widget.params.panel_ElectrodeParams,'Text','Electrode name:',...
    'Position',[15,widget.params.divider1.Position(2)-50,150,22]);
widget.params.radiogroup1 = uibuttongroup('Parent',widget.params.panel_ElectrodeParams,'BorderType','none',...
    'Position',[15,widget.params.label_ElectrodeName.Position(2)-15-47,50,47]);
widget.params.radio_R = uiradiobutton('Parent',widget.params.radiogroup1,'Value',true,'Text','R',...
    'Position',[10,widget.params.radiogroup1.Position(4)-22,30,22]);
widget.params.radio_L = uiradiobutton('Parent',widget.params.radiogroup1,'Text','L',...
    'Position',[10,widget.params.radio_R.Position(2)-25,30,22]);
widget.params.radiogroup2 = uibuttongroup('Parent',widget.params.panel_ElectrodeParams,'BorderType','none',...
    'Position',[widget.params.radiogroup1.Position(1)+widget.params.radiogroup1.Position(3),widget.params.radiogroup1.Position(2)-25,50,widget.params.radiogroup1.Position(4)+25]);
widget.params.radio_D = uiradiobutton('Parent',widget.params.radiogroup2,'Text','D','Value',true,...
    'Position',[10,widget.params.radiogroup2.Position(4)-22,30,22]);
widget.params.radio_S = uiradiobutton('Parent',widget.params.radiogroup2,'Text','S','Enable','off',...
    'Position',[10,widget.params.radio_D.Position(2)-25,30,22]);
widget.params.radio_G = uiradiobutton('Parent',widget.params.radiogroup2,'Text','G','Enable','off',...
    'Position',[10,widget.params.radio_S.Position(2)-25,30,22]);
widget.params.field_ElectrodeName = uieditfield('Parent',widget.params.panel_ElectrodeParams,'Value',widget.params.dropdown_ElectrodeSelector.Value,...
    'Position',[widget.params.radiogroup1.Position(3)+widget.params.radiogroup2.Position(3)+15,...
    widget.params.label_ElectrodeName.Position(2)-37,...
    widget.params.panel_ElectrodeParams.Position(3)-widget.params.radiogroup1.Position(3)-widget.params.radiogroup2.Position(3)-30,22]);
widget.params.label_NameAcceptance = uilabel('Parent',widget.params.panel_ElectrodeParams,'Text','[Name accepted status]',...
    'HorizontalAlignment','center','Visible','off',...
    'Position',[0,widget.params.radiogroup2.Position(2)-37,widget.params.panel_ElectrodeParams.Position(3),40]);
widget.params.divider2 = uilabel('Parent',widget.params.panel_ElectrodeParams,'HorizontalAlignment','center',...
    'Text','______________________________',...
    'Position',[0,widget.params.label_NameAcceptance.Position(2)-20,widget.params.panel_ElectrodeParams.Position(3),20]);
widget.params.label_NumContacts = uilabel('Parent',widget.params.panel_ElectrodeParams,'Text','Number of contacts',...
    'Position',[15,widget.params.divider2.Position(2)-50,widget.params.panel_ElectrodeParams.Position(3)/2,22]);
widget.params.field_NumContacts = uieditfield(widget.params.panel_ElectrodeParams,'numeric',...
    'HorizontalAlignment','center','Limits',[0 Inf],...
    'Position',[widget.params.panel_ElectrodeParams.Position(3)-85,widget.params.label_NumContacts.Position(2),50,22]);
widget.params.label_ContactDistance = uilabel('Parent',widget.params.panel_ElectrodeParams,'Text','Inter-contact distance (mm)',...
    'Position',[15,widget.params.label_NumContacts.Position(2)-37,widget.params.panel_ElectrodeParams.Position(3)/2,22]);
widget.params.field_ContactDistance = uieditfield(widget.params.panel_ElectrodeParams,'numeric',...
    'HorizontalAlignment','center','Limits',[0 Inf],...
    'Position',[widget.params.panel_ElectrodeParams.Position(3)-85,widget.params.label_ContactDistance.Position(2),50,22]);
widget.params.label_DeepestContact = uilabel('Parent',widget.params.panel_ElectrodeParams,...
    'Text','Deepest contact coordinates (X,Y,Z):',...
    'Position',[15,widget.params.field_ContactDistance.Position(2)-50,widget.params.panel_ElectrodeParams.Position(3),22]);
widget.params.button_PickDeepest = uibutton('push','Parent',widget.params.panel_ElectrodeParams,'Tag','Deepest',...
    'Text','Pick','FontWeight','bold','Position',[15,widget.params.label_DeepestContact.Position(2)-37,50,22]);
widget.params.field_XDeepest = uieditfield(widget.params.panel_ElectrodeParams,'numeric','Limits',[0 Inf],...
    'HorizontalAlignment','center',...
    'Position',[widget.params.button_PickDeepest.Position(3)+40,widget.params.button_PickDeepest.Position(2),50,22]);
widget.params.field_YDeepest = uieditfield(widget.params.panel_ElectrodeParams,'numeric','Limits',[0 Inf],...
    'HorizontalAlignment','center',...
    'Position',[widget.params.field_XDeepest.Position(1)+60,widget.params.label_DeepestContact.Position(2)-37,50,22]);
widget.params.field_ZDeepest = uieditfield(widget.params.panel_ElectrodeParams,'numeric','Limits',[0 Inf],...
    'HorizontalAlignment','center',...
    'Position',[widget.params.field_YDeepest.Position(1)+60,widget.params.label_DeepestContact.Position(2)-37,50,22]);
widget.params.label_SecondContact = uilabel('Parent',widget.params.panel_ElectrodeParams,...
    'Text','Second contact coordinates (X,Y,Z):',...
    'Position',[15,widget.params.field_ZDeepest.Position(2)-50,widget.params.panel_ElectrodeParams.Position(3),22]);
widget.params.button_PickSecond = uibutton('push','Parent',widget.params.panel_ElectrodeParams,'Tag','Second',...
    'Text','Pick','FontWeight','bold','Position',[15,widget.params.label_SecondContact.Position(2)-37,50,22]);
widget.params.field_XSecond = uieditfield(widget.params.panel_ElectrodeParams,'numeric','Limits',[0 Inf],...
    'HorizontalAlignment','center',...
    'Position',[widget.params.button_PickSecond.Position(3)+40,widget.params.button_PickSecond.Position(2),50,22]);
widget.params.field_YSecond = uieditfield(widget.params.panel_ElectrodeParams,'numeric','Limits',[0 Inf],...
    'HorizontalAlignment','center',...
    'Position',[widget.params.field_XSecond.Position(1)+60,widget.params.label_SecondContact.Position(2)-37,50,22]);
widget.params.field_ZSecond = uieditfield(widget.params.panel_ElectrodeParams,'numeric','Limits',[0 Inf],...
    'HorizontalAlignment','center',...
    'Position',[widget.params.field_YSecond.Position(1)+60,widget.params.label_SecondContact.Position(2)-37,50,22]);
widget.params.checkbox_Snapping = uicheckbox('Parent',widget.params.panel_ElectrodeParams,'Value',true,...
    'Text','Enable snapping','Position',[15,widget.params.field_ZSecond.Position(2)-50,120,22]);
widget.params.divider3 = uilabel('Parent',widget.params.panel_ElectrodeParams,'HorizontalAlignment','center',...
    'Text','______________________________',...
    'Position',[0,widget.params.checkbox_Snapping.Position(2)-50,widget.params.panel_ElectrodeParams.Position(3),20]);
widget.params.button_estimate = uibutton('push','Parent',widget.params.panel_ElectrodeParams,'Enable','off',...
    'BackgroundColor',[1,0.65,0],'Text','Estimate',...
    'Position',[widget.params.panel_ElectrodeParams.Position(3)/2-100,widget.params.divider3.Position(2)/2,200,35]);

end