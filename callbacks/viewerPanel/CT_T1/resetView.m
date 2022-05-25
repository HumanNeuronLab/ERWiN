function resetView(~,~,widget)
    data = widget.panel_CentralTabsMRI.SelectedTab.Tag;
    widget.transform.UserData.action = 'resetView';
    selectFile(data, [], widget)

end