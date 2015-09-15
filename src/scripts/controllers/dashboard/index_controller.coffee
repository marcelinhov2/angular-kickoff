class DashboardIndex extends Controller
  constructor: (
    @$scope
  ) -> do @init
    
  init: =>
    do @declare_vars
    do @declare_scope_vars
    do @set_listeners

  declare_vars: ->
    console.log 'declare_vars'

  declare_scope_vars: ->
    console.log 'declare_scope_vars'

  set_listeners: ->
    console.log 'set_listeners'