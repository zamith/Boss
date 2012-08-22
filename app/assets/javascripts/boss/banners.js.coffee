$ ->
  $("#banners").slides
      container: 'banners-container'
      effect: 'fade'
      crossfade: true
      generatePagination: true
      hoverPause: true
      play: 5000
      preload: false
      pause: 2500
      prev: 'prev'
      next: 'next'

  Utils.setDatepickerWithTime(false)