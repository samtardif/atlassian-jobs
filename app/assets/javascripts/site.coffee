class window.Site extends Backbone.Model
  defaults:
    url: ''

  initialize: (options) ->
    @set id: options.name.toLowerCase()

  url: ->
    params = '?' + ("#{key}=#{val}" for key, val of @get('args')).join('&')
    "/sites/#{@id}/#{params}"


class window.SiteCollection extends Backbone.Collection

class window.SiteCollectionView extends Backbone.View
  collection: SiteCollection

  template:  _.template("""
    <form class="url">
      <span class="scheme">http://</span>
      <input type="text" name="url" />
    </div>
    <p class="supported-sites"></p>
    <div class="site-views"></div>
  """)

  events:
    'submit form': 'submit'

  initialize: ->
    @parser = new SiteParser()
    @siteViews = []
    @collection.bind 'add', @addSiteView
    $(@el).html @template()

    # Populate list of supported sites
    @$('.supported-sites').html _.map(@supportedSites(), (name) ->
      console.log name
      "<span class=\"#{name.toLowerCase()}\">#{name}</span>"
    ).join(', ')

  render: ->
    for siteView in @siteViews
      siteView.render()

  submit: (e) =>
    e.preventDefault()
    url = @$('form input[name=url]').val()
    [name, args] = @parser.parse(url)
    @addSiteWithUrl(url, name, args)

  addSiteWithUrl: (url, name, args) ->
    siteModel = new Site(url: url, name: name, args: args)
    @collection.add(siteModel)

  addSiteView: (model) =>
    siteView = new SiteView(model: model)
    @$('.site-views').append(siteView.el)
    @siteViews.push siteView

  toJSON: ->
    (view.toJSON() for view in @siteViews).join("\n")

  supportedSites: ->
    name for name, v of @parser.sites


class window.SiteView extends Backbone.View
  tagName:   'section'
  className: 'site'
  model: Site

  template: _.template("""
    <a class="remove">Remove</a>

    <div class="content"></div>
  """)

  events:
    'click .remove': 'hide'

  initialize: ->
    $(@el).html(@template(@model.toJSON()))
    proto = @constructor[@model.get('name')]
    @siteView = new proto(model: @model)
    @$('.content').append(@siteView.el)
    @model.bind('change', @render)

  render: =>
    @siteView.render()

  hide: (e) ->
    @model.collection.remove(@model)
    @remove()

  toJSON: -> @siteView.toJSON()

  class @SiteContentView extends Backbone.View
    loadingTemplate: _.template("""
      <div class="loading">Loading &helip;</div>
    """)

    initialize: ->
      $(@el).html @loadingTemplate()
      @model.fetch
        success: =>
          try
            $(@el).html @render()
          catch e
            console.log 'There was an error rendering site template'
            throw e

        error: =>
          console.log 'there was an error loading this site'

    render: =>
      @template(@model.toJSON())

    toJSON: =>
      @report(@model.toJSON())

