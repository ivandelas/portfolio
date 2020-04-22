// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("semantic-ui-sass")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

function attachFlashEvents() {
  $('.message .close').on('click', function() {
    $(this).closest('.message').transition('fade');
  });
}

$(document).on('turbolinks:load', function () {
  attachFlashEvents()

  $('.delete-btn').on('click', function (e) {
    const url = $(e.target).data('url')

    $('.ui.mini.modal').modal('show')

    $('.ui.mini.modal .ok.button').on('click', function (e) {
      $.ajax({
        type: 'DELETE',
        url: url
      }).done(function () {
        attachFlashEvents()
      })
    })
  })

  $('.ui.dropdown').dropdown()

  $('.toggle.button').on('click', function (e) {
    const url = $(e.target).data('url')

    $.ajax({
      type: 'PATCH',
      url: url
    }).done(function () {
      attachFlashEvents()
      $(e.target).toggleClass('active')

      if ($(e.target).hasClass('active')) {
        $(e.target).text('Active')
      } else {
        $(e.target).text('Inactive')
      }
    })
  })
});
