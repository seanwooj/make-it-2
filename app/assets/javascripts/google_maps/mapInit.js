function initMap(){
    var mapOptions = {
        center: new google.maps.LatLng(-34.397, 150.644),
        zoom: 1,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    // Make sure this doesn't interfere with other google map elements
    window.map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

    var infowindow = new google.maps.InfoWindow();
    var marker = new google.maps.Marker({
        map: map
    });
}