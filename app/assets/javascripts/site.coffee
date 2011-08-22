class window.Site extends Backbone.Model

class window.SiteCollection extends Backbone.Collection

class window.SiteCollectionView extends Backbone.View
  collection: SiteCollection

  template:  _.template("""
    <div class="add-site">
      <a>Add another site</a>
    </div>
  """)

  events:
    'click .add-site': 'addEmptySite'

  initialize: ->
    _.bindAll @, 'addSite'
    @siteViews = []

    @collection.bind 'add', @addSite

    $(@el).html @template()

  render: ->
    for siteView in @siteViews
      siteView.render()

  addEmptySite: ->
    @collection.add({})

  addSite: (site) ->
    siteView = new SiteView(model: site)
    @$('.add-site').before(siteView.el)
    @siteViews.push siteView

class window.SiteView extends Backbone.View
  className: 'site'
  model: Site

  template: _.template("""
    <a class="remove">Remove</a>
    <div class="url">
      <span class="scheme">http://</span>
      <input type="text" />
    </div>
    <div class="supported-sites"></div>

    <textarea class="description">Foo Bar</textarea>
  """)

  events:
    'click .remove': 'hide'
    'keydown .url input': 'highlightSite'
    'change .url input': 'highlightSite'

  initialize: ->
    _.bindAll @, 'highlightSite'

    @parser = new SiteParser()
    $(@el).html(@template())
    # setInterval @highlightSite, 50

    @$('.supported-sites').html _.map(@supportedSites(), (name) ->
      "<span class=\"#{name}\">#{name}</span>"
    ).join(', ')

  render: ->


  hide: (e) ->
    @model.collection.remove(@model)
    @remove()

  highlightSite: ->
    console.log @parser.score(@$('.url input').val())
    # console.log (e.ta)

  supportedSites: ->
    [name for name, v of @parser.sites]

