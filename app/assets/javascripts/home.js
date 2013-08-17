window.mkit = window.mkit || {};

mkit.homeIndex = (function($, mkit){
    var init = function(){
        mkit.initializeAutocomplete({map: false});
    }

    return {
        init: init
    }
})(jQuery, mkit)