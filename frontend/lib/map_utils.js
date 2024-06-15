let map;

function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: { lat: 0, lng: 0 },
    zoom: 13,
  });
}

function setMapCenter(lat, lng) {
  map.setCenter({ lat: lat, lng: lng });
}

function addPolyline(coordinates) {
  const path = coordinates.map(coord => ({ lat: coord.lat, lng: coord.lng }));
  new google.maps.Polyline({
    path: path,
    geodesic: true,
    strokeColor: '#FF0000',
    strokeOpacity: 1.0,
    strokeWeight: 2,
  }).setMap(map);
}

function addMarker(lat, lng) {
  new google.maps.Marker({
    position: { lat: lat, lng: lng },
    map: map,
  });
}
