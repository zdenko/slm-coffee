import { coffee } from "coffeescript"
import { slm } from "slm"

DEFAULT_EMBEDDED_NAME = 'coffee'
registeredInExpress = no

# slmCoffee.register(...) is to keep compatibility with existing Slm plugins
register = (template, engineName, options) ->
  engineName = DEFAULT_EMBEDDED_NAME unless engineName
  template.registerEmbeddedFunction engineName, (string) ->
    result = '<script type="text/javascript">'
    result += coffee.compile string
    result += '</script>'
    result
  coffee

# slmCoffee.__express(...) allows us to register as an ExpressJS template engine
__express = (filePath, options, callback) ->
  # Do not register every call
  unless registeredInExpress
    register slm.template, DEFAULT_EMBEDDED_NAME
    registeredInExpress = yes
  slm.__express filePath, options, callback

export {
  register
  __express
}
