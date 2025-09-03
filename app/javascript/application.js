import "@hotwired/turbo-rails"
import "controllers"
import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()

import Rails from "@rails/ujs"
Rails.start()
