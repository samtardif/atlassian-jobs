class window.SiteParser

  compile = (url) ->
    identifiers = []
    segments = for segment in url.split('/')
      if id = segment.match(/^:/)
        identifiers.push segment.substring(1)
        # http://www.ietf.org/rfc/rfc1738.txt
        "([^/]+)"
      else
        segment

    r = new RegExp("^#{segments.join('/')}$")

    (str) ->
      if matches = str.match(r)
        matches.shift()
        _(identifiers).zip(matches).reduce(((memo, pair) ->
            memo[pair[0]] = pair[1]
            memo
          ), {})

      else
        false


  sites:
    github:    compile 'github.com/:username'
    dribbble:   compile 'dribbble.com/:username'
    bitbucket: compile 'bitbucket.com/:username'

  parse: (url) ->
    for name, fn of @sites when args = fn(url)
      return [name, args]

    return false

  score: (url) ->
    _.reduce @sites, ((memo, v, name) -> memo[name] = name.score(url); memo), {}

