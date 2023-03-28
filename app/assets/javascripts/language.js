#lang-toggle {
  border: none;
  background-color: transparent;
  background-image: url("flagFr.png"); /* image par défaut */
  background-repeat: no-repeat;
  background-size: contain;
  cursor: pointer;
  transition: all 0.3s ease;
}

/* Style pour le survol lorsque le document est en français */
:lang(fr) #lang-toggle:hover {
  background-image: url("/assets/images/flagEn.png"); /* image lors du survol */
}

/* Style pour le survol lorsque le document est en anglais */
:lang(en) #lang-toggle:hover {
  background-image: url("/assets/images/flagFr.png"); /* image lors du survol */
}