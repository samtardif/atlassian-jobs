module 'SiteParser',
  setup: ->
    @parser = new SiteParser();

test 'unsupported url', ->
  ok @parser.parse("foobar.com") is false

test 'github', ->
  url = 'github.com/chrislloyd'

  [service, details] = @parser.parse(url)

  ok(service)
  equal service, 'github'
  equal details.username, 'chrislloyd'

test 'dribbble', ->
  url = 'dribbble.com/chrislloyd'
  [service, details] = @parser.parse(url)

  ok(service)
  equal service, 'dribbble'
  equal details.username, 'chrislloyd'

test 'bitbucket', ->
  url = 'bitbucket.com/chrislloyd'
  [service, details] = @parser.parse(url)

  ok(service)
  equal service, 'bitbucket'
  equal details.username, 'chrislloyd'
