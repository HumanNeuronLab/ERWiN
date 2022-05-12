function widget = drawRightPanel(widget,wip)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% ---------------------- Electrodes Summary Panel ----------------------- %

widget.tree_Summary = uitree('Parent',widget.fig,'Enable','off',...
    'Position',[widget.panel_CentralTabsMRI.Position(1)+widget.panel_CentralTabsMRI.Position(3)+40,60,widget.panel_CentralTabsMRI.Position(1)-80,wip(4)-120]);
widget.tree = uipanel('Parent',widget.fig,'Visible','off');
widget = createTreeNode(widget,widget.tree_Summary,'Electrode1');
widget.params.button_done = uibutton('Parent',widget.fig,'Enable','off','Text','Done',...
    'Position',[widget.tree_Summary.Position(1)+widget.tree_Summary.Position(3)/2-50,20,100,30]);

end