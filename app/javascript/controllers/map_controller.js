import "leaflet-css"
import * as Leaflet from "leaflet"
import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static targets = ['map', 'latitude', 'longitude']
  static values = {
    latitude: Number,
    longitude: Number,
    isForm: { type: Boolean, default: false },
    isProject: { type: Boolean, default: false },
    projectCoordinates: { type: Array, default: [] }
  }

  ifIsProject(map) {
    map.on('move', () => map.invalidateSize())

    const icon = Leaflet.icon({
      iconUrl: '/marker-icon.png',
      shadowUrl: '/marker-shadow.png'
    })

    this.projectCoordinatesValue.forEach( taskInfo => {
      const [latitude, longitude, taskTitle] = taskInfo
      const marker = L.marker([latitude, longitude], {icon: icon} ).bindPopup(taskTitle)
      marker.addTo(map)
    })
  }

  ifIsForm(map) {
    const popup = Leaflet.popup()

    map.on('click', e => {
      popup
        .setLatLng(e.latlng)
        .setContent("You clicked the map at " + e.latlng.toString())
        .openOn(map)
      this.latitudeTarget.value = e.latlng.lat
      this.longitudeTarget.value = e.latlng.lng
    })
  }

  mapTargetConnected() {
    const map = Leaflet.map(this.mapTarget).setView([this.latitudeValue, this.longitudeValue], 8)

    Leaflet.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 19,
      attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    }).addTo(map)

    if (this.isProjectValue === true) { this.ifIsProject(map) }
    if (this.isFormValue === true) { this.ifIsForm(map) }
  }
}
