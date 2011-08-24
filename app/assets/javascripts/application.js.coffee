#= require json2
#= require jquery
#= require jquery_ujs
#= require underscore
#= require backbone
#= require string_score
#= require_tree .
#= require_self

class Application extends Backbone.View
  tagName: 'form'
  id: 'jobs-app'

  template: _.template("""
    <div class="shadow"></div>
    <div class="letter">
      <div class="viewport"></div>
    </div>
  """)

  events:
    'click .shadow': 'hide'
    'submit':        'submit'


  initialize: ->
    @pageView = new PageView()

    $(@el)
      .html(@template())
      .find('.viewport').append(@pageView.el)

  render: ->
    @pageView.render()

  show: ->
    $(@el).show()
    @$('.shadow').fadeIn(300)
    @$('.letter')
      .css(top: window.innerHeight)
      .animate({top: 0}, 300)

  hide: ->
    @$('.letter').animate {top: window.innerHeight}, 300
    @$('.shadow').fadeOut 300
    setTimeout (=> $(@el).hide()), 300

    # $(@el).hide()
    # .hide()

  submit: (e) ->
    e.preventDefault()

    alert @pageView.toJSON()


$(document).ready ->
  $('button').click (e) ->
    e.preventDefault()

    # Take the naming from Objective-C Cocoa
    window.App ||= do ->
      App = new Application()
      $('body').append App.el
      App.render()
      App

    App.show()
