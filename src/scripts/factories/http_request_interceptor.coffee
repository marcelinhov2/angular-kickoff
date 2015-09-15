class HttpRequestInterceptor extends Factory
  constructor: (
    @$q
    @$location
    @$rootScope
    @localStorageService
  ) ->
    @queue = []

    return {
      request: (config) =>
        @isTemplate = config.url.indexOf('.html') > 0

        # if !@isTemplate
          # @$rootScope.showLoader 'Carregando...'
        
        # config.headers.token = @userData.token || ''
        # config.headers.production = @userData.is_production || false
        
        return config
      
      requestError: (rejection) =>
        @isTemplate = rejection.config.url.indexOf('.html') > 0

        # if !@isTemplate
          # @$rootScope.handleError rejection.data

        _.remove @queue, rejection.config

        return @$q.reject rejection

      response: (response) =>
        _.remove @queue, response.config

        # if @queue.length is 0 then do @$rootScope.hideLoader
        
        return response or @$q.when(response)
      
      responseError: (rejection) =>
        @isTemplate = rejection.config.url.indexOf('.html') > 0

        # if !@isTemplate
        #   @$rootScope.handleError rejection.data

        _.remove @queue, rejection.config
        
        # if @queue.length is 0 then do @$rootScope.hideLoader

        return @$q.reject rejection
    }