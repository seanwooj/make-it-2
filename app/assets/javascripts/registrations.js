//= include google_maps/autocompleteInit

window.mkit = window.mkit || {}

mkit.registrationsNew = (function($, mkit){
    var init = function(){
        mkit.initializeAutocomplete({map: true});
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