window.repeat = (ms, fn) -> setInterval(fn, ms)

class window.PageView extends Backbone.View
  className: 'page'

  template: _.template("""
    <aside class="formal-details">
      <div class="address">
        <input type="text" placeholder="Address">
      </div>

      <div class="city">
        <input type="text" placeholder="City">
      </div>

      <div class="state">
        <input type="text" placeholder="State">
      </div>

      <div class="country">
        <input type="text" placeholder="Country">
      </div>
    </aside>

    <div class="editable">
      <p>Hello Atlassian!</p>

      <p>
        My name is <span class="name editable" contenteditable="true" data-placeholder="John Smith"></span>. I'd love to work with you guys. Helping developers is my passion and I think our talents would be perfect together.
      </p>
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

    @$('span[contenteditable=true]')
      .bind 'focus', ->
        input = $(@)
        if input.hasClass('placeholder')
          width = input.width()
          input
            .removeClass('placeholder')
            .text('')
            .addClass('empty')
            .css('width', width)
            .focus()

      .bind 'blur', ->
        input = $(@)
        if input.text() is ''
          input.addClass('placeholder').text(input.data('placeholder'))

      .blur()

    repeat 50, =>
      @$('span[contenteditable=true]').each ->
        input = $(@)
        if input.text() isnt ''
          input.removeClass('empty')



    # repeat 50, =>
    #   input = @$('span[contenteditable=true]')
    #   if input.text() is ''
    #     input.text input.data('placeholder')

    @siteCollectionView.addEmptySite()


  render: ->
    @siteCollectionView.render()

  toJSON: ->
    JSON.stringify
      name: @$('.name').text()

      address: @$('.address input').val()
      city: @$('.city input').val()
      state: @$('.state input').val()
      country: @$('.country input').val()

      email: @$('.email input').val()
      sites: @siteCollectionView.toJSON()

