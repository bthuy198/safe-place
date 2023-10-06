# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'

pin_all_from 'app/javascript/admins', under: 'admins'

pin 'trix'
pin '@rails/actiontext', to: 'actiontext.js'

pin 'jquery', preload: true
pin 'jquery_ujs', preload: true
pin 'bootstrap', to: 'bootstrap.js', preload: true
pin 'popper', to: 'popper.js', preload: true
pin 'trix', to: 'https://unpkg.com/trix@2.0.0/dist/trix.umd.min.js'
