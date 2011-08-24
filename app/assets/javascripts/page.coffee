class window.PageView extends Backbone.View
  className: 'page'

  template: _.template("""
    <section class="formal-details">
      <div class="address-line-1">
        <input type="text" placeholder="Address Line 1">
      </div>
      <div class="address-line-2">
        <input type="text" placeholder="Address Line 2">
      </div>

      <div class="address-city">
        <input type="text" placeholder="City">
      </div>

      <div class="address-state">
        <input type="text" placeholder="State">
      </div>
    </section>



    <p>Hi Atlassian!</p>

    <p>My name is</p>

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
      address:
        line1: @$('.address-line-1 input').val()
        line2: @$('.address-line-2 input').val()
        city: @$('.address-city input').val()
        state: @$('.address-state input').val()
      email: @$('.email input').val()
      sites: @siteCollectionView.toJSON()

