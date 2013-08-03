function initializePage(){
    initMap();
    searchFromQueryString();

    $(".machine_search > input[type='submit']").on("click", function(e){
        e.preventDefault();
        searchRequest();
    });

    function searchRequest(){
        var address = $('#address').val();
        var distance = $('#distance').val();
        var category = $('#category').val();
        getMachines(address,distance,category);
    }

    function searchFromQueryString(){
        var url = $.url();
        var address = url.param('search');
        var distance = url.param('distance');
        var category = url.param('category');
        getMachines(address,distance,category);
    }

    function getMachines(address, distance, category){
        $(".ajax-loader").fadeIn('fast');
        $.get('/machines/search', {search: address, distance: distance, category: category}, function(data){
            window.machines = data;
            $(".ajax-loader").fadeOut('fast');
            $('.results').empty();
            $.each(data, function(index, machine){
                $('.results').append(machine["name"]).append(machine["address_info"]["address"]).append("<br/>");
            })
            showGoogleMapsResults(address);
        });
    }

    function showGoogleMapsResults(searchAddress){
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

    function initMap(){
        var mapOptions = {
            center: new google.maps.LatLng(-34.397, 150.644),
            zoom: 1,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        // Make sure this doesn't interfere with other google map elements
        window.map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
    }
}
