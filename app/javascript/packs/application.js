// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "../styles/tailwind.scss"
import "../styles/general.css"

Rails.start()
Turbolinks.start()
ActiveStorage.start()


window.removeNotifications = function removeNotifications() {
    Object.values( document.querySelectorAll( ".rails-notification" ) ).map( (el) => {
        setTimeout( () => {
            deleteNotification( el )
        }, 4000 )
        el.addEventListener( 'click', () => {
            deleteNotification( el )
        } )
    } )

    function deleteNotification(el) {
        el.classList.remove( 'opacity-100' );
        el.classList.add( 'opacity-0' );
        setTimeout( () => {
            el.classList.add( 'hidden' );
            el.remove()
        }, 400 )
    }
}

document.addEventListener( 'turbolinks:load', () => {
    window.removeNotifications();
} )
