# Common Dialogs for replacing JavaScript alert/confirm/prompt.

This provides asynchronous alternatives to alert, confirm and prompt.

# Installing

Add "gem 'common-dialogs'" to your Gemfile and run bundle.

It also depends on jQuery-UI being installed. I recommend the
[jquery-ui-themes](https://github.com/fatdude/jquery-ui-themes-rails) gem.

Then require the bundled assets after requiring jQuery UI.

For example, if you're using the jquery-ui-themes gem, your application.js would look like this:

    //= require jquery
    //= require jquery_ujs
    //= require jquery-ui
    //= require common-dialogs
    CommonDialogs.require() // remove this if you don't want to add the helpers to the window object

And in application.css (see the supported themes list in the link above):

    /*
    = require jquery-ui/smoothness
    = require common-dialogs
    */

# Usage examples (in CoffeeScript for better readability)

```coffeescript
showMessage 'Any message' # Dialog title is "Message" by default
showMessage 'Any message', title: 'Dialog Title', onClose: (-> console.log 'closed'), additionalClasses: 'success popup'
# the CSS classes in additionalClasses will be added to the dialog div
# All dialogs support those options.
showError 'An error message with alert icon'
confirmDialog 'Really remove task?', (-> console.log 'confirmed'), noAction: -> console.log 'answered no - this option is not required'
inputDialog 'What is your name?', ((name)-> console.log "Your name is #{name}"),
  initialValue: 'Optional initial value'
  required: false # true by default, which means that an empty string is not allowed by default
  cancelAction: (-> console.log 'cancel was called - this option is not required')
```

# Custom messages and button names

Feel free to change the default messages and button names by changing the
CommonDialogs.defaults object. Just inspect it (console.log(CommonDialogs.defaults))
to see what keys to change and what are their default values.
