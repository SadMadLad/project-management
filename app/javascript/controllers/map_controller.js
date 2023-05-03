import "leaflet-css"
import * as Leaflet from "leaflet"
import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static targets = ['map', 'latitude', 'longitude']
  static values = {
    latitude: { type: Number, default: 31.313131 },
    longitude: { type: Number, default: 70.31313 },
    isForm: { type: Boolean, default: false },
    isProject: { type: Boolean, default: false },
    isTask: { type: Boolean, default: false },
    projectCoordinates: { type: Array, default: [] }
  }

  icon() {
    const icon = Leaflet.icon({
      iconUrl: '/marker-icon.png',
      shadowUrl: '/marker-shadow.png'
    })

    return icon
  }

  // if it is a project map, loop over the tasks and render a marker for them with task's title as popup.
  ifIsProject(map) {
    map.on('move', () => map.invalidateSize())

    this.projectCoordinatesValue.forEach( taskInfo => {
      const [latitude, longitude, taskTitle] = taskInfo
      const marker = L.marker( [latitude, longitude], {icon: this.icon()} ).bindPopup(taskTitle)
      marker.addTo(map)
    })
  }

  // if is a form, allow it to change the coordinates for saving it.
  ifIsForm(map) {
    const popup = Leaflet.popup()
    const marker = Leaflet.marker([this.longitudeValue, this.latitudeValue], {icon: this.icon()} ).addTo(map)
    map.on('click', e => {
      popup
        .setLatLng(e.latlng)
        .setContent("You clicked the map at " + e.latlng.toString())
        .openOn(map)
      this.latitudeTarget.value = e.latlng.lat
      this.longitudeTarget.value = e.latlng.lng
      marker.setLatLng(e.latlng)
    })
  }

  // if is a task, place the marker the specified latitude and longitude
  ifIsTask(map) {
    const marker = L.marker([this.latitudeValue, this.longitudeValue], {icon: this.icon()} )
    marker.addTo(map)
  }

  mapTargetConnected() {
    const map = Leaflet.map(this.mapTarget).setView([this.latitudeValue, this.longitudeValue], 1.5)

    Leaflet.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 19,
      attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    }).addTo(map)

    if (this.isProjectValue === true) { this.ifIsProject(map) }
    if (this.isFormValue === true) { this.ifIsForm(map) }
    if (this.isTaskValue === true) { this.ifIsTask(map) }
  }
}
