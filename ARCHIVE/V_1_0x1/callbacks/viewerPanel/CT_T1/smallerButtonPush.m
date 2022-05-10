function smallerButtonPush(data,~,widget)
    switch data.Tag
        case 'X'
            if isequal(widget.panel_CentralTabsMRI.SelectedTab.Tag, 'CT')
                slider = widget.slider_X_CT;
                slider.Value = widget.slider_X_CT.Value - 1;
                new.Value = slider.Value; 
                sliderValueChanging(slider,new,widget);
            else
                slider = widget.slider_X_T1;
                slider.Value = widget.slider_X_T1.Value - 1;
                new.Value = slider.Value; 
                sliderValueChanging(slider,new,widget);
            end
        case 'Y'
            if isequal(widget.panel_CentralTabsMRI.SelectedTab.Tag, 'CT')
                slider = widget.slider_Y_CT;
                slider.Value = widget.slider_Y_CT.Value - 1;
                new.Value = slider.Value; 
                sliderValueChanging(slider,new,widget);
            else
                slider = widget.slider_Y_T1;
                slider.Value = widget.slider_Y_T1.Value - 1;
                new.Value = slider.Value; 
                sliderValueChanging(slider,new,widget);
            end
        case 'Z'
            if isequal(widget.panel_CentralTabsMRI.SelectedTab.Tag, 'CT')
                slider = widget.slider_Z_CT;
                slider.Value = widget.slider_Z_CT.Value - 1;
                new.Value = slider.Value; 
                sliderValueChanging(slider,new,widget);
            else
                slider = widget.slider_Z_T1;
                slider.Value = widget.slider_Z_T1.Value - 1;
                new.Value = slider.Value; 
                sliderValueChanging(slider,new,widget);
            end
    end
end