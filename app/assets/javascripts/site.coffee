class window.Site extends Backbone.Model
  defaults:
    url: ''

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
    model = new Site()
    @collection.add(model)

  addSiteWithUrl: (url) ->
    siteModel = new Site(url: url)
    @collection.add(siteModel)

  addSite: (site) ->
    siteView = new SiteView(model: site)
    @$('.add-site').before(siteView.el)
    @siteViews.push siteView

  toJSON: ->
    view.toJSON() for view in @siteViews


class window.SiteView extends Backbone.View
  className: 'site'
  model: Site

  template: _.template("""
    <a class="remove">Remove</a>
    <div class="url">
      <span class="scheme">http://</span>
      <input type="text" value="<%= url %>" name="url" />
    </div>
    <div class="supported-sites"></div>

    <div class="description">
      <div class="followers"></div>
      <div class="gravatar"></div>
      <textarea placeholder="Description"></textarea>
    </div>
  """)

  template_bitbucket: _.template("""
    <div class="gravatar"></div>
    <div class="repositories"></div>
  """)

  events:
    'click .remove': 'hide'
    'blur .url input': 'fetchData'

  initialize: ->
    _.bindAll @, 'fetchData'

    @parser = new SiteParser()
    $(@el).html(@template(@model.toJSON()))

    @$('.supported-sites').html _.map(@supportedSites(), (name) ->
      "<span class=\"#{name}\">#{name}</span>"
    ).join(', ')

  render: ->


  hide: (e) ->
    @model.collection.remove(@model)
    @remove()

  fetchData: (e) ->
    @model.set url: $(e.target).val()

    result = @parser.parse(@model.get('url'))
    console.log $(e.target).val()
    console.log result
    if result
      username = result[1].username
      switch result[0]
        when "github"
          $.getJSON "http://github.com/api/v2/json/user/show/#{username}?callback=?", (data) =>
            @$('.description textarea').remove()
            @$('.description .followers').text "#{data.user.followers_count} followers"
            @$('.description .gravatar').html "<img src=\"http://www.gravatar.com/avatar/#{data.user.gravatar_id}\" />" if data.user.gravatar_id
            $('.name input').val(data.user.name) if $('.name input').val() == ""
            $('.email input').val(data.user.email) if $('.email input').val() == ""
            blogURL = data.user.blog.replace(/^http:\/\//, '')
            App.pageView.siteCollectionView.addSiteWithUrl(blogURL)
        when "bitbucket"
          $.getJSON "https://api.bitbucket.org/1.0/users/#{username}?callback=?", (data) =>
            console.log data
            @$('.description').html(@template_bitbucket)
            @$('.description .gravatar').html "<img src=\"#{data.user.avatar}\" />" if data.user.avatar
            @$('.description .repositories').html _.map(data.repositories, (repository) ->
              "<span><a href=\"#{repository.website}\">#{repository.name}</a></span>"
            ).join(', ')
            $('.name input').val(data.user.first_name + " " + data.user.last_name) if $('.name input').val() == ""
            $('.email input').val(data.user.email) if $('.email input').val() == ""


  supportedSites: ->
    [name for name, v of @parser.sites]

  toJSON: ->
    @model.toJSON(url: @$('.url input').val())

