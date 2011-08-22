class window.PageView extends Backbone.View
  className: 'page'

  template: _.template("""
    <div class="name">
      <label>Name</label>
      <input type="text" placeholder="John Smith"></input>
    </div>

    <div class="email">
      <label>Email</label>
      <input type="email" placeholder="email@example.com"></input>
    </div>

    <div class="sites"></div>

    <div>
      <button>Please consider my application</button>
    </div>
  """)

  initialize: ->
    $(@el)
      .html(@template())

    @sitesCollection = new SiteCollection()
    @siteCollectionView = new SiteCollectionView(
      collection: @sitesCollection
      el: @$('.sites')
    )

    @siteCollectionView.addEmptySite()


  render: ->
    @siteCollectionView.render()

  toJSON: ->
    JSON.stringify
      name: @$('.name input').val()
      email: @$('.email input').val()
      sites: @siteCollectionView.toJSON()
