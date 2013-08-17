//= include google_maps/autocompleteInit

window.mkit = window.mkit || {}

mkit.registrationsNew = (function($, mkit){
    var init = function(){
        mkit.initializeAutocomplete({
            map: true,
            latitude_form: "#user_locations_attributes_0_latitude",
            longitude_form: "#user_locations_attributes_0_longitude",
            city_form: "#user_locations_attributes_0_city"
        });
        preventEnter();
    }

    var preventEnter = function(){
        $(window).keydown(function(event){
            if(event.keyCode == 13) {
                event.preventDefault();
                return false;
            }
        });
    };

    return {
        init: init
    }

})(jQuery, mkit);