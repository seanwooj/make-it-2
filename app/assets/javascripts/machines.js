//= include google_maps/autocompleteInit

window.mkit = window.mkit || {};

mkit.machineIndex = (function($){
    var init = function(){
        createHandlers();
        mkit.initializeAutocomplete({map:false})
        initMap(".map");
        mkit.machineIndex.$template = loadTemplate();
        searchFromQueryString();
    }

    var createHandlers = function(){
        $(".machine_search > input[type='submit']").on("click", function(e){
            e.preventDefault();
            searchRequest();
        });
    }

    var searchRequest = function(){
        var address = $('#address').val();
        var distance = $('#distance').val();
        var category = $('#category').val();
        getMachines(address,distance,category);
    }

    var searchFromQueryString = function(){
        var url = $.url();
        var address = url.param('search');
        var distance = url.param('distance');
        var category = url.param('category');
        getMachines(address,distance,category);
    }

    // todo: refactor
    var getMachines = function(address, distance, category){
        $(".ajax-loader").fadeIn('fast');
        $('.results').empty();
        $.get('/machines/search', {search: address, distance: distance, category: category}, function(data){
            window.machines = data;
            $(".ajax-loader").fadeOut('fast');
            $.each(data, function(index, machine){
                $result = mkit.machineIndex.$template.clone();
                $result.find(".machine_name").html(machine.name);
                $result.find(".machine_category").html(machine.category);
                $result.find(".machine_location").html(machine.address_info.city);
                $result.find(".link_to_machine").attr("href", machine.url);
                $('.results').append($result);
                $result = null;
            })
            showGoogleMapsResults(address);
        });
    }

    var showGoogleMapsResults = function(searchAddress){
        var geocoder = new google.maps.Geocoder
        geocoder.geocode({address: searchAddress}, function(results, status) {
            map.setCenter(results[0].geometry.location);
            map.setZoom(12);
        });

        $.each(machines, function(index, machine){
            new google.maps.Marker({
                map: map,
                id: machine.id,
                title: machine.name,
                position: new google.maps.LatLng(machine.address_info.lat, machine.address_info.lng)
            })
        });
    }

    var initMap = function(css_selector){
        var mapOptions = {
            center: new google.maps.LatLng(-34.397, 150.644),
            zoom: 1,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };

        // default to #map_canvas if there isn't anything else.
        if (css_selector) {} else {
            css_selector = "#map-canvas"
        }

        window.map = new google.maps.Map($(css_selector)[0], mapOptions);
    }

    var loadTemplate = function(){
        if (mkit.machineIndex.$template) {
            return mkit.machineIndex.$template;
        } else {
            var $template = $(".result-template").clone();
            $(".result-template").remove();
            $template.removeClass("result-template");
            return $template;
        }
    }

    return {
        init: init
    }

})(jQuery);
