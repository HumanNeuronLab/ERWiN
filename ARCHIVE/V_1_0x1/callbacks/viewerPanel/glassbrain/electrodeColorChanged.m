function electrodeColorChanged(~,~,widget)
    
    color = uisetcolor;
    field = widget.tree_Summary.SelectedNodes.Tag;
    widget.glassbrain.UserData.electrodes.(field).Color = color;
    widget.glassbrain.UserData.electrodes.Electrode1.ElectrodevolView.Color = color;
    widget.glassbrain.UserData.electrodes.Electrode1.ElectrodevolView.MarkerFaceColor = color;
    widget.glassbrain.UserData.electrodes.Electrode1.ElectrodevolView.MarkerEdgeColor = color;
    widget.glassbrain.UserData.highlightedContact.point.MarkerEdgeColor = color;
    widget.glassbrain.UserData.lampColor.Color = color;

end